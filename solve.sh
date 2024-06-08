#!/bin/bash

phex=$(printf "%08x" $2)

sed 	-e "s/p_constraint/(assert (=\ p\ \#x$phex))/" \
	-e "s/nonce_constraint/(assert (=\ nonce\ $3))/" \
	$1-ros.template | z3 -st -T:960 -in
