# Guru Aceh Application - Software Requirements Specification (SRS)
**Dokumen Spesifikasi Kebutuhan Perangkat Lunak**

---

**Standar Referensi:** ISO/IEC/IEEE 29148:2018

**Tanggal Pembuatan:** 29 Oktober 2025
**Penulis:** Sistem Analis
**Versi:** 1.0

---

## 1. Pendahuluan (Introduction)

### 1.1 Tujuan (Purpose)
Dokumen ini merupakan Spesifikasi Kebutuhan Perangkat Lunak (Software Requirements Specification/SRS) untuk aplikasi web guru.acehapp.com. Tujuan dari dokumen ini adalah untuk menentukan secara rinci kebutuhan fungsional dan non-fungsional dari sistem aplikasi yang digunakan oleh guru-guru di Aceh dalam mendukung proses pendidikan.

### 1.2 Lingkup (Scope)
Aplikasi guru.acehapp.com adalah platform digital yang dirancang untuk mendukung kegiatan pendidikan bagi para guru di Aceh. Platform ini menyediakan berbagai fitur untuk manajemen pembelajaran, komunikasi pendidikan, serta sumber daya pendidikan yang relevan dengan konteks pendidikan di Aceh.

### 1.3 Definisi, Akronim, dan Singkatan
- **Guru Aceh App (guru.acehapp.com)**: Platform digital untuk mendukung kegiatan pendidikan guru-guru di Aceh
- **Siswa**: Peserta didik yang berada di bawah bimbingan guru
- **Admin**: Pengguna dengan hak akses tertinggi untuk mengelola sistem
- **Materi Pembelajaran**: Konten pendidikan yang digunakan dalam proses belajar mengajar
- **Kurikulum**: Pedoman resmi dalam pelaksanaan pembelajaran
- **API**: Application Programming Interface
- **UI**: User Interface
- **UX**: User Experience

### 1.4 Referensi
1. ISO/IEC/IEEE 29148:2018 - Systems and software engineering - Life cycle processes - Requirements engineering
2. Permendikbud Nomor 22 Tahun 2016 tentang Standar Proses Pendidikan
3. Kurikulum 2013 dan Kurikulum Merdeka Belajar
4. Panduan Penggunaan Teknologi Informasi dalam Pendidikan

### 1.5 Ikhtisar (Overview)
Bagian ini menyediakan informasi tentang struktur dokumen SRS, mencakup pendahuluan, deskripsi umum, persyaratan fungsional dan non-fungsional, serta kebutuhan antarmuka eksternal.

## 2. Deskripsi Umum (Overall Description)

### 2.1 Konteks Sistem (System Context)
Aplikasi guru.acehapp.com berfungsi sebagai sistem pendukung manajemen pendidikan yang menghubungkan antara guru, siswa, dan pihak administrasi pendidikan. Sistem ini berjalan sebagai platform web yang dapat diakses dari berbagai perangkat.

```
[Insert System Context Diagram Here]
```

### 2.2 Posisi Sistem (System Positioning)
- Pengguna Utama: Guru-guru di seluruh Aceh
- Sistem Pendukung: Sistem akademik sekolah, sistem pendataan pendidikan
- Integrasi Eksternal: Sistem Dinas Pendidikan Aceh, platform pembelajaran digital lainnya

### 2.3 Definisi dan Asumsi (Definitions and Assumptions)
- Asumsi konektivitas internet tersedia bagi pengguna
- Pengguna memiliki pengetahuan dasar dalam penggunaan aplikasi digital
- Sistem akan digunakan di seluruh wilayah Aceh dengan berbagai kondisi infrastruktur

### 2.4 Keterbatasan (Constraints)
- Keterbatasan bandwidth di beberapa daerah di Aceh
- Kebutuhan akan kompatibilitas dengan berbagai perangkat dan browser
- Kepatuhan terhadap regulasi perlindungan data pendidikan

