# Aplikasi AKKS - Software Design Description (SDD)
**Dokumen Deskripsi Desain Perangkat Lunak**

---

**Standar Referensi:** IEEE 1016-2009

**Tanggal Pembuatan:** 29 Oktober 2025
**Penulis:** Sistem Arsitek
**Versi:** 1.0

---

## 1. Pendahuluan (Introduction)

### 1.1 Tujuan (Purpose)
Dokumen ini merupakan deskripsi desain perangkat lunak (Software Design Description/SDD) untuk aplikasi AKKS (Aplikasi Klarifikasi dan Komunikasi Sekolah) yang berada di dev.akks.pusakagtkaceh.id. Tujuan dari dokumen ini adalah memberikan gambaran rinci tentang arsitektur dan desain sistem, termasuk struktur, komponen, antarmuka, dan fungsi-fungsi yang dirancang untuk memenuhi kebutuhan fungsional dan non-fungsional yang telah ditentukan dalam SRS.

### 1.2 Lingkup (Scope)
Dokumen ini mencakup desain arsitektur sistem, komponen perangkat lunak, desain data, desain antarmuka, dan pertimbangan implementasi untuk aplikasi AKKS. Ini berfungsi sebagai panduan teknis untuk pengembang dalam mengimplementasikan sistem sesuai dengan spesifikasi kebutuhan.

### 1.3 Referensi ke SRS (Reference to SRS)
- Nama Dokumen: Aplikasi AKKS - Software Requirements Specification
- Nomor Revisi: 1.0
- Tanggal: 29 Oktober 2025
- Penulis: Sistem Analis

### 1.4 Referensi Lain (Other References)
1. IEEE 1016-2009 - IEEE Recommended Practice for Software Design Descriptions
2. TOGAF 9.2 Standard for Enterprise Architecture
3. ISO/IEC/IEEE 42010 - Systems and software engineering — Architecture description
4. MySQL 8.0 Documentation
5. Standar Pengembangan Aplikasi Web

### 1.5 Ikhtisar (Overview)
Dokumen ini terstruktur dalam beberapa bagian utama: deskripsi arsitektur keseluruhan, desain komponen, desain data, desain antarmuka, desain proses, dan pertimbangan implementasi.

## 2. Gambaran Arsitektural (Architectural Overview)

### 2.1 Deskripsi Umum (General Description)
Aplikasi AKKS mengadopsi pendekatan arsitektur berbasis layanan (Service-Oriented Architecture) dengan pola arsitektur tiga lapis (3-tier architecture) yang mencakup:
- Lapisan Presentasi (Presentation Layer)
- Lapisan Logika Bisnis (Business Logic Layer)
- Lapisan Data (Data Layer)

Sistem ini menggunakan database MySQL dengan username: root dan password: VDkt52xIv7RMuN5u.

### 2.2 Diagram Arsitektur (Architecture Diagrams)

```mermaid
graph TB
    subgraph "Client Layer"
        A[Web Browser]
        B[Mobile Device]
    end
    
    subgraph "Presentation Layer"
        C[Frontend Application]
        D[API Gateway]
    end
    
    subgraph "Business Logic Layer"
        E[Authentication Service]
        F[School Management Service]
        G[Clarification Service]
        H[Communication Service]
        I[Reporting Service]
    end
    
    subgraph "Data Layer"
        J[User Database]
        K[School Database]
        L[Clarification Database]
        M[MySQL Server<br/>User: root<br/>Pass: VDkt52xIv7RMuN5u]
    end
    
    A --> C
    B --> C
    C --> D
    D --> E
    D --> F
    D --> G
    D --> H
    D --> I
    E --> M
    F --> M
    G --> M
    H --> M
    I --> M
    J --> M
    K --> M
    L --> M
```

### 2.3 Prinsip-Prinsip Desain (Design Principles)
- Separation of Concerns: Memisahkan tanggung jawab antar komponen
- Scalability: Desain yang dapat berkembang sesuai kebutuhan
- Maintainability: Kode yang mudah dipelihara dan dimodifikasi
- Security by Design: Keamanan diterapkan sejak tahap desain
- Performance: Optimalisasi kinerja dari awal desain

## 3. Desain Komponen (Component Design)

### 3.1 Modul Otentikasi (Authentication Module)

