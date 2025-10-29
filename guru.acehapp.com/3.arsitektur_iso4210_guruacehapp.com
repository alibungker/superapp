# Dokumen Arsitektur Sistem
## Sistem Informasi Guru Aceh (SiGuru) - guru.acehapp.com
### Berdasarkan Standar ISO/IEC/IEEE 42010

---

## 1. Pengantar Arsitektur Sistem

### 1.1 Nama dan Identifikasi Arsitektur
**Nama Arsitektur**: Arsitektur Sistem Informasi Guru Aceh (SiGuru)  
**Nama Sistem**: guru.acehapp.com  
**Kode Referensi**: SIGURU-ARCH-001  
**Versi**: 1.0  
**Tanggal Pembuatan**: Oktober 2025  
**Penyusun**: System Analyst Team  
**Referensi Standar**: ISO/IEC/IEEE 42010:2011

### 1.2 Maksud dan Tujuan Dokumen
Dokumen ini menyediakan representasi arsitektur sistem untuk Sistem Informasi Guru Aceh (SiGuru), yang dirancang untuk mendukung pengelolaan data guru, pelaporan, dan asesmen kompetensi di Provinsi Aceh. Dokumen ini disusun mengikuti standar internasional ISO/IEC/IEEE 42010:2011 tentang deskripsi arsitektur sistem dan perangkat lunak.

### 1.3 Ruang Lingkup Arsitektur
Arsitektur mencakup semua komponen sistem SiGuru yang beroperasi di lingkungan web, termasuk antarmuka pengguna, logika bisnis, sistem manajemen data, dan integrasi dengan sistem eksternal. Sistem ini melayani berbagai peran pengguna: guru, kepala sekolah, cabang dinas pendidikan, dan administrator sistem.

### 1.4 Definisi dan Akronim
- **SIGURU**: Sistem Informasi Guru Unggul
- **SAD**: Spesifikasi Arsitektur Dokumen (Architecture Description)
- **MVC**: Model-View-Controller
- **RBAC**: Role-Based Access Control
- **PTK**: Pendidik dan Tenaga Kependidikan
- **NUPTK**: Nomor Unik Pendidik dan Tenaga Kependidikan

## 2. Representasi Arsitektur

### 2.1 Kerangka Arsitektur yang Digunakan
Arsitektur sistem mengikuti pendekatan berlapis (layered architecture) dengan pola desain Model-View-Controller (MVC) menggunakan framework Laravel 11.x. Arsitektur ini mendukung prinsip separation of concerns dan modularity sesuai dengan standar ISO/IEC/IEEE 42010.

### 2.2 Konsep dan Prinsip Arsitektur
- **Separasi Concern**: Pemisahan antara presentasi, logika bisnis, dan lapisan data
- **Keterbukaan dan Modularitas**: Arsitektur modular yang memungkinkan ekspansi
- **Keamanan dan Otorisasi**: Sistem kontrol akses berbasis peran (RBAC)
- **Ketersediaan dan Kinerja**: Desain untuk mendukung puluhan ribu pengguna

## 3. Stakeholder dan Concern Mereka

### 3.1 Stakeholder Operasional
- **Guru/PTK**: Concern terhadap kemudahan pengisian data pribadi dan portofolio
- **Kepala Sekolah**: Concern terhadap manajemen data guru di sekolahnya
- **Admin Dinas Pendidikan**: Concern terhadap laporan komprehensif dan statistik
- **Cabang Dinas Pendidikan**: Concern terhadap data berdasarkan wilayah kerja

### 3.2 Stakeholder Pengembangan
- **Developer**: Concern terhadap kemudahan pemeliharaan dan ekspansi sistem
- **System Administrator**: Concern terhadap keamanan, kinerja, dan ketersediaan

### 3.3 Stakeholder Bisnis
- **Pemerintah Aceh**: Concern terhadap efisiensi administrasi pendidikan
- **Pengambil Kebijakan**: Concern terhadap data akurat untuk perencanaan strategis

## 4. View dan Viewpoint

### 4.1 Module View (Pandangan Modul)
#### Viewpoint: Struktur Statik
**Tujuan**: Menunjukkan struktur modul dan hubungan antar komponen statis aplikasi

**Deskripsi Arsitektur Modul**:
- **App\Http\Controllers**: 
  - Submodul Back\ (admin, cabdin, sekolah, guru)
  - Submodul Front (tampilan publik)
  - Submodul Auth (otentikasi)
- **App\Models**: 
  - User, Teacher, Profile, School, AssesmentResult
  - City, District, Competence (referensi wilayah dan kompetensi)