### 2.5 Fungsi-fungsi Sistem (System Functions)
- Manajemen pembelajaran
- Komunikasi antar guru dan administrator
- Penyediaan sumber daya pendidikan
- Pelaporan dan evaluasi pendidikan
- Pengelolaan data siswa dan kelas

### 2.6 Karakteristik Pengguna (User Characteristics)
- Guru aktif di sekolah-sekolah di Aceh
- Memiliki pengetahuan dasar komputer
- Menggunakan sistem untuk mendukung kegiatan mengajar

## 3. Persyaratan Fungsional (Functional Requirements)

### 3.1 Modul Otentikasi (Authentication Module)
**FR-001 - Register Pengguna**
- ID: FR-001
- Deskripsi: Sistem harus memungkinkan guru untuk mendaftar sebagai pengguna baru
- Input: Nama, email, NIP, password, sekolah, dan informasi lainnya
- Output: Konfirmasi registrasi dan akun pengguna
- Kondisi Awal: Pengguna belum memiliki akun
- Kondisi Akhir: Pengguna memiliki akun yang dapat digunakan untuk login

**FR-002 - Login Pengguna**
- ID: FR-002
- Deskripsi: Sistem harus memungkinkan pengguna untuk login menggunakan kredensial
- Input: Email dan password
- Output: Akses ke dashboard pengguna
- Kondisi Awal: Pengguna memiliki akun yang valid
- Kondisi Akhir: Pengguna diotentikasi dan dapat mengakses fitur sesuai peran

**FR-003 - Reset Password**
- ID: FR-003
- Deskripsi: Sistem harus memungkinkan pengguna untuk mereset password jika lupa
- Input: Email terdaftar
- Output: Link reset password dikirim ke email
- Kondisi Awal: Pengguna mengakses halaman lupa password
- Kondisi Akhir: Link reset dikirim ke email pengguna

### 3.2 Modul Profil Pengguna (User Profile Module)
**FR-004 - Lihat Profil**
- ID: FR-004
- Deskripsi: Pengguna dapat melihat informasi profil mereka
- Input: Tidak ada
- Output: Informasi profil lengkap
- Kondisi Awal: Pengguna telah login
- Kondisi Akhir: Informasi profil ditampilkan

**FR-005 - Edit Profil**
- ID: FR-005
- Deskripsi: Pengguna dapat memperbarui informasi profil mereka
- Input: Informasi profil yang diperbarui
- Output: Konfirmasi perubahan profil
- Kondisi Awal: Pengguna telah login dan mengakses edit profil
- Kondisi Akhir: Informasi profil telah diperbarui

### 3.3 Modul Manajemen Kelas (Class Management Module)
**FR-006 - Buat Kelas**
- ID: FR-006
- Deskripsi: Guru dapat membuat kelas baru untuk mengelola siswa
- Input: Nama kelas, mata pelajaran, tingkat kelas
- Output: Kelas baru dibuat dengan ID unik
- Kondisi Awal: Guru telah login
- Kondisi Akhir: Kelas baru tersedia untuk dikelola

**FR-007 - Tambah Siswa ke Kelas**
- ID: FR-007
- Deskripsi: Guru dapat menambahkan siswa ke dalam kelas
- Input: Daftar siswa (NIS, nama, dll)
- Output: Konfirmasi penambahan siswa
- Kondisi Awal: Guru memiliki akses ke kelas
- Kondisi Akhir: Siswa ditambahkan ke kelas

**FR-008 - Lihat Daftar Siswa**
- ID: FR-008
- Deskripsi: Guru dapat melihat daftar siswa dalam kelas
- Input: ID kelas
- Output: Daftar siswa dalam kelas
- Kondisi Awal: Guru memiliki akses ke kelas
- Kondisi Akhir: Daftar siswa ditampilkan