```mermaid
classDiagram
    class AuthenticationService {
        +authenticateUser(credentials): boolean
        +registerUser(userDetails): boolean
        +logoutUser(token): boolean
        +generateJWTToken(user): string
        +verifyToken(token): User
    }
    
    class PasswordEncoder {
        +encodePassword(rawPassword): string
        +matchPassword(rawPassword, encodedPassword): boolean
    }
    
    class TokenManager {
        +createToken(user): string
        +validateToken(token): boolean
        +expireToken(token): void
    }
    
    AuthenticationService --> PasswordEncoder
    AuthenticationService --> TokenManager
```

**Deskripsi:**
- Modul ini bertanggung jawab untuk otentikasi dan otorisasi pengguna
- Menggunakan JWT (JSON Web Token) untuk manajemen sesi
- Mengimplementasikan enkripsi password menggunakan algoritma Bcrypt

### 3.2 Modul Manajemen Sekolah (School Management Module)

```mermaid
classDiagram
    class SchoolManager {
        +createSchool(schoolDetails): School
        +getSchool(schoolId): School
        +updateSchool(schoolId, schoolDetails): School
        +deleteSchool(schoolId): boolean
        +getSchoolsByRegion(region): List~School~
        +validateSchoolData(schoolData): ValidationResult
    }
    
    class School {
        +schoolId: string
        +schoolName: string
        +address: string
        +schoolLevel: string
        +principal: string
        +phoneNumber: string
        +email: string
        +studentCount: number
        +teacherCount: number
        +establishedYear: number
    }
    
    SchoolManager --> School
```

**Deskripsi:**
- Modul ini mengelola data sekolah
- Menyediakan fungsi CRUD (Create, Read, Update, Delete) untuk sekolah
- Melakukan validasi data sekolah sebelum disimpan

### 3.3 Modul Klarifikasi (Clarification Module)

```mermaid
classDiagram
    class ClarificationManager {
        +createClarificationRequest(requestData): ClarificationRequest
        +getClarificationRequest(requestId): ClarificationRequest
        +updateClarificationStatus(requestId, status): ClarificationRequest
        +getClarificationsByStatus(status): List~ClarificationRequest~
        +getClarificationsBySchool(schoolId): List~ClarificationRequest~
    }
    
    class ClarificationRequest {
        +requestId: string
        +schoolId: string
        +requestType: string
        +description: string
        +status: string
        +submittedDate: DateTime
        +processedDate: DateTime
        +notes: string
        +supportingDocs: List~string~
        +assignedTo: string
    }
    
    ClarificationManager --> ClarificationRequest
```

**Deskripsi:**
- Modul ini mengelola permintaan klarifikasi dari sekolah
- Melacak status dan proses klarifikasi
- Menyediakan fungsi untuk mengelola dokumen pendukung

### 3.4 Modul Komunikasi (Communication Module)

```mermaid
classDiagram
    class CommunicationManager {
        +sendNotification(notificationData): Notification
        +createDiscussionForum(forumData): DiscussionForum
        +postToForum(forumId, postData): Post
        +getForumPosts(forumId): List~Post~
    }
    
    class Notification {
        +notificationId: string
        +title: string
        +content: string
        +targetUserId: string
        +targetSchoolId: string
        +sendDate: DateTime
        +isRead: boolean
        +priority: string
    }
    
    class DiscussionForum {
        +forumId: string
        +title: string
        +description: string
        +creatorId: string
        +startDate: DateTime
        +posts: List~Post~
        +isArchived: boolean
    }
    
    class Post {
        +postId: string
        +content: string
        +authorId: string
        +date: DateTime
        +forumId: string
    }
    
    CommunicationManager --> Notification
    CommunicationManager --> DiscussionForum
    CommunicationManager --> Post
    DiscussionForum --> Post
```

**Deskripsi:**
- Modul ini mengelola komunikasi antar lembaga pendidikan
- Menyediakan sistem notifikasi dan forum diskusi
- Menyimpan riwayat komunikasi

### 3.5 Modul Pelaporan (Reporting Module)

```mermaid
classDiagram
    class ReportManager {
        +generateClarificationReport(criteria): Report
        +generateSchoolReport(schoolId): Report
        +getSummaryReport(period): Report
        +exportReport(reportId, format): File
    }
    
    class Report {
        +reportId: string
        +title: string
        +type: string
        +generatedDate: DateTime
        +generatedBy: string
        +data: object
        +format: string
        +status: string
    }
    
    ReportManager --> Report
```

