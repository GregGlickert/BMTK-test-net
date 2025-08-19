#!/bin/bash
#SBATCH --job-name=test_net
#SBATCH --time=00:10:00
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --mem-per-cpu=2G
#SBATCH --output=run.out
#SBATCH --error=run.error

# activate needed modules
module load mpich-x86_64-nopy

mpirun nrniv -mpi -python run_network.py 
