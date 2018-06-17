#!/usr/bin/env bash
docker build --no-cache -t mzquality .
docker run -it --rm -v $(pwd)/data:/data mzquality blank_effect --mea-file=/data/combined.tsv --blank-effect-file=/data/blank_effect.tsv && tail $(pwd)/data/blank_effect.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality rt_shifts --mea-file=/data/combined.tsv --rt-shifts-file=/data/rt_shifts.tsv && tail $(pwd)/data/rt_shifts.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality qc_correction --mea-file=/data/combined.tsv --qc-corrected-file=/data/qc_corrected.tsv && tail $(pwd)/data/qc_corrected.tsv