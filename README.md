### Google Cloud Engine Sample App

Listing some heroes

#### Installation
```shell
gem install bundler
bundle install
```

#### Running Application
 ```shell
rerun 'ruby app.rb -o 0.0.0.0 -p 8080'
 ````
 
#### Deploying Application
```shell
gcloud app deploy
``` 

#### Routes
- `/heroes` 
- `/hero/:name`