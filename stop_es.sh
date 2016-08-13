#!/bin/bash

if [ "$#" -eq 1 ] && [ "$1" == "kibana" ]; then
    echo "Deleting elasticsearch and gsk-kibana services..."
else
    echo "Deleting elasticsearch service..."
fi

kubectl delete serviceaccount elasticsearch
kubectl delete svc elasticsearch
kubectl delete svc elasticsearch-discovery
kubectl delete rc es-master
kubectl delete rc es-client
kubectl delete rc es-data

if [ "$#" -eq 1 ] && [ "$1" == "kibana" ]; then
    kubectl delete svc gsk-kibana
    kubectl delete rc es-kibana
fi
