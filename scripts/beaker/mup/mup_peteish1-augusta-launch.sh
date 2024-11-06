#!/usr/bin/env bash

set -ex

NUM_NODES=$1
shift

WIDTH=$1
shift

LR=$1
shift

gantry run \
  --workspace ai2/OLMo-mup \
  --task-name mup-peteish1 \
  --description "Search for a good LR for OLMo peteish 1B using mup" \
  --priority normal \
  --preemptible \
  --beaker-image michalg/cuda11.8-ubuntu20.04-arb \
  --cluster ai2/augusta-google-1 \
  --gpus 8 \
  --replicas "${NUM_NODES}" \
  --leader-selection \
  --host-networking \
  --budget ai2/oe-training \
  --no-nfs \
  --propagate-failure \
  --propagate-preemption \
  --no-python \
  --env LOG_FILTER_TYPE=local_rank0_only \
  --env OMP_NUM_THREADS=8 \
  --env OLMO_TASK=model \
  --env R2_PROFILE=R2 \
  --env S3_PROFILE=S3 \
  --env WEKA_PROFILE=WEKA \
  --env-secret AWS_CONFIG=SHANEA_AWS_CONFIG \
  --env-secret AWS_CREDENTIALS=SHANEA_AWS_CREDENTIALS \
  --env-secret WANDB_API_KEY=SHANEA_WANDB_API_KEY \
  --shared-memory 10GiB \
  --yes \
  --timeout=-1 \
  -- /bin/bash -c "scripts/beaker/mup/mup_peteish1-augusta.sh \$BEAKER_LEADER_REPLICA_HOSTNAME ${NUM_NODES} \$BEAKER_REPLICA_RANK ${WIDTH} ${LR} ${@}"