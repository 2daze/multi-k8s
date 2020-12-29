docker build -t 2dazed/multi-client:latest -t 2dazed/multi-client:$GIT_SHA  -f ./client/Dockerfile ./client
docker build -t 2dazed/multi-server:latest -t 2dazed/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t 2dazed/multi-worker:latest -t 2dazed/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push 2dazed/multi-client:latest
docker push 2dazed/multi-server:latest
docker push 2dazed/multi-worker:latest

docker push 2dazed/multi-client:$GIT_SHA
docker push 2dazed/multi-server:$GIT_SHA
docker push 2dazed/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment server=2dazed/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=2dazed/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment server=2dazed/multi-worker:$GIT_SHA

