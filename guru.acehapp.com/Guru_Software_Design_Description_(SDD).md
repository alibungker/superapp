# Guru Aceh Application - Software Design Description (SDD)
**Dokumen Deskripsi Desain Perangkat Lunak**

---

**Standar Referensi:** IEEE 1016-2009

**Tanggal Pembuatan:** 29 Oktober 2025
**Penulis:** Sistem Arsitek
**Versi:** 1.0

---

## 1. Pendahuluan (Introduction)

### 1.1 Tujuan (Purpose)
Dokumen ini merupakan deskripsi desain perangkat lunak (Software Design Description/SDD) untuk aplikasi guru.acehapp.com. Tujuan dari dokumen ini adalah memberikan gambaran rinci tentang arsitektur dan desain sistem, termasuk struktur, komponen, antarmuka, dan fungsi-fungsi yang dirancang untuk memenuhi kebutuhan fungsional dan non-fungsional yang telah ditentukan dalam SRS.

### 1.2 Lingkup (Scope)
Dokumen ini mencakup desain arsitektur sistem, komponen perangkat lunak, desain data, desain antarmuka, dan pertimbangan implementasi untuk aplikasi guru.acehapp.com. Ini berfungsi sebagai panduan teknis untuk pengembang dalam mengimplementasikan sistem sesuai dengan spesifikasi kebutuhan.

### 1.3 Referensi ke SRS (Reference to SRS)
- Nama Dokumen: Guru Aceh Application - Software Requirements Specification
- Nomor Revisi: 1.0
- Tanggal: 29 Oktober 2025
- Penulis: Sistem Analis

### 1.4 Referensi Lain (Other References)
1. IEEE 1016-2009 - IEEE Recommended Practice for Software Design Descriptions
2. TOGAF 9.2 Standard for Enterprise Architecture
3. ISO/IEC/IEEE 42010 - Systems and software engineering — Architecture description

### 1.5 Ikhtisar (Overview)
Dokumen ini terstruktur dalam beberapa bagian utama: deskripsi arsitektur keseluruhan, desain komponen, desain data, desain antarmuka, desain proses, dan pertimbangan implementasi.

## 2. Gambaran Arsitektural (Architectural Overview)

### 2.1 Deskripsi Umum (General Description)
Aplikasi guru.acehapp.com mengadopsi pendekatan arsitektur berbasis layanan (Service-Oriented Architecture) dengan pola arsitektur tiga lapis (3-tier architecture) yang mencakup:
- Lapisan Presentasi (Presentation Layer)
- Lapisan Logika Bisnis (Business Logic Layer)
- Lapisan Data (Data Layer)

### 2.2 Diagram Arsitektur (Architecture Diagrams)

```mermaid
graph TB
    subgraph "Client Layer"
        A[Web Browser]
        B[Mobile App]
    end
    
    subgraph "Presentation Layer"
        C[Frontend Application]
        D[API Gateway]
    end
    
    subgraph "Business Logic Layer"
        E[Authentication Service]
        F[User Management Service]
        G[Class Management Service]
        H[Material Management Service]
        I[Communication Service]
        J[Assessment Service]
        K[Reporting Service]
    end
    
    subgraph "Data Layer"
        L[User Database]
        M[Learning Database]
        N[File Storage]
    end
    
    A --> C
    B --> C
    C --> D
    D --> E
    D --> F
    D --> G
    D --> H
    D --> I
    D --> J
    D --> K
    E --> L
    F --> L
    G --> L
    H --> M
    I --> M
    J --> M
    K --> M
    G --> N
    H --> N
    I --> N
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
        +forgotPassword(email): boolean
        +resetPassword(token, newPassword): boolean
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

### 3.2 Modul Manajemen Pengguna (User Management Module)

```mermaid
classDiagram
    class UserManager {
        +createUser(userDetails): User
        +getUser(userId): User
        +updateUser(userId, userDetails): User
        +deleteUser(userId): boolean
        +searchUsers(criteria): List~User~
        +validateUser(userData): ValidationResult
    }
    
    class UserProfile {
        +userId: string
        +name: string
        +email: string
        +nip: string
        +school: string
        +role: string
        +lastLogin: DateTime
    }
    
    UserManager --> UserProfile