**Deskripsi:**
- Modul ini menghasilkan laporan berkala dan sesuai permintaan
- Menyediakan berbagai format ekspor laporan
- Mengelola proses pembuatan dan distribusi laporan

## 4. Desain Data (Data Design)

### 4.1 Model Data Konseptual (Conceptual Data Model)

```mermaid
erDiagram
    USER {
        string user_id PK
        string name
        string email
        string password_hash
        string role
        string school_id FK
        datetime created_date
        datetime last_login
        boolean is_active
    }
    
    SCHOOL {
        string school_id PK
        string school_name
        string address
        string school_level
        string principal
        string phone_number
        string email
        number student_count
        number teacher_count
        number established_year
        datetime created_date
        datetime updated_date
        boolean is_active
    }
    
    CLARIFICATION_REQUEST {
        string request_id PK
        string school_id FK
        string request_type
        string description
        string status
        datetime submitted_date
        datetime processed_date
        string notes
        string assigned_to
        boolean is_resolved
    }
    
    SUPPORTING_DOCUMENT {
        string doc_id PK
        string request_id FK
        string file_path
        string file_name
        string file_type
        number file_size
        datetime upload_date
    }
    
    NOTIFICATION {
        string notification_id PK
        string title
        string content
        string target_user_id FK
        string target_school_id FK
        datetime send_date
        boolean is_read
        string priority
    }
    
    DISCUSSION_FORUM {
        string forum_id PK
        string title
        string description
        string creator_id FK
        datetime created_date
        datetime updated_date
        boolean is_archived
    }
    
    FORUM_POST {
        string post_id PK
        string content
        string author_id FK
        string forum_id FK
        datetime post_date
        string parent_post_id FK
    }
    
    REPORT {
        string report_id PK
        string title
        string type
        string generated_by FK
        datetime generated_date
        object report_data
        string format
        string file_path
    }
    
    USER ||--o{ NOTIFICATION : receives
    SCHOOL ||--o{ USER : employs
    SCHOOL ||--o{ CLARIFICATION_REQUEST : submits
    SCHOOL ||--o{ DISCUSSION_FORUM : creates
    CLARIFICATION_REQUEST ||--o{ SUPPORTING_DOCUMENT : has
    DISCUSSION_FORUM ||--o{ FORUM_POST : contains
    USER ||--o{ REPORT : generates
```

### 4.2 Model Data Logis (Logical Data Model)

**Tabel User:**
- user_id: string (Primary Key, UUID)
- name: string (Not Null)
- email: string (Unique, Not Null)
- password_hash: string (Not Null)
- role: enum('admin', 'school_officer', 'staff')
- school_id: string (Foreign Key to School, Nullable for admin)
- created_date: datetime
- last_login: datetime
- is_active: boolean (Default: true)

**Tabel School:**
- school_id: string (Primary Key, UUID)
- school_name: string (Not Null)
- address: string (Not Null)
- school_level: enum('sd', 'smp', 'sma', 'smk', 'slb') (Not Null)
- principal: string
- phone_number: string
- email: string
- student_count: integer
- teacher_count: integer
- established_year: integer
- created_date: datetime
- updated_date: datetime
- is_active: boolean (Default: true)

**Tabel ClarificationRequest:**
- request_id: string (Primary Key, UUID)
- school_id: string (Foreign Key to School)
- request_type: string (Not Null)
- description: text (Not Null)
- status: enum('pending', 'in_progress', 'resolved', 'rejected') (Default: 'pending')
- submitted_date: datetime (Not Null)
- processed_date: datetime
- notes: text
- assigned_to: string (Foreign Key to User)
- is_resolved: boolean (Default: false)

**Tabel SupportingDocument:**
- doc_id: string (Primary Key, UUID)
- request_id: string (Foreign Key to ClarificationRequest)
- file_path: string (Not Null)
- file_name: string (Not Null)
- file_type: string (Not Null)
- file_size: integer (Not Null)
- upload_date: datetime (Not Null)

### 4.3 Model Data Fisik (Physical Data Model)
- Database: MySQL
- Engine: InnoDB
- Koneksi: username: root, password: VDkt52xIv7RMuN5u
- Indeks pada kolom yang sering diquery
- Partisi tabel besar berdasarkan tanggal

## 5. Desain Antarmuka (Interface Design)

### 5.1 Antarmuka API (API Interface Design)

