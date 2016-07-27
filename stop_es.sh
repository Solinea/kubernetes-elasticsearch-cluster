#!/bin/bash

echo "Deleting elasticsearch and gsk-kibana services..."
kubectl delete serviceaccount elasticsearch
kubectl delete svc elasticsearch
kubectl delete svc elasticsearch-discovery
kubectl delete rc es-master
kubectl delete rc es-client
kubectl delete rc es-data
kubectl delete svc gsk-kibana
kubectl delete rc es-kibana