```

**Deskripsi:**
- Modul ini mengelola data profil pengguna
- Menyediakan fungsi CRUD (Create, Read, Update, Delete) untuk pengguna
- Melakukan validasi data pengguna sebelum disimpan

### 3.3 Modul Manajemen Kelas (Class Management Module)

```mermaid
classDiagram
    class ClassManager {
        +createClass(classData): Class
        +getClass(classId): Class
        +updateClass(classId, classData): Class
        +deleteClass(classId): boolean
        +addClassStudent(classId, studentId): boolean
        +removeClassStudent(classId, studentId): boolean
    }
    
    class Class {
        +classId: string
        +className: string
        +subject: string
        +gradeLevel: string
        +teacherId: string
        +students: List~Student~
        +createdDate: DateTime
    }
    
    class Student {
        +studentId: string
        +name: string
        +nis: string
        +classId: string
        +parentsContact: string
    }
    
    ClassManager --> Class
    Class --> Student
```

**Deskripsi:**
- Modul ini mengelola kelas dan relasi antara guru dan siswa
- Menyediakan fungsi untuk membuat, mengupdate, dan menghapus kelas
- Mengatur keanggotaan siswa dalam kelas

### 3.4 Modul Manajemen Materi (Material Management Module)

```mermaid
classDiagram
    class MaterialManager {
        +uploadMaterial(materialData): Material
        +getMaterial(materialId): Material
        +updateMaterial(materialId, materialData): Material
        +deleteMaterial(materialId): boolean
        +getMaterialsByClass(classId): List~Material~
    }
    
    class Material {
        +materialId: string
        +title: string
        +description: string
        +fileUrl: string
        +classId: string
        +teacherId: string
        +uploadDate: DateTime
        +fileType: string
        +size: number
    }
    
    MaterialManager --> Material
```

**Deskripsi:**
- Modul ini mengelola materi pembelajaran yang diupload oleh guru
- Menyimpan informasi tentang file dan metadatanya
- Mengelola hubungan antara materi dan kelas

### 3.5 Modul Komunikasi (Communication Module)

```mermaid
classDiagram
    class CommunicationManager {
        +sendAnnouncement(announcementData): Announcement
        +startDiscussion(discussionData): Discussion
        +postToDiscussion(discussionId, postData): Post
        +getDiscussionPosts(discussionId): List~Post~
    }
    
    class Announcement {
        +announcementId: string
        +title: string
        +content: string
        +senderId: string
        +classId: string
        +sendDate: DateTime
        +priority: string
    }
    
    class Discussion {
        +discussionId: string
        +title: string
        +description: string
        +creatorId: string
        +startDate: DateTime
        +posts: List~Post~
    }
    
    class Post {
        +postId: string
        +content: string
        +authorId: string
        +date: DateTime
        +discussionId: string
    }
    
    CommunicationManager --> Announcement
    CommunicationManager --> Discussion
    CommunicationManager --> Post
    Discussion --> Post
