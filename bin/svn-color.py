#!/usr/bin/env python3

"""
Author: Saophalkun Ponlu (http://phalkunz.com)
Contact: phalkunz@gmail.com
Date: May 23, 2009
Modified: June 15, 2009

Additional modifications:
Author: Phil Christensen (http://bubblehouse.org)
Contact: phil@bubblehouse.org
Date: February 22, 2010

Additional modifications:
Author: Beau Hoyt (http://beauhoyt.com)
Contact: beau.g.hoyt@gmail.com
Date: September 3, 2013
"""

import sys
import re
import subprocess

tabsize = 4

colorizedSubcommands = (
    'status',
    'add',
    'remove',
    'diff',
    'log',
)

statusColors = {
    "M":    "31",     # red
    "\?":   "37",     # grey
    "A":    "32",     # green
    "X":    "33",     # yellow
    "C":    "30;41",  # black on red
    "-":    "31",     # red
    "D":    "31;1",   # bold red
    "\+":   "32",     # green
    "r\d+": "33",     # yellow
}


def colorize(line):
    line = line.decode('utf-8')
    for color in statusColors:
        if re.match(color, line):
            return ''.join(
                ("\001\033[", statusColors[color], "m", line, "\033[m\002"))

    return line


def escape(s):
    s = s.replace('$', r'\$')
    s = s.replace('"', r'\"')
    s = s.replace('`', r'\`')
    return s

passthru = lambda x: x
quoted = lambda x: '"%s"' % escape(x)

if __name__ == "__main__":
    cmd = ' '.join(
        ['svn'] +
        [(passthru, quoted)[' ' in arg](arg) for arg in sys.argv[1:]])

    output = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    cancelled = False

    for line in output.stdout:
        line = line.expandtabs(tabsize)

        if sys.argv[1] in colorizedSubcommands:
            line = colorize(line)
            try:
                sys.stdout.write(line)
            except:
                sys.exit(1)
