#!/usr/bin/env python3

import http.client
import json
import os
import ssl
import sys

context = ssl.create_default_context()
context.check_hostname = False
context.verify_mode = ssl.CERT_NONE

argv = sys.argv[1:]
if len(argv) == 0 or not argv:
    sys.stderr.write("ERROR: enter your question\n")
    exit(1)
content = argv[0]

host = "api.groq.com"

payload = {
    # "model": "llama3-70b-8192",
    "model": "llama3-8b-8192",
    "messages": [{"role": "user", "content": content}],
}

# Set the content type header to application/json
headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer " + os.getenv("GROQ_API_KEY"),
}

# Create a request object
request = http.client.HTTPSConnection(
    host,
    context=context,
)

request.request("POST", "/openai/v1/chat/completions", json.dumps(payload), headers)

# Make the API call
response = request.getresponse()

# Check the response status code
if response.status == 200:
    text = response.read().decode("utf-8")
    parsed = json.loads(text)
    for choice in parsed["choices"]:
        sys.stdout.write(choice["message"]["content"])
else:
    sys.stderr.write(f"API call failed with status code: {response.status}\n")