```

**Deskripsi:**
- Modul ini mengelola komunikasi antara guru dan siswa
- Menyediakan fitur pengumuman dan forum diskusi
- Menyimpan riwayat komunikasi

## 4. Desain Data (Data Design)

### 4.1 Model Data Konseptual (Conceptual Data Model)

```mermaid
classDiagram
    class USER {
        +string user_id PK
        +string name
        +string email
        +string password_hash
        +string nip
        +string school
        +string role
        +datetime created_date
        +datetime last_login
    }

    class CLASS {
        +string class_id PK
        +string class_name
        +string subject
        +string grade_level
        +string teacher_id FK
        +datetime created_date
    }

    class STUDENT {
        +string student_id PK
        +string name
        +string nis
        +string class_id FK
        +string parents_contact
    }

    class MATERIAL {
        +string material_id PK
        +string title
        +string description
        +string file_url
        +string class_id FK
        +string teacher_id FK
        +datetime upload_date
        +string file_type
        +number size
    }

    class ANNOUNCEMENT {
        +string announcement_id PK
        +string title
        +string content
        +string sender_id FK
        +string class_id FK
        +datetime send_date
        +string priority
    }

    class ASSESSMENT {
        +string assessment_id PK
        +string title
        +string class_id FK
        +string teacher_id FK
        +datetime due_date
        +number max_score
    }

    class GRADE {
        +string grade_id PK
        +string student_id FK
        +string assessment_id FK
        +number score
        +datetime recorded_date
    }

    %% Relationships
    USER "1" --> "many" CLASS : teaches
    CLASS "1" --> "many" STUDENT : contains
    CLASS "1" --> "many" MATERIAL : has
    CLASS "1" --> "many" ANNOUNCEMENT : receives
    CLASS "1" --> "many" ASSESSMENT : includes
    STUDENT "1" --> "many" GRADE : receives
    ASSESSMENT "1" --> "many" GRADE : evaluates

```

### 4.2 Model Data Logis (Logical Data Model)
(Deskripsi detail tentang struktur tabel, tipe data, dan hubungan antar tabel)

**Tabel User:**
- user_id: string (Primary Key)
- name: string (Not Null)
- email: string (Unique, Not Null)
- password_hash: string (Not Null)
- nip: string
- school: string
- role: enum(guru, admin)
- created_date: datetime
- last_login: datetime

**Tabel Class:**
- class_id: string (Primary Key)
- class_name: string (Not Null)
- subject: string (Not Null)
- grade_level: string (Not Null)
- teacher_id: string (Foreign Key to User)
- created_date: datetime

**Tabel Student:**
- student_id: string (Primary Key)
- name: string (Not Null)
- nis: string
- class_id: string (Foreign Key to Class)
- parents_contact: string

### 4.3 Model Data Fisik (Physical Data Model)
- Database: PostgreSQL
- Engine: InnoDB (jika menggunakan MySQL)
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
Request: { "name": "string", "email": "string", "password": "string", ... }
Response: { "message": "string", "user": {...} }

POST /api/auth/forgot-password
Request: { "email": "string" }
Response: { "message": "string" }

POST /api/auth/reset-password
Request: { "token": "string", "newPassword": "string" }
Response: { "message": "string" }
```

#### 5.1.2 Endpoints Manajemen Kelas
```
GET /api/classes
Authorization: Bearer <token>
Response: [{ "class_id": "string", "class_name": "string", ... }]

POST /api/classes
Authorization: Bearer <token>
Request: { "class_name": "string", "subject": "string", "grade_level": "string" }
Response: { "class_id": "string", "message": "string" }

GET /api/classes/{class_id}
Authorization: Bearer <token>
Response: { "class_id": "string", "class_name": "string", ... }

PUT /api/classes/{class_id}
Authorization: Bearer <token>
Request: { "class_name": "string", "subject": "string", "grade_level": "string" }
Response: { "message": "string" }

DELETE /api/classes/{class_id}
Authorization: Bearer <token>
Response: { "message": "string" }
```

#### 5.1.3 Endpoints Manajemen Materi
```
GET /api/classes/{class_id}/materials
Authorization: Bearer <token>
Response: [{ "material_id": "string", "title": "string", ... }]

POST /api/classes/{class_id}/materials
Authorization: Bearer <token>
Content-Type: multipart/form-data
Request: { "title": "string", "description": "string", "file": "file" }
Response: { "material_id": "string", "message": "string" }

GET /api/materials/{material_id}/download
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

#### 5.2.2 Komponen Kelas
```
Class List Component:
- Card untuk setiap kelas
- Tombol untuk membuat kelas baru
- Filter dan pencarian kelas

