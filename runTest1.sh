#!/bin/bash

# run example dataset
python /files/mzQuality/qcli.py blank_effect --mea-file=/tmp/combined.tsv --blank-effect-file=/tmp/be.tsv
python /files/mzQuality/qcli.py rt_shifts --mea-file=/tmp/combined.tsv --rt-shifts-file=/tmp/rts.tsv

# compare output
if ! cmp -s "/tmp/blank_effect.tsv" "/tmp/be.tsv"; then
	echo "Blank effect files don't match!"
	cat /tmp/be.tsv
	cat /tmp/blank_effect.tsv
	exit 1
fi

if ! cmp -s "/tmp/rt_shifts.tsv" "/tmp/rts.tsv"; then
	echo "RT Shifts files don't match!"
	cat /tmp/rts.tsv
	cat /tmp/rt_shifts.tsv
	exit 1
fi

echo "All files are equal, success!"