# Languages

The script installs the following languages and runtimes:

## Go

Installs the Go programming language.

```shell
mkdir -p ~/go
brew install go
```

## Node.js (with NVM)

Installs the Node Version Manager (NVM) and the latest LTS version of Node.js. It also installs the following global npm packages:
-   `@angular/cli`
-   `nx`
-   `husky`
-   `node-sass`
-   `node-gyp`

```shell
# Installs nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$(getLastestNVM)/install.sh | bash

# Installs Node.js
nvm install 20

# Installs global npm packages
npm install --location=global @angular/cli
npm install --location=global nx
npm install --location=global husky
npm install --location=global node-sass
npm install --location=global node-gyp
```

A `~/.huskyrc` file is also created to ensure that nvm is loaded before husky runs.

## Ruby

Installs the Ruby programming language.

```shell
brew install ruby
```

## Google Cloud Components

Installs the Google Cloud SDK and the following components:
-   `app-engine-go`
-   `app-engine-python`
-   `app-engine-python-extras`
-   `kubectl`
-   `docker-credential-gcr`

```shell
brew install --cask google-cloud-sdk
gcloud components install app-engine-go --quiet
gcloud components install app-engine-python --quiet
gcloud components install app-engine-python-extras --quiet
gcloud components install kubectl --quiet
gcloud components install docker-credential-gcr --quiet
```
