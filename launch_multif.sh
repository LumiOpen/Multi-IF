#!/bin/bash
#SBATCH --job-name=multif  # Job name
#SBATCH --output=logs/%j.out # Name of stdout output file
#SBATCH --error=logs/%j.err  # Name of stderr error file
#SBATCH --partition=dev-g  # Partition (queue) name
#SBATCH --nodes=1              # Total number of nodes
#SBATCH --ntasks-per-node=1     # 8 MPI ranks per node, 128 total (16x8)
#SBATCH --gpus-per-node=8
#SBATCH --time=01:00:00       # Run time (d-hh:mm:ss)
#SBATCH --mem=480G
#SBATCH --account=project_462000353  # Project for billing

module use /appl/local/csc/modulefiles/
module load pytorch/2.5

export HF_HOME="/scratch/project_462000353/hf_cache"

model_path="$1"

# run Multi-IF evaluation
python multi_turn_instruct_following_eval_vllm.py \
        --model_path $model_path \
        --tokenizer_path $model_path \
        --input_data_csv data/multiIF_20241018_english.csv \
        --batch_size 64 \
        --tensor_parallel_size 8

# average results
model_name=$(basename $model_path)
sh show_result.sh $model_name
