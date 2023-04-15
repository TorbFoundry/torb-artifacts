#!/bin/bash

cat <&0 > ./torb_artifacts/common/dev/volume_and_mount/build/all.yaml

patchfile="$4/repositories/torb-artifacts/common/dev/volume_and_mount/kustomization.template.yaml"
patch_subst="$(NODE_NAME=$1 DEV_PATH=$2 MOUNT_PATH=$3 envsubst < $patchfile)"

echo "$patch_subst" > ./torb_artifacts/common/dev/volume_and_mount/build/kustomization.yaml
kubectl kustomize ./torb_artifacts/common/dev/volume_and_mount/build > ./torb_artifacts/common/dev/volume_and_mount/out.yaml

cat ./torb_artifacts/common/dev/volume_and_mount/out.yaml
