#!/bin/sh

# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org/>


# GUI-less Skype runner.
# Author: Renzo Carbonara <gnuk0001@gmail.com>
#
# Using the Skype client on GNU/Linux is a PITA. Luckily, the Skype GUI
# client publishes both D-Bus and X11 APIs so that other client
# interfaces can be used, instead of the official GUI client. However,
# even if you are not actually using the official Skype GUI, you need
# the client running on the backg-- foreground so that the these API
# services can be accessed, which of course, is annoying.
#
# This script makes it a bit more pleasant by running the Skype GUI on a
# different X server using Xvfb [0], so that you don't actually see the
# Skype GUI and the Skype API clients can continue to use it.
#
#
# USAGE:
#
# First, make sure you have configured the Skype client to automatically
# sing in when it starts.
#
# To run `program-name [program-args, ...]` along with a GUI-less Skype
# client:
#
#   ./skype-guiless program-name [program-args, ...]
#
#
# EXAMPLE:
#
# This starts a GUI-less Skype client, and then starts the excellent
# BitlBee Skype plugin [1]:
#
#   ./skype-guiless skyped --nofork -c $HOME/.skyped/skyped.conf
#
#
# [0] Xvfb: http://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml
# [1] BitlBee Skype plugin: http://vmiklos.hu/project/bitlbee-skype/


# Change this if you have another X Server numbered 17 (probably not).
x_display=":17"

# Xvfb to the rescue.
Xvfb "${x_display}" &
export DISPLAY="${x_display}"

# We wait a second here to make sure the Xvfb process running on the
# background has (hopefully) started.
sleep 1s
skype &

# We wait a second here to make sure the skype process running on the
# background has (hopefully) started.
sleep 1s
exec ${*}

