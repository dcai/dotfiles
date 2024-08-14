#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import zipfile

# print("Processing File " + sys.argv[1])

file = zipfile.ZipFile(sys.argv[1], "r")
for name in file.namelist():
    utf8name = name.encode("cp437").decode("gbk")
    print("Extracting " + utf8name)
    pathname = os.path.dirname(utf8name)
    if not os.path.exists(pathname) and pathname != "":
        os.makedirs(pathname)
    bytesData = file.read(name)
    if not os.path.exists(utf8name):
        fo = open(utf8name, "wb")
        fo.write(bytesData)
        fo.close()
file.close()
