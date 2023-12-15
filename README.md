# FP-TKA-C-Kelompok-2

## Anggota: 
Nama                              | NRP 
---                               | --- 
Arfan Yusran                      | 5027211017 
Annisa Rahmapuri                  | 5027211018
Abdul Zaki Syahrul Rahmat         | 5027211020
Yohannes Hasahatan Tua Alexandro  | 5027211022 
Yoga Hartono                      | 5027211023
Midyanisa Yuniar                  | 5027211025 


## Latar Belakang
Pada suatu ketika, Anda adalah seorang lulusan Teknologi Informasi, sebagai ahli IT, salah satu kemampuan yang harus dimiliki adalah Keampuan merancang, membangun, mengelola aplikasi berbasis komputer menggunakan layanan awan untuk memenuhi kebutuhan organisasi.(menurut kurikulum IT ITS 2023 😙). Untuk informasi lebih lanjut dapat klik link [berikut](https://github.com/fuaddary/fp-tka).

## Rancangan Arsitektur Komputasi Awan
Guna menyelesaikan masalah tersebut, kami selaku kelompok C-2 sepakat untuk membangun 2 arsitektur komputasi awan yakni 2 Worker dan 3 Worken. Hal tersebut merupakan benang merah yang ditarik untuk mendapatkan konfigurasi cloud yang terbaik. Kedua arsitektur tersebut yaitu :

1. Arsitektur Komputasi Awan Menggunakan 2 Worker
![Arsitektur Cloud Menggunakan 2 Worker](/images/[2-Worker]ArsitekturCloud.jpg)

Spesifikasi yang digunakan adalah sebagai berikut :
| No  | Nama                | Spesifikasi                  | Fungsi             | Harga/bulan |
| --- | ------------------- | ---------------------------- | ------------------ | ----------- |
| 1   | vm3-LoadBalancer    | Regular 1vCPU, 2GB Memory    | Load Balancer      | $12         |
| 2   | vm2-Worker          | Regular 1vCPU, 1GB Memory    | App Worker 1       | $8          |
| 3   | vm2-Worker1         | Regular 1vCPU, 1GB Memory    | App Worker 2       | $8          |
| 4   | vm3-DatabaseServer  | Regular 1vCPU, 2GB Memory    | Database Server    | $12         |
| --- | Total               |                              |                    | $40         |


3. Arsitektur Komputasi Awan Menggunakan 3 Worker
![Arsitektur Cloud Menggunakan 3 Worker](/images/[3-Worker]ArsitekturCloud.png)

Spesifikasi yang digunakan adalah sebagai berikut 
| No  | Nama                | Spesifikasi                  | Fungsi             | Harga/bulan |
| --- | ------------------- | ---------------------------- | ------------------ | ----------- |
| 1   | vm3-LoadBalancer    | Regular 1vCPU, 2GB Memory    | Load Balancer      | $12         |
| 2   | vm2-Worker1         | Regular 1vCPU, 1GB Memory    | App Worker 1       | $8          |
| 3   | vm2-Worker2         | Regular 1vCPU, 1GB Memory    | App Worker 2       | $8          |
| 4   | vm2-Worker3         | Regular 1vCPU, 1GB Memory    | App Worker 3       | $8          |
| 5   | vm3-DatabaseServer  | Regular 1vCPU, 2GB Memory    | Database Server    | $12         |
| --- | Total               |                              |                    | $48         |


## Implementasi

### Alat
Uji coba terhadap arsitektur awan tersebut dibutuhkan beberapa alat atau tools untuk mengimplementasikan arsitektur tersebut ke dalam kasus nyata. Alat atau tools yang dimaksud adalah Docker, Docker Compose, FastAPI, dan MongoDB sebagai database serta Locust sebagai media untuk melakukan load testing.


### Proses
1. Setup Database
```bash
#!/bin/bash

echo "Installing docker..."
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt install docker-ce -y
# sudo systemctl status docker
echo "Installing docker done!!"

echo "version: '3'

services:
  mongodb:
    image: mongo
    command: mongod --bind_ip_all
    ports:
      - \"27017:27017\"
    environment:
      - MONGO_INITDB_ROOT_USERNAME=admin
      - MONGO_INITDB_ROOT_PASSWORD=admin
    volumes:
      - mongodb_data:/data/db
  mongo-express:
    image: mongo-express
    ports:
      - \"8082:8081\"
    environment:
      - ME_CONFIG_MONGODB_ADMINUSERNAME=admin
      - ME_CONFIG_MONGODB_ADMINPASSWORD=admin
      - ME_CONFIG_MONGODB_SERVER=mongodb
      - ME_CONFIG_MONGODB_ENABLE_ADMIN=true
      - ME_CONFIG_BASICAUTH_USERNAME=admin
      - ME_CONFIG_BASICAUTH_PASSWORD=admin
    depends_on:
      - mongodb
volumes:
  mongodb_data:
    driver: local" >docker-compose.yml

sudo docker compose up -d
sudo docker ps -a
```


2. Setup Load Balancer
```bash
#!/bin/bash

sudo apt update

echo "Installing nginx..."
sudo apt install nginx

# Konten konfigurasi Nginx
echo "upstream app {
    server 172.208.23.151:8000;
    server 172.208.82.223:8000;
}

server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://app;
    }
}
" | sudo tee /etc/nginx/sites-available/my_proxy

# Membuat tautan simbolik ke sites-enabled
sudo ln -s /etc/nginx/sites-available/my_proxy "/etc/nginx/sites-enabled/"

sudo rm /etc/nginx/sites-enabled/default

# Melakukan uji sintaks konfigurasi Nginx
sudo nginx -t

# Merestart Nginx untuk menerapkan konfigurasi baru
sudo systemctl restart nginx

sudo ufw status
sudo ufw enable
sudo ufw allow 80
```


3. Setup Worker
 ```bash
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
```



### Hasil Pengujian
Kami melakukan beberapa pengujian terhadap kedua arsitektur tersebut atas dasar pengujian ke setiap Endpoint dengan menggunakan POSTMAN dan Loadtesting dengan menggunakan LOCUST, berikut adalah hasil pengujian yang telah dilakukan.


#### Pengujian Terhadap Setiap Endpoint
Pengujian terhadap setiap Endpoint dilakukan dengan menggunakan POSTMAN terhadap GET, GET ID, POST, dan DELETE. Pengujian dilakukan kepada kedua arsitektur tersebut dan hasil pengujian dapat dilihat sebagai berikut :

1. Pengujian Terhadap Arsitektur Cloud 2 Worker
- GET
![GET Worker 1](/images/[2-Worker]Worker1_GET.png)
![GET Worker 2](/images/[2-Worker]Worker2_GET.png)
- GET ID
![GET ID Worker 1](/images/[2-Worker]Worker1_GET-ID.png)
![GET ID Worker 2](/images/[2-Worker]Worker2_GET-ID.png)
- POST
![POST Worker 1](/images/[2-Worker]Worker1_POST.jpg)
![POST Worker 2](/images/[2-Worker]Worker1_POST.jpg)
- DELETE
![DELETE Worker 1](/images/[2-Worker]Worker1_DELETE.png)
![DELETE Worker 2](/images/[2-Worker]Worker2_DELETE.png)


2. Pengujian Terhadap Arsitektur Cloud 3 Worker
- GET
![GET Worker 1](/images/[3-Worker]Worker1_GET.png)
![GET Worker 2](/images/[3-Worker]Worker2_GET.png)
![GET Worker 3](/images/[3-Worker]Worker3_GET.png)
- GET ID
![GET ID Worker 1](/images/[3-Worker]Worker1_GET-ID.png)
![GET ID Worker 2](/images/[3-Worker]Worker2_GET-ID.png)
![GET ID Worker 3](/images/[3-Worker]Worker3_GET-ID.png)
- POST
![POST Worker 1](/images/[3-Worker]Worker1_POST.jpg)
![POST Worker 2](/images/[3-Worker]Worker2_POST.jpg)
![POST Worker 3](/images/[3-Worker]Worker3_POST.jpg)
- DELETE
![DELETE Worker 1](/images/[3-Worker]Worker1_DELETE.png)
![DELETE Worker 2](/images/[3-Worker]Worker2_DELETE.png)
![DELETE Worker 3](/images/[3-Worker]Worker3_DELETE.png)


#### Pengujian Terhadap Loadtesting
Pengujian terhadap Loadtesting dengan menggunakan LOCUST untuk endpoint GET ORDER dan CREATE NEW ORDER dengan 3 parameter spawn rate yang berbeda yakni 25, 50, dan 100 bagi kedua arsitektur tersebut dan hasil pengujian sebagai berikut :

1. Pengujian Terhadap Arsitektur Cloud 2 Worker
- 25 Spawn Rate
![25 Spawn Rate Terhadap 2 Worker](/images/[2-Worker]SR25Peak750.png)
- 50 Spawn Rate
![50 Spawn Rate Terhadap 2 Worker](/images/[2-Worker]SR50Peak750.png)
- 100 Spawn Rate
![100 Spawn Rate Terhadap 2 Worker](/images/[2-Worker]SR100Peak725.png)



2. Pengujian Terhadap Arsitektur Cloud 3 Worker
- 25 Spawn Rate
![25 Spawn Rate Terhadap 3 Worker](/images/[3-Worker]SR25Peak750.png)
- 50 Spawn Rate
![50 Spawn Rate Terhadap 3 Worker](/images/[3-Worker]SR50Peak725.png)
- 100 Spawn Rate
![100 Spawn Rate Terhadap 3 Worker](/images/[3-Worker]SR100Peak725.png)


## Kesimpulan dan Saran
Berdasarkan uji coba yang telah dilakukan, didapatkan beberapa hasil yaitu :

1. Jumlah Request per seconds (RPS) maksimum yang dapat ditangani oleh server dengan durasi waktu load testing selama 60 detik adalah sebesar 333.3 RPS dengan 0% failure.
2. Jumlah peak concurrency maksimum maksimum yang dapat ditangani oleh server dengan spawn rate 25 dan durasi waktu load testing selama 60 detik adalah sebanyak 750 user dengan 0% failure.
3. Jumlah peak concurrency maksimum maksimum yang dapat ditangani oleh server dengan spawn rate 50 dan durasi waktu load testing selama 60 detik adalah sebanyak 750 user dengan 0% failure.
4. Jumlah peak concurrency maksimum maksimum yang dapat ditangani oleh server dengan spawn rate 100 dan durasi waktu load testing selama 60 detik adalah sebanyak 725 user dengan 0% failure.

Berdasarkan data uji coba tersebut, dapat ditarik kesimpulan bahwa 2 Worker lebih stabil dibandingna 3 Worker meski hanya selisih sedikit saja. Cara tersebut didapatkan dari hasil uji coba dari seluruh arsitektur yang kami bentuk. Kemudian diperlukannya menambahkan caching pada Load Balancer guna mendapatkan hasil ayng lebih optimal.