### 3.4 Modul Materi Pembelajaran (Learning Material Module)
**FR-009 - Upload Materi**
- ID: FR-009
- Deskripsi: Guru dapat mengunggah materi pembelajaran
- Input: File materi dan deskripsi
- Output: Materi tersedia untuk siswa
- Kondisi Awal: Guru telah login dan memiliki akses ke kelas
- Kondisi Akhir: Materi tersedia di kelas

**FR-010 - Lihat Materi**
- ID: FR-010
- Deskripsi: Siswa dapat melihat materi yang diunggah oleh guru
- Input: ID kelas
- Output: Daftar materi pembelajaran
- Kondisi Awal: Siswa terdaftar di kelas
- Kondisi Akhir: Daftar materi ditampilkan

### 3.5 Modul Komunikasi (Communication Module)
**FR-011 - Kirim Pengumuman**
- ID: FR-011
- Deskripsi: Guru dapat mengirim pengumuman kepada siswa
- Input: Isi pengumuman, penerima (kelas)
- Output: Pengumuman terkirim
- Kondisi Awal: Guru telah login
- Kondisi Akhir: Pengumuman diterima oleh siswa

**FR-012 - Forum Diskusi**
- ID: FR-012
- Deskripsi: Sistem menyediakan forum diskusi antara guru dan siswa
- Input: Pesan baru atau balasan
- Output: Diskusi terupdate
- Kondisi Awal: Pengguna telah login
- Kondisi Akhir: Pesan ditampilkan di forum

### 3.6 Modul Penilaian (Assessment Module)
**FR-013 - Input Nilai**
- ID: FR-013
- Deskripsi: Guru dapat memasukkan nilai siswa
- Input: Nilai siswa, jenis penilaian, tanggal
- Output: Nilai tersimpan
- Kondisi Awal: Guru telah login dan memiliki akses ke kelas
- Kondisi Akhir: Nilai siswa disimpan dalam sistem

**FR-014 - Generate Laporan Nilai**
- ID: FR-014
- Deskripsi: Guru dapat menghasilkan laporan nilai siswa
- Input: Parameter laporan (kelas, periode, dll)
- Output: Laporan nilai dalam format yang dapat diunduh
- Kondisi Awal: Guru telah login
- Kondisi Akhir: Laporan tersedia untuk diunduh

### 3.7 Modul Pelaporan (Reporting Module)
**FR-015 - Lihat Statistik Kelas**
- ID: FR-015
- Deskripsi: Guru dapat melihat statistik kelas
- Input: ID kelas
- Output: Statistik kelas (kehadiran, nilai, dll)
- Kondisi Awal: Guru memiliki akses ke kelas
- Kondisi Akhir: Statistik kelas ditampilkan

## 4. Persyaratan Non-Fungsional (Non-Functional Requirements)

### 4.1 Kinerja (Performance Requirements)
**NFR-001 - Waktu Respon**
- Deskripsi: Sistem harus merespon permintaan pengguna dalam waktu kurang dari 3 detik
- Kondisi: Normal load (maksimal 1000 pengguna aktif simultan)
- Kriteria: 95% permintaan diselesaikan dalam waktu < 3 detik

**NFR-002 - Throughput**
- Deskripsi: Sistem harus mampu menangani minimal 500 permintaan per detik
- Kondisi: Normal load
- Kriteria: Tidak ada penurunan kinerja yang signifikan

**NFR-003 - Kapasitas**
- Deskripsi: Sistem harus mendukung hingga 100.000 pengguna terdaftar
- Kondisi: Jumlah total pengguna
- Kriteria: Sistem tetap stabil dan responsif

### 4.2 Kegunaan (Usability Requirements)
**NFR-004 - Intuitifitas**
- Deskripsi: Antarmuka pengguna harus intuitif dan mudah digunakan oleh guru
- Kondisi: Pengguna baru yang belum familiar dengan sistem
- Kriteria: Pengguna baru dapat menyelesaikan task utama dalam waktu < 10 menit pelatihan

