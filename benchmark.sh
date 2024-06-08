#!/bin/bash
primes=("#x000003f5" "#x000007eb" "#x00000fef" "#x0000201b" "#x00003feb" "#x00007fcd" "#x0000fff1")
nonces=("#x73b0827dc98c" "#x8f6beed01b56" "#x9ad742038d67" "#x295f7ddd2dd7" "#xfe8113a9ba0c" "#xc0d795c6ab93") # chosen by fair dice roll, guaranteed to be random!
for p in "${primes[@]}"
do
for non in "${nonces[@]}"
do
    sed -e "s/p_constraint/(assert (=\ p\ $p))/" \
	-e "s/nonce_constraint/(assert (=\ nonce\ $non))/" \
	$1-ros.template | z3 -st -T:960 -in | grep ':time' | grep -Eo '[0-9]+\.[0-9]+' | tr -d '\n'
    printf ","
done
printf "\n"
done