Class Detail Component:
- Informasi kelas
- Daftar siswa
- Tab untuk materi, pengumuman, dan penilaian
```

## 6. Desain Proses (Process Design)

### 6.1 Diagram Alur Proses (Process Flow Diagram)

```mermaid
flowchart TD
    A[User Access Application] --> B{User Authenticated?}
    B -->|No| C[Redirect to Login Page]
    C --> D[User Login Process]
    D --> E[Validate Credentials]
    E --> F{Valid?}
    F -->|Yes| G[Create Session & Token]
    F -->|No| H[Display Error Message]
    H --> C
    G --> I[Access Dashboard]
    I --> J[Select Function]
    J --> K[Process Request]
    K --> L[Return Response]
    L --> M[Display Result]
```

### 6.2 Diagram Urutan (Sequence Diagram)

```mermaid
sequenceDiagram
    participant U as User
    participant B as Browser
    participant A as API Gateway
    participant S as Authentication Service
    participant DB as Database
    
    U->>B: Akses halaman login
    B->>A: Request login form
    A->>B: Return login form
    U->>B: Masukkan kredensial
    B->>A: POST /login
    A->>S: Validate credentials
    S->>DB: Verify user credentials
    DB-->>S: Return user data
    S-->>A: Return JWT token
    A-->>B: Return session token
    B-->>U: Redirect to dashboard
```

### 6.3 Diagram Aktivitas (Activity Diagram)

```mermaid
flowchart
    Start([Start: Upload Material]) --> A[User selects file to upload]
    A --> B[Validate file type and size]
    B --> C{Valid file?}
    C -->|Yes| D[Upload file to storage service]
    C -->|No| E[Display error message]
    E --> F([End: Upload Failed])
    D --> G[Save metadata to database]
    G --> H{Upload successful?}
    H -->|Yes| I[Return success response]
    H -->|No| J[Log error and cleanup]
    I --> K([End: Upload Successful])
    J --> F
    H -->|Yes| K
```

## 7. Desain Non-Fungsional (Non-Functional Design)

### 7.1 Desain Keamanan (Security Design)
- Otentikasi berbasis JWT token
- Otorisasi berbasis peran (Role-Based Access Control)
- Enkripsi data sensitif di database
- Validasi input untuk mencegah serangan SQL Injection dan XSS
- Rate limiting untuk mencegah abuse API

### 7.2 Desain Skalabilitas (Scalability Design)
- Arsitektur mikroservis untuk kemudahan scaling
- Penggunaan cache (Redis) untuk data yang sering diakses
- Load balancing untuk distribusi beban
- Database clustering dan replikasi

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
- Backend: Node.js/Express atau Python/Django
- Frontend: React.js atau Vue.js
- Database: PostgreSQL
- File Storage: AWS S3 atau layanan cloud lainnya
- Cache: Redis
- Message Queue: RabbitMQ atau Apache Kafka

### 8.2 Pustaka dan Framework (Libraries and Frameworks)
- Otentikasi: Passport.js atau Auth0
- Validasi: Joi atau Yup
- ORM: Sequelize atau TypeORM
- Dokumentasi API: Swagger atau OpenAPI

### 8.3 Alat Pengembangan (Development Tools)
- Version Control: Git
- CI/CD: GitHub Actions atau GitLab CI
- Container: Docker
- Deployment: Kubernetes atau Docker Compose

## 9. Pertimbangan Uji Coba (Testing Considerations)

### 9.1 Strategi Pengujian (Testing Strategy)
- Unit Testing: Pengujian komponen individual
- Integration Testing: Pengujian integrasi antar komponen
- End-to-End Testing: Pengujian alur pengguna secara menyeluruh
- Security Testing: Pengujian keamanan sistem
- Performance Testing: Pengujian kinerja dan beban

### 9.2 Alat Uji Coba (Testing Tools)
- Jest atau Mocha: Unit dan integration testing
- Cypress atau Selenium: End-to-end testing
- OWASP ZAP: Security testing
- JMeter atau Artillery: Performance testing

---

**Lampiran:**
- Diagram UML Detail
- Spesifikasi API Lengkap
- Panduan Deployment
- Dokumentasi Konfigurasi
