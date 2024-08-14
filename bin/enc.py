#!/usr/bin/env python3

import base64
import hashlib
import http.client
import json
import os
import re
import ssl
import sys
import urllib.parse

context = ssl.create_default_context()
context.check_hostname = False
context.verify_mode = ssl.CERT_NONE
known_actions = [
    "urlencode",
    "urldecode",
    "md5",
    "sha1",
    "sha256",
    "jwt",
    "base64encode",
    "base64decode",
]

argv = sys.argv[1:]

if len(argv) == 0 or not argv:
    print("ERROR: action and value", known_actions)
    exit(1)

action = argv[0]
value = ""

if not os.isatty(0):
    value = sys.stdin.read()
else:
    # print("standard behavior")
    value = argv[1]


def switch(action):
    out = ""
    if action == "urlencode":
        out = urllib.parse.quote_plus(value)
    if action == "urldecode":
        out = urllib.parse.unquote_plus(value)
    if action == "md5":
        out = hashlib.md5(value.encode()).hexdigest()
    if action == "sha1":
        out = hashlib.sha1(value.encode()).hexdigest()
    if action == "sha256":
        out = hashlib.sha256(value.encode()).hexdigest()
    if action == "sha256":
        out = hashlib.sha256(value.encode()).hexdigest()
    if action == "base64encode":
        out = base64.b64encode(value.encode("utf-8")).decode("utf-8")
    if action == "base64decode":
        out = base64.b64decode(value).decode("utf-8")
    if action == "jwt":
        header, payload, signature = value.split(".")
        jsonstr = base64.b64decode((payload + "==").encode("ascii")).decode("utf-8")
        jsonobj = json.loads(jsonstr)
        out = json.dumps(jsonobj, indent=2)
    if action == "escape":
        out = json.dumps(value)
    if action == "unescape":
        out = urllib.parse.unquote_plus(value)
    sys.stdout.write(out)


switch(action)
