#!/bin/sh

rm -f yes-jbuild.txt no-jbuild.txt
for i in `cat $1`; do
  if opam info -f depends: $i |grep -q jbuild; then
    echo $i >> yes-jbuild.txt.pre
    echo $i : yes
    opam show -f dev-repo: $i >> repos.txt.pre
  else
    echo $i >> no-jbuild.txt.pre
    echo $i : no
  fi
done

sort -u no-jbuild.txt.pre > no-jbuild.txt
grep -v ^conf- yes-jbuild.txt.pre | grep -v ^base- | grep -v ^jbuild | grep -v ocaml-src | sort -u > yes-jbuild.txt
cat repos.txt.pre | sed -e 's,git+http:,git:,g' | sed -e 's,git+https:,git:,g' | sort -u > repos.txt
mkdir repos
for i in `cat repos.txt`; do git -C repos clone $i; done