- **App\Http\Requests**: Validasi input untuk berbagai fungsi
- **App\Http\Middleware**: Kontrol akses berbasis peran
- **Resources\Views**: 
  - Layouts (admin, guru, publik)
  - Modul backoffice (per peran pengguna)

#### Hubungan Antar Modul:
- Controllers bergantung pada Models untuk logika bisnis
- Views mengakses Controllers untuk data
- Middleware mengontrol akses antar Controllers

### 4.2 Component and Connector View (Pandangan Komponen dan Konektor)
#### Viewpoint: Runtime/Execution
**Tujuan**: Menunjukkan komponen runtime dan alur interaksi antar komponen selama eksekusi

**Deskripsi Komponen dan Konektor**:
- **Komponen Web Server**: Apache/Nginx
  - Konektor: HTTP/HTTPS ke Client Browser
- **Komponen Aplikasi PHP**: Laravel Framework
  - Konektor: Request/Response ke Web Server
- **Komponen Database**: MySQL
  - Konektor: Query/Result ke Aplikasi PHP
- **Komponen Client**: Browser Pengguna
  - Konektor: HTTP/HTTPS ke Web Server

**Alur Interaksi**:
1. Client Request → Web Server (Apache/Nginx)
2. Web Server → PHP Application (Laravel)
3. Application → Database (MySQL) untuk data
4. Database → Application dengan hasil
5. Application → Web Server dengan Response
6. Web Server → Client dengan tampilan

### 4.3 Allocation View (Pandangan Alokasi)
#### Viewpoint: Distribusi Sistem
**Tujuan**: Menunjukkan bagaimana elemen arsitektur dialokasikan ke elemen lingkungan

**Alokasi ke Lingkungan**:
- **Server Infrastructure**: 
  - Web Server: Apache/Nginx (Linux)
  - Application Server: PHP 8.2+ with Laravel 11.x
  - Database Server: MySQL 8.0+
- **Client Environment**: 
  - Supported Browsers: Chrome, Firefox, Safari, Edge (terbaru)
  - Device Support: Desktop, Tablet, Mobile (Responsive)

## 5. Konsep Arsitektur Penting

### 5.1 Arsitektur Aplikasi
Sistem mengikuti pola arsitektur web tradisional dengan pendekatan Model-View-Controller (MVC). Arsitektur ini menyediakan pemisahan yang jelas antara logika presentasi (Views), logika bisnis (Controllers), dan logika data (Models).

### 5.2 Arsitektur Data
- **Struktur Normalisasi**: Database dirancang dengan normalisasi tingkat tinggi untuk mencegah anomali data
- **Referential Integrity**: Ketergantungan antar tabel dijaga melalui foreign keys
- **Polymorphic Relations**: Fleksibilitas dalam hubungan antar entitas data

### 5.3 Arsitektur Keamanan
- **Otorisasi Berbasis Peran**: Middleware RBAC untuk kontrol akses
- **Validasi Input**: Request validation untuk mencegah exploitasi
- **Password Hashing**: Bcrypt untuk keamanan akun pengguna

## 6. Desain Arsitektur

### 6.1 Konsep Inti dan Relasi
- **User Entity**: Pusat dari sistem otentikasi dan otorisasi
- **Teacher Entity**: Inti dari sistem manajemen guru
- **Assessment Entity**: Pusat dari sistem evaluasi kompetensi
- **Role Entity**: Pengaturan akses berdasarkan peran pengguna

### 6.2 Prinsip Arsitektur
- **Prinsip Separation of Concerns**: Pemisahan antara presentasi, logika, dan data
- **Prinsip Information Hiding**: Abstraksi kompleksitas dalam modul
- **Prinsip Loose Coupling**: Modul saling independen sebisa mungkin
- **Prinsip High Cohesion**: Fungsi-fungsi terkait dikelompokkan dalam modul

### 6.3 Strategi Implementasi
- **Framework Laravel**: Memberikan struktur arsitektur yang konsisten
- **Eloquent ORM**: Abstraksi interaksi database
- **Blade Templates**: Presentasi yang konsisten dan aman
- **Request Validation**: Validasi input terpusat

## 7. Interface Arsitektur

### 7.1 Interface Pengguna (User Interface)
- **Web Interface**: Antarmuka berbasis web HTML5, CSS3 (Tailwind), JavaScript
- **Role-based Navigation**: Menu dan fitur bervariasi berdasarkan peran pengguna
- **Responsive Design**: Tampilan yang menyesuaikan dengan ukuran perangkat

