#!/bin/bash

script_dir=`pwd`

lcc="${script_dir}/.lcc"
lcc_linux="${script_dir}/.lcc/linux-64"
lcc_osx="${script_dir}/.lcc/osx-64"
mkdir -p $lcc_linux
mkdir -p $lcc_osx

for d in p1 p2
do
  pushd $d
  conda index $lcc_linux
  conda index $lcc_osx
  pf=`conda build . --output`
  echo $pf
  conda build -q --channel "file://${lcc}" . | tee -a build.log 2>&1
  popd
done

