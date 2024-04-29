#!/bin/bash
 
#PBS -l ncpus=12
#PBS -l mem=25GB
#PBS -l jobfs=30GB
#PBS -q gpuvolta
#PBS -l ngpus=1
#PBS -l walltime=24:00:00
#PBS -P po67
#PBS -l storage=g/data/po67/anonymous_cat
#PBS -l wd
  
module load python3/3.9.2

###############################################################
cp --parents /g/data/po67/anonymous_cat/Data/ $PBS_JOBFS
cp -r /g/data/po67/anonymous_cat/Code/VCT $PBS_JOBFS

export PYTHONPATH="${PYTHONPATH}:/g/data/po67/anonymous_cat/lib/python3.9/site-packages/"

cd $PBS_JOBFS

################################################################

# place your train or test script here, using absolute path is recommended
# remember to store your output files in gdata, 
# otherwise it gets lost in $PBS_JOBFS once job is finished

# e.g., python3 main.py > /g/data/kf26/$USER/logs
python3 main_vqvae.py --dataset mpi_real --model vqvae --epochs 200

#################################################################

# This part is not necessary, I put it here only because I use tensorboard with logdir "runs/"
cp -r VCT/trained_vqvae /g/data/po67/anonymous_cat/Trained
cp -r VCT/tmp /g/data/po67/anonymous_cat/Trained/logs