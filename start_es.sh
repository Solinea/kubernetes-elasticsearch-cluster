#!/bin/bash

echo "Creating gsk-search services..."
kubectl create -f service-account.yaml
kubectl create -f es-discovery-svc.yaml
kubectl create -f es-svc.yaml
kubectl create -f es-master-rc.yaml --validate=false
while true; do
      up=`kubectl get rc | grep es-master | awk '{print $3}'`
      if [ "$up" != "0" ]; then
	  break
      fi
      sleep 2
done
kubectl create -f es-client-rc.yaml --validate=false
while true; do
      up=`kubectl get rc | grep es-client | awk '{print $3}'`
      if [ "$up" != "0" ]; then
	  break
      fi
      sleep 2
done
kubectl create -f es-data-rc.yaml --validate=false
while true; do
      up=`kubectl get rc | grep es-data | awk '{print $3}'`
      if [ "$up" != "0" ]; then
	  break
      fi
      sleep 2
done
