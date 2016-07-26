#!/bin/bash

# Set to larger values to accomodate scalability requirements
kubectl scale --replicas 2 rc/es-client
kubectl scale --replicas 3 rc/es-data
