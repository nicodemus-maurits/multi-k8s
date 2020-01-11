docker build -t nicodemusmaurits/multi-client:latest -t nicodemusmaurits/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nicodemusmaurits/multi-server:latest -t nicodemusmaurits/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nicodemusmaurits/multi-worker:latest -t nicodemusmaurits/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nicodemusmaurits/multi-client:latest
docker push nicodemusmaurits/multi-server:latest
docker push nicodemusmaurits/multi-worker:latest

docker push nicodemusmaurits/multi-client:$SHA
docker push nicodemusmaurits/multi-server:$SHA
docker push nicodemusmaurits/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=nicodemusmaurits/multi-client:$SHA
kubectl set image deployments/server-deployment server=nicodemusmaurits/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=nicodemusmaurits/multi-worker:$SHA