#### 5.1.1 Endpoints Otentikasi
```
POST /api/auth/login
Request: { "email": "string", "password": "string" }
Response: { "token": "string", "user": {...} }

POST /api/auth/register
Request: { "name": "string", "email": "string", "password": "string", "school_id": "string", "role": "string" }
Response: { "message": "string", "user": {...} }

POST /api/auth/logout
Authorization: Bearer <token>
Response: { "message": "string" }
```

#### 5.1.2 Endpoints Manajemen Sekolah
```
GET /api/schools
Authorization: Bearer <token>
Response: [{ "school_id": "string", "school_name": "string", ... }]

POST /api/schools
Authorization: Bearer <token>
Request: { "school_name": "string", "address": "string", ... }
Response: { "school_id": "string", "message": "string" }

GET /api/schools/{school_id}
Authorization: Bearer <token>
Response: { "school_id": "string", "school_name": "string", ... }

PUT /api/schools/{school_id}
Authorization: Bearer <token>
Request: { "school_name": "string", "address": "string", ... }
Response: { "message": "string" }
```

#### 5.1.3 Endpoints Klarifikasi
```
GET /api/clarifications
Authorization: Bearer <token>
Response: [{ "request_id": "string", "request_type": "string", ... }]

POST /api/clarifications
Authorization: Bearer <token>
Request: { "request_type": "string", "description": "string", ... }
Response: { "request_id": "string", "message": "string" }

GET /api/clarifications/{request_id}
Authorization: Bearer <token>
Response: { "request_id": "string", "description": "string", ... }

PUT /api/clarifications/{request_id}
Authorization: Bearer <token>
Request: { "status": "string", "notes": "string", "assigned_to": "string" }
Response: { "message": "string" }
```

#### 5.1.4 Endpoints Dokumen Pendukung
```
POST /api/clarifications/{request_id}/documents
Authorization: Bearer <token>
Content-Type: multipart/form-data
Request: { "file": "file" }
Response: { "doc_id": "string", "message": "string" }

GET /api/documents/{doc_id}/download
Authorization: Bearer <token>
Response: File download
```

### 5.2 Antarmuka Pengguna (UI Component Design)

#### 5.2.1 Komponen Dashboard
```
Dashboard Layout:
- Sidebar: Menu navigasi
- Header: Informasi pengguna dan notifikasi
- Main Content: Ringkasan informasi dan statistik
- Footer: Informasi sistem
```

#### 5.2.2 Komponen Form Klarifikasi
```
Clarification Form Component:
- Input jenis permintaan
- Area teks untuk deskripsi
- Upload dokumen pendukung
- Tombol kirim permintaan
```

## 6. Desain Proses (Process Design)

### 6.1 Diagram Alur Proses (Process Flow Diagram)

```mermaid
flowchart TD
    A[User Access AKKS Application] --> B{User Authenticated?}
    B -->|No| C[Redirect to Login Page]
    C --> D[User Login Process]
    D --> E[Validate Credentials with MySQL DB<br/>User: root<br/>Pass: VDkt52xIv7RMuN5u]
    E --> F{Valid?}
    F -->|Yes| G[Create Session & Token]
    F -->|No| H[Display Error Message]
    H --> C
    G --> I[Access Dashboard]
    I --> J[Select Function]
    J --> K[Process Request]
    K --> L[Store/Retrieve Data from MySQL]
    L --> M[Return Response]
    M --> N[Display Result]
```

### 6.2 Diagram Urutan (Sequence Diagram)

```mermaid
sequenceDiagram
    participant U as User
    participant B as Browser
    participant A as API Gateway
    participant S as Authentication Service
    P as School Management Service
    C as Clarification Service
    D as MySQL Database<br/>User: root<br/>Pass: VDkt52xIv7RMuN5u
    
    U->>B: Akses halaman login
    B->>A: Request login form
    A->>B: Return login form
    U->>B: Masukkan kredensial
    B->>A: POST /login credentials
    A->>S: Validate credentials
    S->>D: Verify user credentials in MySQL
    D-->>S: Return user data
    S-->>A: Return JWT token
    A-->>B: Return session token
    B-->>U: Redirect to dashboard
    U->>B: Akses formulir klarifikasi
    B->>A: Request clarification form
    A->>C: Initialize clarification process
    C-->>B: Return clarification form
    B-->>U: Tampilkan formulir
    U->>B: Isi dan kirim formulir
    B->>A: POST clarification request
    A->>C: Process clarification request
    C->>D: Store clarification request in MySQL
    D-->>C: Confirmation stored
    C-->>A: Return success response
    A-->>B: Return success response
    B-->>U: Tampilkan konfirmasi
```

