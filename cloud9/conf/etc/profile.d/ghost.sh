#!/bin/bash

if [ -d /ghost/.bin ]; then
    PATH="/ghost/.bin:$PATH"
fi
