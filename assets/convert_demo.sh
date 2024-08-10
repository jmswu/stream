#!/bin/bash

ffmpeg -i demo.webm -vf "fps=10,scale=960:-1" demo.gif
