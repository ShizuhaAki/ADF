#!/usr/bin/env bash
node fetch.js
# Check whether the hash of the SPEC changed
if sha256sum --check build/SPECS/dingtalk-bin.spec.sha256sum;
then
    echo "No rebuild needed."
    exit
fi
cd build
mkdir -p $HOME/rpmbuild/SPECS
cp SPECS/* $HOME/rpmbuild/SPECS/
cp SOURCES/* $HOME/rpmbuild/SOURCES
cd $HOME/rpmbuild
sudo dnf builddep SPECS/dingtalk-bin.spec
spectool -gR SPECS/dingtalk-bin.spec
rpmbuild -ba SPECS/dingtalk-bin.spec
