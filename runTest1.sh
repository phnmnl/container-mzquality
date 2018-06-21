#!/bin/bash

# run example dataset
python /files/mzQuality/qcli.py blank_effect --mea-file=/files/mzQuality/data/combined.tsv --blank-effect-file=/tmp/be.tsv

# compare output
if ! cmp -s "/files/mzQuality/data/blank_effect.tsv" "/tmp/be.tsv"; then
	echo "Blank effect files don't match!"
	cat "/tmp/be.tsv"
	cat /tmp/be.tsv
	cat "/files/mzQuality/data/blank_effect.tsv"
	cat /files/mzQuality/data/blank_effect.tsv
	exit 1
fi

echo "All files are equal, success!"