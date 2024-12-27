# Google Cloud Platform Deployment Example

This is a simple example of deploying a Node.js application to Google Cloud Platform using Cloud Run. The application is a simple hello world application that listens on port 3000. The application is containerized using Docker and the image is pushed to Google Container Registry. The image is then deployed to Cloud Run.

## Create a Node Project

```bash
mkdir gcp_deployment_example # Create project directory
cd gcp_deployment_example # Change to project directory
node -v # Check node version
node init -y # Create package.json file
touch index.js # Create index.js file and check file for content
node app.js # Run the app
```

## Create a Dockerfile

```bash
touch Dockerfile # Create Dockerfile check file for content
docker build -t hello-world-node . # Build the docker image
docker run -p 3000:3000 hello-world-node # Run the docker image
```

## Deploy on GCP

```bash
gcloud services enable run.googleapis.com containerregistry.googleapis.com cloudbuild.googleapis.com # Enable the required services
gcloud auth login # Login to GCP
gcloud config set project <project-id> # Set the *project*
docker build -t europe-west1-docker.pkg.dev/<PROJECT_ID>/gcr/hello-world-node . # Build the docker image from the project directory
docker run -p 3000:3000 europe-west1-docker.pkg.dev/<PROJECT_ID>/gcr/hello-world-node  # Test the docker image locally
gcloud artifacts repositories list --location=europe-west1 # List the repositories in Europe West 1
gcloud artifacts repositories create gcr --repository-format=docker --location=europe-west1 --description="Docker repository in EU" # Create a repository in Europe West 1 if it does not exist
gcloud auth configure-docker europe-west1-docker.pkg.dev # Configure docker to use the repository
docker tag hello-world-node europe-west1-docker.pkg.dev/<PROJECT_ID>/gcr/hello-world-node:latest
docker push europe-west1-docker.pkg.dev/<PROJECT_ID>/gcr/hello-world-node # Push the docker image to the repository
gcloud run deploy hello-world-node --image europe-west1-docker.pkg.dev/<PROJECT_ID>/gcr/hello-world-node:latest --platform managed --region europe-west3 --allow-unauthenticated # Deploy the image to Cloud Run
# Visit the URL to see the deployed application
# Delete the resources to avoid incurring charges
```
