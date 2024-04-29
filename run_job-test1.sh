#!/bin/bash

#PBS -l ncpus=12
#PBS -l mem=25GB
#PBS -l jobfs=30GB
#PBS -q gpuvolta
#PBS -l ngpus=1
#PBS -l walltime=24:00:00
#PBS -P po67
#PBS -l storage=gdata/po67
#PBS -l wd

echo BEFORE_LOADING > /g/data/po67/anonymous_cat/Trained/logs/log1.log
module load python3/3.9.2
module load pytorch/1.9.0

echo LOADED_MODULES > /g/data/po67/anonymous_cat/Trained/logs/log2.log
###############################################################
cp -r /g/data/po67/anonymous_cat/Code/VCT $PBS_JOBFS
echo COPIED SUCCESSFULLY > /g/data/po67/anonymous_cat/Trained/logs/log3.log
export PYTHONPATH="${PYTHONPATH}:/g/data/po67/anonymous_cat/lib/python3.9/site-packages/"
echo EXPORTED_PATH > /g/data/po67/anonymous_cat/Trained/logs/log4.log
cd $PBS_JOBFS

################################################################

# place your train or test script here, using absolute path is recommended
# remember to store your output files in gdata, 
# otherwise it gets lost in $PBS_JOBFS once job is finished

# e.g., python3 main.py > /g/data/kf26/$USER/logs
ls > /g/data/po67/anonymous_cat/Trained/logs/log5.log
python3 main_vqvae.py --dataset cars3d --model vqvae --epochs 200 --data-dir /g/data/po67/anonymous_cat/Data/ > /g/data/po67/anonymous_cat/Trained/logs/

#################################################################

# This part is not necessary, I put it here only because I use tensorboard with logdir "runs/"
cp -r VCT/trained_vqvae /g/data/po67/anonymous_cat/Trained
cp -r VCT/tmp /g/data/po67/anonymous_cat/Trained/logs