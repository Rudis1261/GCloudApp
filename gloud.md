# Project App Engine URL:
`https://genesis-201514.appspot.com`

sing GCloudSDK to push your application to the cloud:
`gcloud app deploy`

Building your Docker Image:
`docker build -t gcr.io/genesis-201514/html-to-pdf-service .`

Pushing your Docker Image to GCP:
`gcloud docker -- push gcr.io/genesis-201514/html-to-pdf-service`

Running VM:
`http://35.198.128.11/`