Deployment.yml
 ---
apiVersion: apps/v1
kind: Deployment
metadata:
 name: app-deployment
 labels:
 app: healthcare
spec:
 selector:
 matchLabels:
 app: healthcare
 replicas: 1
 strategy:
 type: RollingUpdate
 template:
 metadata:
 labels:
 app: healthcare
 spec:
 containers:
 - name: healthcare
 image: cbabu85/health-care:latest
 ports:
 - containerPort: 80
##########service################
---
apiVersion: v1
kind: Service
metadata:
 name: my-service
spec:
 type: NodePort
 selector:
 app: healthcare
 ports:
 - name: http
 protocol: TCP
 nodePort: 30000
 port: 80
 targetPort: 8082