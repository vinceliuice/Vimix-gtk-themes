#! /bin/bash
set -ueo pipefail

INDEX="assets.txt"

_parallel() {
	which parallel && parallel $@ || (
		while read i;
		do
			$1 $i
		done
	)
}

cat $INDEX | _parallel ./parallel.sh
exit 0
