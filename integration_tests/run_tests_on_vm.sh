gcloud init
gcloud config set project CI Pipeline

# setup service account necessary (can't be done in Terraform)
PROJECT_ID='CI Pipeline'
PROJECT_NUMBER='1091869076154'

# Allow the Cloud Functions to access the bigQuery
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:$PROJECT_NUMBER@cloudbuild.gserviceaccount.com \
    --role=roles/bigquery.dataEditor
# Allow the Cloud Functions to access the Cloud storage
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:$PROJECT_NUMBER@cloudbuild.gserviceaccount.com \
    --role=roles/storage.objectAdmin
# Allow the Cloud Build service account to act as the Cloud Functions Runtime service account
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:$PROJECT_NUMBER@cloudbuild.gserviceaccount.com \
    --role=roles/iam.serviceAccountUser
#Assign the Cloud Functions Developer role to the Cloud Build service account, which allows Cloud Build to deploy Cloud Functions
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:$PROJECT_NUMBER@cloudbuild.gserviceaccount.com \
    --role=roles/cloudfunctions.developer

#clone repo
gcloud source repos clone covid-analytics-git --project=CI Pipeline
#enable compute engine api
gcloud services enable compute.googleapis.com 

#install terrafrom
wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
unzip terraform_0.12.24_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_0.12.24_linux_amd64.zip
 
