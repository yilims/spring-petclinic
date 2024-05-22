IMAGE_NAME=spring-petclinic
ACR_LOGIN_SERVER=xxx.azurecr.io
ACR_USER=xxx
ACR_PASSWORD=xxx
IMAGE_REPO=app/spring-petclinic
GIT_REPO=https://github.com/yilims/spring-petclinic.git
GIT_REVISION=49f7727882daf2f30f118ae47b81a403e16c94fe
BUILDER=azure-java-builder
SERVICE_ACCOUNT=build-service-sa
NAMESPACE=appteam
curl -L https://github.com/buildpacks-community/kpack-cli/releases/download/v0.13.0/kp-linux-amd64-0.13.0 -o build-service
chmod +x build-service
kubectl create ns $NAMESPACE
kubectl create secret docker-registry buildservice-registry-credentials --docker-server=$ACR_LOGIN_SERVER \
   --docker-username=$ACR_USER --docker-password=$ACR_PASSWORD  -n $NAMESPACE
kubectl apply -f build-service-demo.yaml -n $NAMESPACE
./build-service image save $IMAGE_NAME --tag $ACR_LOGIN_SERVER/$IMAGE_REPO --replace-additional-tag $ACR_LOGIN_SERVER/$IMAGE_REPO$GIT_REVISION --git $GIT_REPO --git-revision $GIT_REVISION --cluster-builder $BUILDER --service-account $SERVICE_ACCOUNT -n $NAMESPACE -w


