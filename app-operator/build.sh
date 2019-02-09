#operator-sdk add controller --api-version=app.example.com/v1alpha1 --kind=AppService
#operator-sdk add api --api-version=apps/v1 --kind=Deployment
operator-sdk add controller --api-version=apps/v1 --kind=Deployment

#operator-sdk build 172.16.155.136:5000/app-operator:v0.45

# Update the operator manifest to use the built image name (if you are performing these steps on OSX, see note below)
#$ sed -i 's|REPLACE_IMAGE|quay.io/example/app-operator|g' deploy/operator.yaml
# On OSX use:
#$ sed -i "" 's|REPLACE_IMAGE|quay.io/example/app-operator|g' deploy/operator.yaml
# Setup Service Account
kubectl create -f deploy/service_account.yaml
# Setup RBAC
kubectl create -f deploy/role.yaml
kubectl create -f deploy/role_binding.yaml
# Setup the CRD
kubectl create -f deploy/crds/app_v1alpha1_appservice_crd.yaml
# Deploy the app-operator
kubectl create -f deploy/operator.yaml

# Create an AppService CR
# The default controller will watch for AppService objects and create a pod for each CR
kubectl create -f deploy/crds/app_v1alpha1_appservice_cr.yaml

