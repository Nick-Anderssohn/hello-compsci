#!/bin/bash

# build home
cd client/home
pub get
pub build
cd ../..
mkdir -p build/home
cp -a client/home/build/. build/home/

# build about
cd client/about
pub get
pub build
cd ../..
mkdir -p build/about
cp -a client/about/build/. build/about/
