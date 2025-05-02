#!/bin/bash

BASEDIR=$(dirname $0)

cd "$BASEDIR"

dart compile exe bin/ff.dart -o ../fftmp;
if [ "$(uname)" == "Darwin" ]; then
  mv ../fftmp ../ff;

  echo "Please check ./ff"
else
  mv ../fftmp ../ffarm;

  echo "Please check ./ffarm"
fi