**NFR-005 - Aksesibilitas**
- Deskripsi: Sistem harus bisa diakses oleh pengguna dengan berbagai kondisi
- Kondisi: Semua pengguna
- Kriteria: Memenuhi standar WCAG 2.1 Level AA

**NFR-006 - Bantuan dan Panduan**
- Deskripsi: Sistem harus menyediakan bantuan dan panduan penggunaan
- Kondisi: Saat pengguna membutuhkan bantuan
- Kriteria: Bantuan tersedia dalam bentuk tooltips, FAQ, dan dokumentasi

### 4.3 Keamanan (Security Requirements)
**NFR-007 - Otentikasi**
- Deskripsi: Sistem harus mengotentikasi semua pengguna sebelum memberikan akses
- Kondisi: Saat pengguna mencoba mengakses fitur yang dilindungi
- Kriteria: Otentikasi wajib sebelum akses diberikan

**NFR-008 - Enkripsi Data**
- Deskripsi: Data sensitif harus dienkripsi saat disimpan dan saat transmisi
- Kondisi: Saat menyimpan atau mentransmisikan data sensitif
- Kriteria: Menggunakan TLS 1.3 dan enkripsi AES-256

**NFR-009 - Hak Akses**
- Deskripsi: Sistem harus menerapkan kontrol hak akses berdasarkan peran
- Kondisi: Saat pengguna mengakses fitur
- Kriteria: Hanya pengguna dengan hak akses yang sesuai yang dapat mengakses fitur

### 4.4 Kehandalan (Reliability Requirements)
**NFR-010 - Waktu Hidup (Uptime)**
- Deskripsi: Sistem harus tersedia 99.5% dari waktu dalam satu bulan
- Kondisi: Normal operation
- Kriteria: Downtime < 36 jam per bulan

**NFR-011 - Pemulihan Bencana**
- Deskripsi: Sistem harus dapat dipulihkan dalam waktu maksimal 4 jam setelah kegagalan
- Kondisi: Terjadi kegagalan sistem
- Kriteria: Sistem beroperasi kembali dalam 4 jam

### 4.5 Pemeliharaan (Maintainability Requirements)
**NFR-012 - Modularitas**
- Deskripsi: Kode harus modular untuk memudahkan pemeliharaan dan pengembangan
- Kondisi: Seluruh kode aplikasi
- Kriteria: Modul bersifat loosely coupled dan highly cohesive

**NFR-013 - Dokumentasi Kode**
- Deskripsi: Semua kode harus didokumentasikan dengan baik
- Kondisi: Setiap penambahan atau perubahan kode
- Kriteria: Komentar dan dokumentasi memenuhi standar

### 4.6 Portabilitas (Portability Requirements)
**NFR-014 - Kompatibilitas Browser**
- Deskripsi: Sistem harus dapat berjalan di semua browser modern
- Kondisi: Menggunakan browser Chrome, Firefox, Safari, dan Edge terbaru
- Kriteria: Fungsionalitas utama tersedia di semua browser yang didukung

**NFR-015 - Responsif**
- Deskripsi: Tampilan harus responsif untuk berbagai ukuran perangkat
- Kondisi: Akses dari desktop, tablet, dan mobile
- Kriteria: Tampilan sesuai dengan ukuran layar

## 5. Persyaratan Antarmuka Eksternal (External Interface Requirements)

### 5.1 Antarmuka Pengguna (User Interfaces)
**EI-001 - Dashboard**
- Deskripsi: Tampilan utama untuk pengguna setelah login
- Format: HTML, CSS, JavaScript
- Standar: Antarmuka web responsif yang kompatibel dengan berbagai ukuran layar

**EI-002 - Formulir**
- Deskripsi: Antarmuka untuk memasukkan data
- Format: HTML form dengan validasi
- Standar: Pengalaman pengguna yang konsisten dan validasi real-time

### 5.2 Antarmuka API (API Interfaces)
**EI-003 - REST API**
- Deskripsi: Antarmuka untuk integrasi sistem eksternal
- Format: RESTful API dengan JSON
- Standar: OAuth 2.0 untuk otentikasi dan autorisasi

