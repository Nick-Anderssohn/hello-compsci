#!/bin/bash

cd home
rm -rf .packages
rm pubspec.lock
pub get
cd ..

cd about
rm -rf .packages
rm pubspec.lock
pub get
cd ..
