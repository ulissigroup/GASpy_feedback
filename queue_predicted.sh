#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --time=2:00:00
#SBATCH --partition=regular
#SBATCH --job-name=vasp
#SBATCH --output=queuepredicted-%j.out
#SBATCH --error=queuepredicted-%j.error
#SBATCH --constraint=haswell

module load python
cd /global/project/projectdirs/m2755/GASpy_dev/GASpy_predict
source activate /project/projectdirs/m2755/GASpy_conda/

PYTHONPATH='.' luigi \
    --module feedback Predictions \
    --ads-list '["CO"]' \
    --prediction-target -0.55 \
    --model-location '/global/project/projectdirs/m2755/GASpy_dev/GASpy_regressions/pkls/TPOT_FEATURES_coordcount_ads_RESPONSES_energy_BLOCKS_.pkl' \
    --xc 'rpbe' \
    --max-submit 20 \
    --scheduler-host gilgamesh.cheme.cmu.edu  \
    --workers=4 \
    --log-level=WARNING \
    --parallel-scheduling \
    --worker-timeout 300 
