#!/usr/bin/env python
import asyncore
import logging
import smtpd

logfile = "/tmp/smtp.log"


class fakesmtp(smtpd.SMTPServer):
    def process_message(self, peer, mailfrom, rcpttos, data):
        with open(logfile, "a+") as f:
            inheaders = 1
            lines = data.split("\n")
            f.write("---------- MESSAGE FOLLOWS ----------\n\r")
            for line in lines:
                # headers first
                if inheaders and not line:
                    f.write("X-Peer: %s" % peer[0])
                    f.write("\n\r")
                    inheaders = 0
                f.write(line)
                print(line)
                f.write("\n\r")
            f.write("------------ END MESSAGE ------------\n\r")
            f.close()


server = fakesmtp(("127.0.0.1", 50010), None)

try:
    while True:
        asyncore.loop()
except KeyboardInterrupt:
    pass

print("Shutting down")
