#!/bin/bash

kubectl scale --replicas 2 rc/es-client
kubectl scale --replicas 3 rc/es-data
