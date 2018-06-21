#!/bin/bash

# run example dataset
python /files/mzQuality/qcli.py blank_effect --mea-file=/files/mzQuality/data/combined.tsv --blank-effect-file=/files/mzQuality/data/blank_effect_test.tsv
python /files/mzQuality/qcli.py rt_shifts --mea-file=/files/mzQuality/data/combined.tsv --rt-shifts-file=/files/mzQuality/data/rt_shifts_test.tsv

# compare output
if ! cmp -s "/files/mzQuality/data/blank_effect.tsv" "/files/mzQuality/data/blank_effect_test.tsv"; then
	echo "Blank effect files don't match!"
	exit 1
fi

if ! cmp -s "/files/mzQuality/data/rt_shifts.tsv" "/files/mzQuality/data/rt_shifts_test.tsv"; then
	echo "RT shifts files don't match!"
	exit 1
fi

echo "All files are equal, success!"