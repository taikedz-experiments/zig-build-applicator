#!/usr/bin/env python3

import sys
import argparse
import pyparsing as pp

"""
Rough grammar:

STRUCT = ".{" { PAIRLIST | VALUELIST } "}"

PAIRLIST = PAIR [ "," [ PAIRLIST ] ]
PAIR = NAME "=" VALUE

VALUELIST = VALUE [ "," [ VALUELIST ] ]

VALUE = { STRING | NUMBER | BOOL | STRUCT }

NAME = '\.[a-zA-Z_][a-zA-Z0-9_]*'
STRING = '"[^"]*"'
NUMBER = "[0-9]+(\.[0-9]+)?"
BOOL = "true|false"

"""

NAME = r'\.[a-zA-Z_][a-zA-Z0-9_]*'
STRING = r'"[^"]*"' # doesn't handle escaped strings
NUMBER = r"[0-9]+(\.[0-9]+)?"
BOOL = r"true|false"

DOT,LBR,EQ,RBR,COM = map(pp.Suppress, ".{=},")
VALUE = pp.Group( (NAME | NUMBER | BOOL | STRUCT) + COM) # cyclical !!
PAIR = pp.Group(NAME + EQ + VALUE)
PAIRLIST = pp.ZeroOrMor(PAIR)
VALUELIST = pp.ZeroOrMore(VALUE)
STRUCT = pp.Group(DOT+LBR + (PAIRLIST | VALUELIST) + RBR)


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("zonfile")
    return parser.parse_args()


def main():
    args = get_args()


if __name__ == "__main__":
    main()
