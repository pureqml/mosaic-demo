#!/bin/sh

./qmlcore/build -m

git checkout gh-pages
git pull
cp -r build.web/qml.app.min.js .

git add qml.app.min.js

git commit -a -m "updated site"
git pull
git push
git checkout master
