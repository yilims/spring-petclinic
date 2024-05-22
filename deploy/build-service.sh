IMAGE_NAME=spring-petclinic
ACR_LOGIN_SERVER=buildservicedemo.azurecr.io
IMAGE_REPO=app/spring-petclinic
GIT_REPO=https://github.com/yilims/spring-petclinic.git
GIT_REVISION=49f7727882daf2f30f118ae47b81a403e16c94fe
BUILDER=azure-java-builder
SERVICE_ACCOUNT=build-service-sa
NAMESPACE=managed-service
curl -L https://github.com/buildpacks-community/kpack-cli/releases/download/v0.13.0/kp-linux-amd64-0.13.0 -o build-service
chmod +x build-service
./build-service image save $IMAGE_NAME --tag $ACR_LOGIN_SERVER/$IMAGE_REPO --replace-additional-tag $ACR_LOGIN_SERVER/$IMAGE_REPO$GIT_REVISION --git $GIT_REPO --git-revision $GIT_REVISION --cluster-builder $BUILDER --service-account $SERVICE_ACCOUNT -n $NAMESPACE -w
