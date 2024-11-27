scripts/beaker/ladder-launch.sh 1 normal --model 300M --data no_code --length 5xC --name no_code-adafactor-batch-20 --save_overwrite
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data no_math_no_code --length 5xC --name no_math_no_code-adafactor-batch-20 --save_overwrite
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data no_reddit --length 5xC --name no_reddit-adafactor-batch-20 --save_overwrite
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data no_flan --length 5xC --name no_flan-adafactor-batch-20 --save_overwrite
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data dolma17 --length 5xC --name dolma17-adafactor-batch-20 --save_overwrite
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data falcon --length 5xC --name falcon-adafactor-batch-20 --save_overwrite
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data falcon_and_cc --length 5xC --name falcon_and_cc-adafactor-batch-20 --save_overwrite
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data c4 --length 5xC --name c4-adafactor-batch-20 --save_overwrite
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data prox_fineweb_pro --length 5xC --name prox_fineweb_pro-adafactor-batch-20 --save_overwrite --s3
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data fineweb_edu_dedup --length 5xC --name fineweb_edu_dedup-adafactor-batch-20 --save_overwrite --s3
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data falcon_and_cc_eli5_oh_top10p --length 5xC --name falcon_and_cc_eli5_oh_top10p-adafactor-batch-20 --save_overwrite --s3
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data falcon_and_cc_eli5_oh_top20p --length 5xC --name falcon_and_cc_eli5_oh_top20p-adafactor-batch-20 --save_overwrite --s3
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data falcon_and_cc_og_eli5_oh_top10p --length 5xC --name falcon_and_cc_og_eli5_oh_top10p-adafactor-batch-20 --save_overwrite --s3
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data falcon_and_cc_tulu_qc_top10 --length 5xC --name falcon_and_cc_tulu_qc_top10-adafactor-batch-20 --save_overwrite --s3
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data dolma-v1-6-and-sources-baseline --length 5xC --name dolma-v1-6-and-sources-baseline-adafactor-batch-20 --save_overwrite --s3
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data DCLM-baseline --length 5xC --name DCLM-baseline-adafactor-batch-20 --save_overwrite
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data dolma17-75p-DCLM-baseline-25p --length 5xC --name dolma17-75p-DCLM-baseline-25p-adafactor-batch-20 --save_overwrite
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data dolma17-50p-DCLM-baseline-50p --length 5xC --name dolma17-50p-DCLM-baseline-50p-adafactor-batch-20 --save_overwrite
scripts/beaker/ladder-launch.sh 1 normal --model 300M --data dolma17-25p-DCLM-baseline-75p --length 5xC --name dolma17-25p-DCLM-baseline-75p-adafactor-batch-20 --save_overwrite
