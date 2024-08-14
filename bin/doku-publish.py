#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import http.client
import logging
import os
import re
import ssl
import subprocess
import sys
from urllib.parse import urlparse

logger = logging.getLogger(__file__)
logging.basicConfig(encoding="utf-8", level=logging.DEBUG)


def publish(host, url, filetype, payload):
    doku_token = os.environ.get("DOKU_TOKEN", None)
    if not doku_token:
        logger.error("ERROR: Missing DOKU_TOKEN")
        exit(1)
    try:
        conn = http.client.HTTPSConnection(
            host, context=ssl._create_unverified_context()
        )
        headers = {
            "Content-Type": f"text/{filetype}",
            "Authorization": f"Bearer {doku_token}",
        }
        conn.request("PUT", url, payload, headers)
        resp = conn.getresponse()
        logger.info(f"API Status: {resp.status} {resp.reason}")
        data = resp.read()
        return data.decode("utf-8")
    except Exception as e:
        logger.error(f"Http Error: {e}")


def read_markdown_metadata(markdown_text):
    """
    Reads Markdown metadata from the given text.

    Args:
        markdown_text (str): The Markdown text containing the metadata.

    Returns:
        dict: A dictionary containing the metadata key-value pairs.
    """
    metadata_pattern = r"---\n(.*?)\n---"
    metadata_match = re.search(metadata_pattern, markdown_text, re.DOTALL)

    if metadata_match:
        metadata_text = metadata_match.group(1)
        metadata = {}
        for line in metadata_text.split("\n"):
            key, value = line.split(": ", 1)
            metadata[key] = value.strip()
        return metadata
    else:
        return {}


def doku_weburl_to_apiurl(weburl):
    parsed = urlparse(weburl)
    hostname = parsed.netloc
    path = parsed.path
    return hostname, f"/_api/page{path}"


def pandoc(input, output):
    # output = "/tmp/output.dokuwiki"
    to_format = "dokuwiki"
    from_format = "gfm"
    subprocess.run(
        ["pandoc", "-f", from_format, "-t", to_format, "-o", output, input],
        check=True,
    )


if __name__ == "__main__":
    argv = sys.argv[1:]

    if len(argv) == 0 or not argv:
        logger.error("ERROR: Provide a filename")
        exit(1)

    input_file = argv[0]
    input_filetype = "markdown"
    try:
        text = open(input_file, "r").read()
        metadata = read_markdown_metadata(text)
        doku_weburl = metadata.get("doku", metadata.get("dokuwiki"))
        if doku_weburl:
            hostname, url = doku_weburl_to_apiurl(doku_weburl)
            if hostname and url:
                payload = publish(hostname, url, input_filetype, text)
                print("Published to Dokuwiki:")
                print(doku_weburl)
            else:
                logger.error("ERROR: api host and url not found")
                exit(1)
        else:
            logger.error("ERROR: Missing dokuwiki metadata")
            exit(1)
    except Exception as e:
        logger.error(f"Error: {e}")
