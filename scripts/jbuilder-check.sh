#!/bin/sh

rm -f yes-jbuild.txt no-jbuild.txt
for i in `cat $1`; do
  if opam info -f depends: $i |grep -q jbuild; then
    echo $i >> yes-jbuild.txt.pre
    echo $i : yes
  else
    echo $i >> no-jbuild.txt.pre
    echo $i : no
  fi
done

sort -u no-jbuild.txt.pre > no-jbuild.txt
grep -v ^conf- yes-jbuild.txt.pre | grep -v ^base- | grep -v ^jbuild | grep -v ocaml-src | sort -u > yes-jbuild.txt
