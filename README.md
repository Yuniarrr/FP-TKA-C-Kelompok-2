# FP-TKA-C-Kelompok-2

## Anggota: 
Nama | NRP 
--- | --- 
Arfan Yusran | 5027211017 
Annisa Rahmapuri | 5027211018
Abdul Zaki Syahrul Rahmat | 5027211020
Yohannes Hasahatan Tua Alexandro | 5027211022 
Yoga Hartono | 5027211023
Midyanisa Yuniar | 5027211025 


## Latar Belakang
Pada suatu ketika, Anda adalah seorang lulusan Teknologi Informasi, sebagai ahli IT, salah satu kemampuan yang harus dimiliki adalah Keampuan merancang, membangun, mengelola aplikasi berbasis komputer menggunakan layanan awan untuk memenuhi kebutuhan organisasi.(menurut kurikulum IT ITS 2023 😙). Untuk informasi lebih lanjut dapat klik link [berikut](https://github.com/fuaddary/fp-tka).

## Rancangan Arsitektur Komputasi Awan
Guna menyelesaikan masalah tersebut, kami selaku kelompok C-2 sepakat untuk membangun 2 arsitektur komputasi awan yakni 2 Worker dan 3 Worken. Hal tersebut merupakan benang merah yang ditarik untuk mendapatkan konfigurasi cloud yang terbaik. Kedua arsitektur tersebut yaitu :

1. Arsitektur Komputasi Awan Menggunakan 2 Worker
![Arsitektur Cloud Menggunakan 2 Worker](/images/[2-Worker]ArsitekturCloud.jpg)

2. Arsitektur Komputasi Awan Menggunakan 3 Worker
![Arsitektur Cloud Menggunakan 3 Worker](/images/[3-Worker]ArsitekturCloud.png)

## Implementasi

### Alat
Uji coba terhadap arsitektur awan tersebut dibutuhkan beberapa alat atau tools untuk mengimplementasikan arsitektur tersebut ke dalam kasus nyata. Alat atau tools yang dimaksud adalah Docker, Docker Compose, FastAPI, dan MongoDB sebagai database serta Locust sebagai media untuk melakukan load testing.


### Proses



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
