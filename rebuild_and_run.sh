#!/usr/bin/env bash
docker build --no-cache -t mzquality .
docker run -it --rm -v $(pwd)/data:/data mzquality summary --mea-file=/data/combined.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality blank_effect --mea-file=/data/combined.tsv --blank-effect-file=/data/blank_effect.tsv && tail $(pwd)/data/blank_effect.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality blank_effect --mea-file=/data/combined.tsv --blank-effect-file=/data/batch_blank_effect.tsv --by-batch=True && tail $(pwd)/data/batch_blank_effect.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality rt_shifts --mea-file=/data/combined.tsv --rt-shifts-file=/data/rt_shifts.tsv && tail $(pwd)/data/rt_shifts.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality qc_correction --mea-file=/data/combined.tsv --qc-corrected-file=/data/qc_corrected.tsv && tail $(pwd)/data/qc_corrected.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality qc-rsd --qc-corrected-file=/data/qc_corrected.tsv --qc-rsd-file=/data/rsdqc.tsv && tail $(pwd)/data/rsdqc.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality qc-rsd --qc-corrected-file=/data/qc_corrected.tsv --qc-rsd-file=/data/batch_rsdqc.tsv --by-batch=True && tail $(pwd)/data/batch_rsdqc.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality rep-rsd --qc-corrected-file=/data/qc_corrected.tsv --rep-rsd-file=/data/rsdrep.tsv && tail $(pwd)/data/rsdrep.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality rep-rsd --qc-corrected-file=/data/qc_corrected.tsv --rep-rsd-file=/data/batch_rsdrep.tsv --by-batch=True && tail $(pwd)/data/batch_rsdrep.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality internal-standard-rsd --qc-corrected-file=/data/qc_corrected.tsv --is-rsd-file=/data/rsdis.tsv && tail $(pwd)/data/rsdis.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality internal-standard-rsd --qc-corrected-file=/data/qc_corrected.tsv --is-rsd-file=/data/batch_rsdis.tsv --by-batch=True && tail $(pwd)/data/batch_rsdis.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality export_measurements --file=/data/combined.tsv --column=area --export_location=/data/area.tsv --include_is=True && tail $(pwd)/data/area.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality export_measurements --file=/data/combined.tsv --column=ratio --export_location=/data/ratio.tsv --include_is=True && tail $(pwd)/data/ratio.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality export_measurements --file=/data/qc_corrected.tsv --column=inter_median_qc_corrected --export_location=/data/qc_inter.tsv --include_is=True && tail $(pwd)/data/qc_inter.tsv
docker run -it --rm -v $(pwd)/data:/data mzquality plot_compound --qc-corrected-file=/data/qc_corrected.tsv --compound=Inositol --plot-location=/data/plots
docker run -it --rm -v $(pwd)/data:/data mzquality plot_compounds --qc-corrected-file=/data/qc_corrected.tsv --plot-location=/data/plots
docker run -it --rm -v $(pwd)/data:/data mzquality plot_compounds_zipped --qc-corrected-file=/data/qc_corrected.tsv --zip-file=/data/plots.zip