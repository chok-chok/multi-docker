docker build -t chok-chok/multi-client:latest -t chok-chok/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chok-chok/multi-server:latest -t chok-chok/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chok-chok/multi-worker:latest -t chok-chok/multi-worker:$SHA -f ./worker/Dockerfie ./worker
docker push chok-chok/multi-client:latest
docker push chok-chok/multi-server:latest
docker push chok-chok/multi-worker:latest

docker push chok-chok/multi-client:$SHA
docker push chok-chok/multi-server:$SHA
docker push chok-chok/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chok-chok/multi-server:$SHA
kubectl set image deployments/client-deployment client=chok-chok/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chok-chok/multi-worker:$SHA
 