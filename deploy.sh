docker build -t kuuseorg/multi-client:latest -t kuuseorg/multi-client:$SHA -f ./client/Dockerfile .client
docker build -t kuuseorg/multi-server:latest -t kuuseorg/multi-server:$SHA -f ./server/Dockerfile .server
docker build -t kuuseorg/multi-worker:latest -t kuuseorg/multi-worker:$SHA -f ./worker/Dockerfile .worker

docker push kuuseorg/multi-client:latest
docker push kuuseorg/multi-server:latest
docker push kuuseorg/multi-worker:latest

docker push kuuseorg/multi-client:$SHA
docker push kuuseorg/multi-server:$SHA
docker push kuuseorg/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=kuuseorg/multi-server:$SHA
kubectl set image deployments/client-deployment client=kuuseorg/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kuuseorg/multi-worker:$SHA
