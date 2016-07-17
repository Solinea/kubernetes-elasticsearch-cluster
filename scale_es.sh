#!/bin/bash

kubectl scale --replicas 2 rc/es-client
kubectl scale --replicas 5 rc/es-data
