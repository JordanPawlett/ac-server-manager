gcloud container clusters create prod \
--zone=europe-west1-b \
--preemptible \
--num-nodes=1 \
--enable-autoscaling \
--min-nodes=1 \
--max-nodes=1 \
--maintenance-window=06:00 \
--enable-ip-alias \
--enable-autoupgrade \
--enable-autorepair \
--no-enable-basic-auth \
--tags=assetto

gcloud auth login

gcloud config set project cards-against-formality-305611

gcloud components install beta

gcloud services enable container.googleapis.com

gcloud container clusters create prod \
--zone=europe-west1-b \
--num-nodes=2 \
--enable-autoscaling \
--min-nodes=1 \
--max-nodes=4 \
--enable-ip-alias \
--enable-autoupgrade \
--enable-autorepair \
--no-enable-basic-auth

skaffold run  -p gcb --tail --default-repo=gcr.io/assetto-servermanager --namespace=assetto -f ./k8s/skaffold.yaml
skaffold build -p gcb --default-repo=gcr.io/assetto-servermanager --namespace=assetto
skaffold deploy -p gcb --default-repo=gcr.io/assetto-servermanager --namespace=assetto
skaffold dev --default-repo=gcr.io/assetto-servermanager --namespace=assetto


gcloud container clusters delete prod --zone europe-west1-b

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/cloud-generic.yaml
kubectl get pods --all-namespaces -l app=ingress-nginx
kubectl run stackdriver-zipkin \
  --image=gcr.io/stackdriver-trace-docker/zipkin-collector \
  --expose --port=9411

  http://stackdriver-zipkin:9411

  gcloud compute firewall-rules create assetto-server-dgs --network game \
    --allow udp:27961-28061



// vm
https://cloud.google.com/community/tutorials/docker-compose-on-container-optimized-os
https://cloud.google.com/compute/docs/disks/add-persistent-disk#formatting