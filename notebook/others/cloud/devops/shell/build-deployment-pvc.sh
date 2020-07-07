#!/bin/bash
#set env
app=$1
source ~/k8s/kube-script/input/"$app"_env
#------------------------------ cat deployment.yaml -----------------------------------#
cat <<EOF > ~/k8s/kube-script/output/"$app"-deployment.yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: $app
  namespace: $namespace
spec:
  replicas: $replicas
  minReadySeconds: 5
  progressDeadlineSeconds: 60
  revisionHistoryLimit: 4
  strategy:
      rollingUpdate:
        maxSurge: 0
        maxUnavailable: 1
      type: RollingUpdate
  template:
    metadata:
      labels:
        app: $app
    spec:
      containers:
        - name: $app
          image: $docker_repo:$(echo "$app")_$new_img_num
          imagePullPolicy: Always
          resources:
            limits:
              cpu: $limit_cpu
              memory: $limit_mem
            requests:
              cpu: $request_cpu                          
              memory: $request_mem                       
      imagePullSecrets:                                  
      - name: $repo_secret                               
      affinity:                                          
        nodeAffinity:                                    
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:                           
            - matchExpressions:                          
              - key: node                                
                operator: In                             
                values:                                  
                - worker                                 
        podAntiAffinity:                                 
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:                               
              matchExpressions:                          
              - key: app                                 
                operator: In                             
                values:                                  
                - $app                                   
            topologyKey: "kubernetes.io/hostname"        
      hostAliases:                                       
      - hostnames:                                       
        - $edas_host                                     
        ip: $edas_ip                                     
EOF                                                      
#--------------------------------- create deployment ---------------------------------#
kubectl --kubeconfig $kubeconfig create -f ~/k8s/kube-script/output/"$app"-deployment.yaml