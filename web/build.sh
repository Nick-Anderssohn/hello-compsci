#!/bin/bash

cd client
pub get
pub build
cd ..
mkdir -p build
cp -a client/build/. build/