**EI-004 - Webhook**
- Deskripsi: Mekanisme untuk mengirimkan data secara real-time ke sistem eksternal
- Format: HTTP POST dengan payload JSON
- Standar: Autentikasi dan verifikasi sumber data

### 5.3 Antarmuka Perangkat Keras (Hardware Interfaces)
**NFR-016 - Kompatibilitas Perangkat**
- Deskripsi: Sistem harus dapat diakses dari berbagai perangkat
- Standar: Mendukung desktop, laptop, tablet, dan smartphone

### 5.4 Antarmuka Jaringan (Network Interfaces)
**NFR-017 - Protokol Jaringan**
- Deskripsi: Sistem harus mendukung protokol jaringan standar
- Standar: HTTP/HTTPS, TCP/IP, DNS

## 6. Matriks Jejakbilitas (Traceability Matrix)

| ID Kebutuhan | Kode Modul | Tujuan Bisnis | Prioritas | Sumber |
|--------------|------------|---------------|-----------|---------|
| FR-001 | AUTH | Membuat akun pengguna | Tinggi | Kebijakan pendidikan |
| FR-002 | AUTH | Mendapatkan akses ke sistem | Tinggi | Kebijakan pendidikan |
| FR-003 | AUTH | Pemulihan akses akun | Sedang | Kebijakan pendidikan |
| FR-004 | PROFILE | Menampilkan informasi pengguna | Sedang | Kebijakan pendidikan |
| FR-005 | PROFILE | Memperbarui informasi pengguna | Sedang | Kebijakan pendidikan |
| FR-006 | CLASS | Mengelola kelas pengajaran | Tinggi | Kebijakan pendidikan |
| FR-007 | CLASS | Mengelola daftar siswa | Tinggi | Kebijakan pendidikan |
| FR-008 | CLASS | Menampilkan daftar siswa | Tinggi | Kebijakan pendidikan |
| FR-009 | MATERIAL | Mengelola materi pembelajaran | Tinggi | Kebijakan pendidikan |
| FR-010 | MATERIAL | Menyediakan materi pembelajaran | Tinggi | Kebijakan pendidikan |
| FR-011 | COMM | Mengirimkan informasi penting | Tinggi | Kebijakan pendidikan |
| FR-012 | COMM | Memfasilitasi komunikasi | Sedang | Kebijakan pendidikan |
| FR-013 | ASSESS | Mengelola nilai siswa | Tinggi | Kebijakan pendidikan |
| FR-014 | REPORT | Menyediakan laporan pendidikan | Tinggi | Kebijakan pendidikan |
| FR-015 | REPORT | Menyediakan statistik pendidikan | Sedang | Kebijakan pendidikan |

## 7. Kriteria Penerimaan (Acceptance Criteria)

### 7.1 Fitur Otentikasi
- Pengguna dapat mendaftar, login, dan logout tanpa kesalahan
- Reset password berfungsi dengan benar
- Keamanan otentikasi terpenuhi sesuai standar

### 7.2 Fitur Manajemen Kelas
- Guru dapat membuat dan mengelola kelas
- Guru dapat menambahkan dan mengelola siswa
- Fitur kelas dapat diakses dengan lancar

### 7.3 Fitur Materi Pembelajaran
- Guru dapat mengunggah dan mengelola materi
- Siswa dapat mengakses materi yang tersedia
- File dapat diunggah tanpa kesalahan

### 7.4 Fitur Komunikasi
- Pengumuman dapat dikirim secara efektif
- Forum diskusi berfungsi dengan baik
- Pesan terkirim dan diterima dengan benar

### 7.5 Fitur Penilaian
- Nilai dapat dimasukkan dan dikelola
- Laporan nilai dapat dihasilkan
- Data nilai aman dan dapat diakses dengan benar

---

**Lampiran:**
- Glossary of Terms
- Use Case Diagrams
- User Story Map