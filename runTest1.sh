#!/bin/bash

# run example datasets
python /files/mzquality/qcli.py blank_effect --mea-file=/files/mzquality/data/combined.tsv --blank-effect-file=/files/mzquality/data/blank_effect.tsv

# compare output
if ! cmp -s "/files/ms-vfetc/data/tmp/agilent.txt" "/tmp/agilent.txt"; then
	echo "Agilent files don't match!"
	exit 1
fi

echo "All files created successfully"