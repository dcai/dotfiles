#!/usr/bin/env python
import random
import socket
import subprocess

hostname = socket.gethostname()

animals = (
    "beavis.zen",
    "blowfish",
    "bong",
    "bud-frogs",
    "bunny",
    "cheese",
    "cower",
    "daemon",
    "default",
    "dragon",
    "dragon-and-cow",
    "elephant",
    "elephant-in-snake",
    "eyes",
    "flaming-sheep",
    "ghostbusters",
    "head-in",
    "hellokitty",
    "kiss",
    "kitty",
    "koala",
    "kosh",
    "luke-koala",
    "meow",
    "milk",
    "moofasa",
    "moose",
    "mutilated",
    "ren",
    "satanic",
    "sheep",
    "skeleton",
    "small",
    "sodomized",
    "stegosaurus",
    "stimpy",
    "supermilker",
    "surgery",
    "telebears",
    "three-eyes",
    "turkey",
    "turtle",
    "tux",
    "udder",
    "vader",
    "vader-koala",
    "www",
)

animal = random.choice(animals)

subprocess.call(["cowsay", "-f", animal, "Welcome to %s!" % hostname])
