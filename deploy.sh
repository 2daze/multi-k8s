docker build -t 2dazed/multi-client -f ./client/Dockerfile ./client
docker build -t 2dazed/multi-server -f ./server/Dockerfile ./server
docker build -t 2dazed/multi-worker -f ./worker/Dockerfile ./worker
docker push 2dazed/multi-client
kubectl apply -f k8s
kubectl set image deployment/server-deployment server=2dazed/multi-server

