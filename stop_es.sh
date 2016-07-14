#!/bin/bash

echo "Deleting gsk-search services..."
kubectl delete serviceaccount elasticsearch
kubectl delete service gsk-search
kubectl delete service elasticsearch-discovery
kubectl delete replicationcontroller es-master
kubectl delete replicationcontroller es-client
kubectl delete replicationcontroller es-data


