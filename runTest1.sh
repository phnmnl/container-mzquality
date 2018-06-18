#!/bin/bash

# run example dataset
python /files/mzquality/qcli.py blank_effect --mea-file=/files/mzquality/data/combined.tsv --blank-effect-file=/files/mzquality/data/blank_effect_test.tsv
python /files/mzquality/qcli.py rt_shifts --mea-file=/files/mzquality/data/combined.tsv --rt-shifts-file=/files/mzquality/data/rt_shifts_test.tsv

# compare output
if ! cmp -s "/files/mzquality/data/blank_effect.tsv" "/files/mzquality/data/blank_effect_test.tsv"; then
	echo "Blank effect files don't match!"
	exit 1
fi

if ! cmp -s "/files/mzquality/data/rt_shifts.tsv" "/files/mzquality/data/rt_shifts_test.tsv"; then
	echo "RT shifts files don't match!"
	exit 1
fi

echo "All files are equal, success!"