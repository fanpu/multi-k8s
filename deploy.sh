docker build -t fanpu/multi-client:latest -t fanpu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fanpu/multi-server:latest  -t fanpu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fanpu/multi-worker:latest -t fanpu/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push fanpu/multi-client:latest
docker push fanpu/multi-client:$SHA
docker push fanpu/multi-server:latest
docker push fanpu/multi-server:$SHA
docker push fanpu/multi-worker:latest
docker push fanpu/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=fanpu/multi-server:$SHA
kubectl set image deployments/client-deployment client=fanpu/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=fanpu/multi-worker:$SHA
