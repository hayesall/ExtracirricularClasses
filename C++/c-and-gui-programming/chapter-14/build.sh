#!/usr/bin/env bash

gcc `pkg-config --cflags gtk+-2.0` listing01.c `pkg-config --libs gtk+-2.0`
