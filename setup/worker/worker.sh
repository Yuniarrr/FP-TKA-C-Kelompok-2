#!/bin/bash

echo "Installing docker..."
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt install docker-ce -y
# sudo systemctl status docker
echo "Installing docker done!!"

echo "Installing python..."
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.8 -y
echo "Installing python done!!"

echo "Installing pip..."
sudo apt install python3-pip -y
pip3 install fastapi==0.78.0 uvicorn==0.18.2 pymongo pydantic uuid Flask Flask-PyMongo

echo "fastapi==0.78.0
uvicorn==0.18.2
pymongo
pydantic
uuid
Flask
Flask-PyMongo
gunicorn" >requirements.txt

echo "Configure docker file..."
echo "FROM python:3.9-slim" >Dockerfile
echo "WORKDIR /app" >>Dockerfile
echo "COPY . /app" >>Dockerfile
echo "RUN pip install -r requirements.txt" >>Dockerfile
echo 'CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "main:app"]' >>Dockerfile

echo "GO GO GO!!!!"
sudo docker build -t fp-app -f Dockerfile .
sudo docker run -p 8000:8000 -d fp-app
