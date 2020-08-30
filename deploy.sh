docker build -t chokchok/multi-client:latest -t chokchok/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chokchok/multi-server:latest -t chokchok/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chokchok/multi-worker:latest -t chokchok/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push chokchok/multi-client:latest
docker push chokchok/multi-server:latest
docker push chokchok/multi-worker:latest

docker push chokchok/multi-client:$SHA
docker push chokchok/multi-server:$SHA
docker push chokchok/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chokchok/multi-server:$SHA
kubectl set image deployments/client-deployment client=chokchok/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chokchok/multi-worker:$SHA
 