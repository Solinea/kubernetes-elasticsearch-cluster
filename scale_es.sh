#!/bin/bash

kubectl scale --replicas 3 rc/es-master
kubectl scale --replicas 2 rc/es-client
kubectl scale --replicas 2 rc/es-data