### 6.3 Diagram Aktivitas (Activity Diagram)

```mermaid
flowchart
    Start([Start: Submit Clarification Request]) --> A[User accesses clarification form]
    A --> B[Fill in request details]
    B --> C[Upload supporting documents]
    C --> D{All required fields filled?}
    D -->|No| E[Display validation errors]
    E --> B
    D -->|Yes| F[Submit request to system]
    F --> G[Validate data format]
    G --> H{Valid format?}
    H -->|No| I[Return to form with errors]
    I --> B
    H -->|Yes| J[Store request in MySQL DB]
    J --> K[Generate request ID]
    K --> L[Store documents in file system]
    L --> M[Update request with document references]
    M --> N[Send notification to admin]
    N --> O[Set status to PENDING]
    O --> P[Return success confirmation]
    P --> Q([End: Request Successfully Submitted])
```

## 7. Desain Non-Fungsional (Non-Functional Design)

### 7.1 Desain Keamanan (Security Design)
- Otentikasi berbasis JWT token
- Otorisasi berbasis peran (Role-Based Access Control)
- Enkripsi data sensitif di database MySQL
- Validasi input untuk mencegah serangan SQL Injection dan XSS
- Rate limiting untuk mencegah abuse API
- Koneksi aman ke database dengan kredensial: username root, password VDkt52xIv7RMuN5u

### 7.2 Desain Skalabilitas (Scalability Design)
- Arsitektur mikroservis untuk kemudahan scaling
- Penggunaan cache (Redis) untuk data yang sering diakses
- Load balancing untuk distribusi beban
- Database clustering dan replikasi MySQL

### 7.3 Desain Ketersediaan (Availability Design)
- Sistem backup dan failover
- Monitoring dan alerting sistem
- Penanganan error yang robust
- Graceful degradation untuk komponen yang tidak penting

### 7.4 Desain Pemeliharaan (Maintainability Design)
- Kode modular dan terdokumentasi
- Logging komprehensif
- Monitoring dan metric
- Konfigurasi yang fleksibel

## 8. Pertimbangan Implementasi (Implementation Considerations)

### 8.1 Teknologi yang Digunakan (Technology Stack)
- Backend: PHP/Python/Node.js
- Frontend: React.js, Vue.js, atau framework HTML5
- Database: MySQL (username: root, password: VDkt52xIv7RMuN5u)
- Web Server: Apache/Nginx
- File Storage: Sistem file lokal atau cloud storage

### 8.2 Pustaka dan Framework (Libraries and Frameworks)
- Otentikasi: JWT atau library auth bawaan framework
- Validasi: Library validasi input
- Database ORM: Library koneksi MySQL
- Dokumentasi API: Swagger atau OpenAPI

### 8.3 Alat Pengembangan (Development Tools)
- Version Control: Git
- CI/CD: GitHub Actions atau GitLab CI
- Deployment: Docker atau deployment script
- Database Management: phpMyAdmin atau MySQL Workbench

### 8.4 Spesifikasi Koneksi Database
- Database Server: MySQL
- Host: localhost (berdasarkan informasi dari folder aplikasi)
- Port: 3306 (default)
- Username: root
- Password: VDkt52xIv7RMuN5u
- Database Name: akks_db (asumsi)

## 9. Pertimbangan Uji Coba (Testing Considerations)

### 9.1 Strategi Pengujian (Testing Strategy)
- Unit Testing: Pengujian komponen individual
- Integration Testing: Pengujian integrasi antar komponen
- End-to-End Testing: Pengujian alur pengguna secara menyeluruh
- Security Testing: Pengujian keamanan sistem
- Performance Testing: Pengujian kinerja dan beban
- Database Testing: Pengujian koneksi dan operasi database dengan kredensial yang ditentukan

### 9.2 Alat Uji Coba (Testing Tools)
- Unit Testing: Framework testing sesuai bahasa backend
- End-to-End Testing: Selenium atau Cypress
- Load Testing: JMeter atau Artillery
- Security Testing: OWASP ZAP atau tools sejenis
- Database Testing: Alat pengujian koneksi MySQL

---

**Lampiran:**
- Diagram UML Detail
- Spesifikasi API Lengkap
- Panduan Deployment
- Dokumentasi Konfigurasi Database MySQL