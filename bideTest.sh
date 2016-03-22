#! /bin/bash

# Get the bide functions
source $HOME/bide/bideLib.sh

# checks if the strings returned are equal, prints
# error if they are not, prints nothing if they are.
#
# usage: testEqual expected actual
testEqual() {
	expected="$2"
	actual="$1"
	if [ "$expected" != "$actual" ]; then
		printf "FAIL: expected: \"%s\" actual: \"%s\"\n" $expected $actual
	fi
}

# checks if the strings returned are equal, prints
# error if they are not, prints nothing if they are.
#
# usage: testNotEqual expected actual
testNotEqual() {
	expected="$2"
	actual="$1"
	if [ ! "$expected" != "$actual" ]; then
		printf "FAIL: expected: \"%s\" actual: \"%s\"\n" $expected $actual
	fi
}

# testEqual and testNotEqual tests
testEqual "" ""
testNotEqual "" "foo"
testEqual "bar" "bar"

# ret tests
empty=""
two="foo bar"
one="foo"

testEqual "$(ret $empty)" "$empty"
testEqual "$(ret $one)" "$one"
testEqual "$(ret $two)" "$two"
testNotEqual "$(ret $two)" "$one"
testNotEqual "$(ret $empty)" "$one"

# key val tests
k="k"
v="v"
kk="kk"
vv="vv"
kv="k:v"
kkvv="kk:vv"
nodelim="kk;vv"
nokey=":vv"
novkl="kk:kk"

testEqual "$(key $kv)" "$k"
testNotEqual "$(key $kv)" "$v"
testEqual "$(key $kkvv)" "$kk"
testNotEqual "$(key $kkvv)" "$vv"

testEqual "$(val $kv)" "$v"
testNotEqual "$(val $kv)" "$k"
testEqual "$(val $kkvv)" "$vv"
testNotEqual "$(val $kkvv)" "$kk"

# getName and getExtension tests
n="foo"
e="bar"
a="baz"
ne="foo.bar"
nea="foo.bar.baz"
nempty=".bar"
eempty="foo."

testEqual "$(getName $ne)" "$n"
testNotEqual "$(getName $ne)" "$e"
testEqual "$(getName $n)" "$n"
testNotEqual "$(getName $n)" "$e"
testEqual "$(getName $nea)" "$n"
testNotEqual "$(getName $nea)" "$e"
testEqual "$(getName $nempty)" ""
testNotEqual "$(getName $nempty)" "$e"
testEqual "$(getName $eempty)" "$n"
testNotEqual "$(getName $eempty)" "$e"

testEqual "$(getExt $ne)" "$e"
testNotEqual "$(getExt $ne)" "$n"
testEqual "$(getExt $n)" ""
testNotEqual "$(getExt $n)" "$e"
testEqual "$(getExt $nea)" "$a"
testNotEqual "$(getExt $nea)" "$e"
testEqual "$(getExt $nempty)" "$e"
testNotEqual "$(getExt $nempty)" "$n"
testEqual "$(getExt $eempty)" ""
testNotEqual "$(getExt $eempty)" "$e"

# getAction tests
empty=""
u="usage"
ri="r"
rr="run"
rbad="ran"

testEqual "$(getAction $empty)" "$u"
testNotEqual "$(getAction $empty)" "$rr"
testEqual "$(getAction $ri)" "$rr"
testNotEqual "$(getAction $ri)" "$ri"
testEqual "$(getAction $rbad)" "$u"
testNotEqual "$(getAction $rbad)" "$rr"

# getScript tests
file="test.c"
none="test.tuhaetosnu"
noext="test"
script="$runDir/c.sh"
def="$runDir/default.sh"

testEqual "$(getScript $file $runDir)" "$script"
testNotEqual "$(getScript $file $runDir)" "$def"
testEqual "$(getScript $none $runDir)" "$def"
testNotEqual "$(getScript $none $runDir)" "$script"
testEqual "$(getScript $noext $runDir)" "$def"
testNotEqual "$(getScript $noext $runDir)" "$script"

