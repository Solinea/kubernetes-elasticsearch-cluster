#!/bin/bash

if [ "$#" -eq 1 ] && [ "$1" == "kibana" ]; then
    echo "Creating elasticsearch and gsk-kibana services..."
else
    echo "Creating elasticsearch service..."
fi

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

if [ "$#" -eq 1 ] && [ "$1" == "kibana" ]; then
    kubectl create -f kibana-svc.yaml
    kubectl create -f kibana-rc.yaml
    while true; do
	up=`kubectl get rc | grep kibana | awk '{print $3}'`
	if [ "$up" != "0" ]; then
	    break
	fi
	sleep 2
    done
    echo "Waiting for gsk-kibana public service IP..."
    while true; do
	kibana_ip=`kubectl get svc gsk-kibana | grep gsk-kibana | awk '{print $3}'`
	if [ "$kibana_ip" != "<pending>" ]; then
	    break
	fi
	sleep 2
    done
    echo "gsk-kibana public IP:    "$kibana_ip
else
    while true; do
	up=`kubectl get rc | grep elasticsearch | awk '{print $3}'`
	if [ "$up" != "0" ]; then
	    break
	fi
	sleep 2
    done
    echo "Waiting for elasticsearch public service IP..."
    while true; do
	es_ip=`kubectl get svc elasticsearch | grep elasticsearch | awk '{print $3}'`
	if [ "$es_ip" != "<pending>" ]; then
	    break
	fi
	sleep 2
    done    
    echo "elasticsearch public IP:    "$es_ip
fi