### 7.2 Interface Sistem (System Interface)
- **HTTP Interface**: API komunikasi antara client dan server
- **Database Interface**: Query interface menggunakan Eloquent ORM
- **File Upload Interface**: Sistem upload dokumen menggunakan Filepond

### 7.3 Interface Eksternal (External Interface)
- **Email Interface**: Pengiriman notifikasi dan reset password
- **Excel Export Interface**: Integrasi Maatwebsite/Excel untuk ekspor data
- **Potential API Interface**: Ekspansi untuk integrasi sistem eksternal

## 8. Kepatuhan terhadap Standar ISO/IEC/IEEE 42010

### 8.1 Konformasi terhadap Standar
Dokumen ini memenuhi persyaratan ISO/IEC/IEEE 42010:2011 dengan menyediakan:
- Stakeholder dan concern yang jelas
- View dan viewpoint yang relevan
- Konsep arsitektur penting
- Deskripsi hubungan antar elemen
- Informasi yang diperlukan untuk pengambilan keputusan

### 8.2 Elemen Arsitektur
- **Concern**: Kepedulian stakeholder terhadap sistem
- **Viewpoint**: Perspektif dari stakeholder tertentu
- **View**: Representasi dari aspek tertentu dari sistem
- **Model**: Representasi formal dari elemen arsitektur
- **Framework**: Struktur untuk menyusun deskripsi arsitektur

## 9. Konfigurasi dan Deployment

### 9.1 Lingkungan Operasi
- **Server OS**: Linux (Ubuntu/Debian preferred)
- **Web Server**: Apache 2.4+ atau Nginx 1.18+
- **PHP Version**: 8.2 atau lebih tinggi
- **Database**: MySQL 8.0 atau MariaDB 10.4+
- **Cache**: Redis atau Database caching

### 9.2 Konfigurasi Keamanan
- **HTTPS Enforcement**: Semua komunikasi harus melalui HTTPS
- **Session Management**: Sistem sesi database dengan timeout
- **Input Sanitization**: Validasi dan sanitasi semua input pengguna
- **CSRF Protection**: Perlindungan terhadap serangan CSRF

## 10. Kinerja dan Skalabilitas

### 10.1 Metrik Kinerja
- **Jumlah Pengguna**: Mendukung >30,000 guru aktif
- **Jumlah Sekolah**: Mendukung >800 institusi pendidikan
- **Jumlah Assessment**: Mendukung >20,000 hasil asesmen
- **Waktu Respon**: <3 detik untuk operasi umum

### 10.2 Strategi Skalabilitas
- **Database Indexing**: Indeks pada kolom penting untuk query cepat
- **Query Optimization**: Eager loading untuk mencegah N+1 queries
- **Modular Architecture**: Pemisahan modul untuk scaling horizontal

## 11. Evaluasi Arsitektur

### 11.1 Kekuatan Arsitektur
- **Modularitas Tinggi**: Pemisahan yang jelas antar komponen
- **Skalabilitas**: Arsitektur dapat dikembangkan untuk fitur tambahan
- **Keamanan**: Sistem RBAC dan validasi input yang ketat
- **Maintainability**: Kode terstruktur dengan konvensi Laravel

### 11.2 Kekurangan dan Risiko
- **Ketergantungan Framework**: Ketergantungan tinggi pada Laravel
- **Kompleksitas Query**: Query agregasi kompleks untuk laporan
- **Kinerja Database**: Potensi bottleneck saat data terus bertambah

## 12. Rekomendasi dan Roadmap

### 12.1 Rekomendasi Arsitektur
- Implementasi caching untuk query agregat berat
- Pengenalan sistem queue untuk proses background
- Potensi API untuk integrasi mobile
- Sistem monitoring kesehatan sistem

### 12.2 Roadmap Pengembangan
- Implementasi API RESTful untuk akses eksternal
- Integrasi dengan sistem pendidikan nasional
- Pengembangan mobile application
- Penambahan sistem notifikasi real-time

---

**Lampiran A**: Diagram Arsitektur Komponen  
**Lampiran B**: Spesifikasi Teknis Server  
**Lampiran C**: Diagram Use Case  

**Catatan**: Dokumen ini merupakan bagian dari Arsitektur Sistem Informasi Guru Aceh (SiGuru) yang dirancang untuk mendukung transformasi digital dalam pengelolaan sumber daya manusia pendidik di Provinsi Aceh sesuai dengan standar ISO/IEC/IEEE 42010:2011.