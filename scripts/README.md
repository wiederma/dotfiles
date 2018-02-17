These are some scripts I use from time to time

# Shell
Since I am using i3wm as window manager on all my Linux computers with a GUI, I have the need to change display settings some times (laptop goes to docking station).

Using the tool xrandr does the trick, see 1xt470s.sh or 3xt470s.sh. The tool arandr is a GUI to setup the i3wm display configuration.

These tools can be installed using:

    sudo apt install xrandr, arandr

In most cases

    xrandr --auto

fixes most of the issues

## fish

## bash

Starting different applications with parameters using a bash script as shortcut.

+ ffire: starts firefox in private mode
+ i3exit: exit handler for i3wm
+ mws: move i3wm workspaces as a whole, script moves workspace by default to a screen located left of the current screen
+ nau: starts nautilus explorer without desktop


# Python

## Using UNIX pipes
This examples shows how to pipe data printed to std out via UNIX pipes to another application reading via std in

1) start netcat listener (listen: -l, port: -p):

    nc -l -p 8080

2) make python app executable

    chmod u+x python_template.py

3) run python app and pipe output to netcat (nc host port):

    ./python_template.py --sleeptime 2 | nc localhost 8080
