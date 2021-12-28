docker build -t hergerr/multi-client:latest -t hergerr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hergerr/multi-server:latest -t hergerr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hergerr/multi-worker:latest -t hergerr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hergerr/multi-client:latest
docker push hergerr/multi-server:latest
docker push hergerr/multi-worker:latest

docker push hergerr/multi-client:$SHA
docker push hergerr/multi-server:$SHA
docker push hergerr/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=hergerr/multi-server:$SHA
kubectl set image deployments/client-deployment client=hergerr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hergerr/multi-worker:$SHA