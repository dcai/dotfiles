#!/usr/local/bin/python3

import io
import os
import re
import subprocess
import sys

TEMPEXT = ".temp"
MKVMERGE = "/usr/local/bin/mkvmerge"
# change this for other languages (3 character code)
LANG = "eng"
SCRIPTNAME = os.path.basename(sys.argv[0])

# regex
AUDIO_RE = re.compile(
    r"Track ID (\d+): audio \([A-Za-z0-9_/]+\) [audio_channels:\d+ number:\d+ uid:\d+ codec_id:[A-Z0-9_/]+ codec_private_length:\d+ language:([a-z]{3})"
)
SUBTITLE_RE = re.compile(
    r"Track ID (\d+): subtitles \([A-Za-z0-9_/]+\) \[(.*?) language:([a-z]{3}) (.*?)\]"
)


if len(sys.argv) < 2:
    print("{}: try with [dir]".format(SCRIPTNAME))
    sys.exit()

in_dir = sys.argv[1]

for root, dirs, files in os.walk(in_dir):
    for f in files:

        # filter out non mkv files
        if not f.endswith(".mkv"):
            continue

        # path to file
        path = os.path.join(root, f)

        # build command line
        cmd = [MKVMERGE, "--identify-verbose", path]

        mkvmerge = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout, stderr = mkvmerge.communicate()
        if mkvmerge.returncode != 0:
            print(
                "=> {} {}".format("mkvmerge failed to identify", path), file=sys.stderr
            )
            continue

        # find audio and subtitle tracks
        audio = []
        subtitle = []
        for line in io.BytesIO(stdout):
            m = AUDIO_RE.match(line.decode("utf-8"))
            if m:
                audio.append(m.groups())
            else:
                m = SUBTITLE_RE.match(line.decode("utf-8"))
                if m:
                    subtitle.append(m.groups())

        # filter out files that don't need processing
        # if len(audio) < 2 and len(subtitle) < 2:
        # print("=> {} {}".format("nothing to do for", path), file=sys.stderr)
        # continue

        # filter out tracks that don't match the language
        # audio_lang = list(filter(lambda track: track[2]==LANG, audio))
        subtitle_lang = list(filter(lambda track: track[2] == LANG, subtitle))
        # filter out files that don't need processing
        # if len(audio_lang) == 0 and len(subtitle_lang) == 0:
        # print("=> {} {}".format("no tracks with that language in", path), file=sys.stderr)
        # continue

        # build command line
        cmd = [MKVMERGE, "-o", path + TEMPEXT]
        # if len(audio_lang):
        # cmd += ["--audio-tracks", ",".join([str(a[0]) for a in audio_lang])]
        # for i in range(len(audio_lang)):
        # cmd += ["--default-track", ":".join([audio_lang[i][0], "0" if i else "1"])]

        if len(subtitle_lang):
            cmd += ["--subtitle-tracks", ",".join([str(s[0]) for s in subtitle_lang])]
            for i in range(len(subtitle_lang)):
                cmd += ["--default-track", ":".join([subtitle_lang[i][0], "yes"])]
        cmd += [path]

        # print("=> {}".format(' '.join(cmd)))
        print("=> {}".format(path))
        mkvmerge = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout, stderr = mkvmerge.communicate()
        if mkvmerge.returncode != 0:
            print("✘ Failed", file=sys.stderr)
            continue
        print("✓ Succeeded", file=sys.stderr)

        # overwrite file
        os.rename(path, path + ".bak")
        os.rename(path + TEMPEXT, path)
