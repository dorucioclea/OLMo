#!/usr/bin/env bash

set -ex

NUM_NODES=4

gantry run \
  --workspace ai2/OLMo-training \
  --task-name long_contexts_7B_anneal \
  --description "OLMo medium - 7B - long context continued pretraining" \
  --priority high \
  --beaker-image petew/olmo-torch23-gantry \
  --cluster ai2/jupiter-cirrascale-2 \
  --gpus 8 \
  --preemptible \
  --replicas "${NUM_NODES}" \
  --leader-selection \
  --host-networking \
  --budget ai2/oe-training \
  --no-nfs \
  --env LOG_FILTER_TYPE=local_rank0_only \
  --env OMP_NUM_THREADS=8 \
  --env OLMO_TASK=model \
  --no-nfs \
  --env-secret WANDB_API_KEY=WANDB_API_KEY \
  --env-secret AWS_ACCESS_KEY_ID=AWS_ACCESS_KEY_ID \
  --env-secret AWS_SECRET_ACCESS_KEY=AWS_SECRET_ACCESS_KEY \
  --shared-memory 10GiB \
  --venv base \
  --propagate-failure \
  --yes \
  --timeout=-1 \
  -- /bin/bash -c "scripts/beaker/lc_7b.sh \$BEAKER_LEADER_REPLICA_HOSTNAME ${NUM_NODES}"
