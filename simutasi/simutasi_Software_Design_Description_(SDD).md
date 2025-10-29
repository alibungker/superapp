# Aplikasi SIMUTASI - Software Design Description (SDD)
**Dokumen Deskripsi Desain Perangkat Lunak**

---

**Standar Referensi:** IEEE 1016-2009

**Tanggal Pembuatan:** 29 Oktober 2025
**Penulis:** Sistem Arsitek
**Versi:** 1.0

---

## 1. Pendahuluan (Introduction)

### 1.1 Tujuan (Purpose)
Dokumen ini merupakan deskripsi desain perangkat lunak (Software Design Description/SDD) untuk aplikasi SIMUTASI (Sistem Mutasi Pendidikan) yang berada di simutasi.acehapp.com. Tujuan dari dokumen ini adalah memberikan gambaran rinci tentang arsitektur dan desain sistem, termasuk struktur, komponen, antarmuka, dan fungsi-fungsi yang dirancang untuk memenuhi kebutuhan fungsional dan non-fungsional yang telah ditentukan dalam SRS.

### 1.2 Lingkup (Scope)
Dokumen ini mencakup desain arsitektur sistem, komponen perangkat lunak, desain data, desain antarmuka, dan pertimbangan implementasi untuk aplikasi SIMUTASI. Ini berfungsi sebagai panduan teknis untuk pengembang dalam mengimplementasikan sistem sesuai dengan spesifikasi kebutuhan dengan koneksi database MySQL menggunakan kredensial: mysql -h'127.0.0.1' -P'3306' -u'root' -p'VDkt52xIv7RMuN5u' -A.

### 1.3 Referensi ke SRS (Reference to SRS)
- Nama Dokumen: Aplikasi SIMUTASI - Software Requirements Specification
- Nomor Revisi: 1.0
- Tanggal: 29 Oktober 2025
- Penulis: Sistem Analis

### 1.4 Referensi Lain (Other References)
1. IEEE 1016-2009 - IEEE Recommended Practice for Software Design Descriptions
2. TOGAF 9.2 Standard for Enterprise Architecture
3. ISO/IEC/IEEE 42010 - Systems and software engineering — Architecture description
4. MySQL 8.0 Documentation
5. Standar Pengembangan Aplikasi Web
6. Database Connection: mysql -h'127.0.0.1' -P'3306' -u'root' -p'VDkt52xIv7RMuN5u' -A

### 1.5 Ikhtisar (Overview)
Dokumen ini terstruktur dalam beberapa bagian utama: deskripsi arsitektur keseluruhan, desain komponen, desain data, desain antarmuka, desain proses, dan pertimbangan implementasi.

## 2. Gambaran Arsitektural (Architectural Overview)

### 2.1 Deskripsi Umum (General Description)
Aplikasi SIMUTASI mengadopsi pendekatan arsitektur berbasis layanan (Service-Oriented Architecture) dengan pola arsitektur tiga lapis (3-tier architecture) yang mencakup:
- Lapisan Presentasi (Presentation Layer)
- Lapisan Logika Bisnis (Business Logic Layer)
- Lapisan Data (Data Layer)

Sistem ini menggunakan database MySQL dengan koneksi: mysql -h'127.0.0.1' -P'3306' -u'root' -p'VDkt52xIv7RMuN5u' -A.

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
        F[User Management Service]
        G[Mutation Request Service]
        H[Document Management Service]
        I[Verification Service]
        J[Approval Service]
        K[Notification Service]
        L[Reporting Service]
    end
    
    subgraph "Data Layer"
        M[User Database]
        N[Mutation Database]
        O[Document Storage]
        P[MySQL Server<br/>Host: 127.0.0.1:3306<br/>User: root<br/>Pass: VDkt52xIv7RMuN5u]
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
    D --> L
    E --> P
    F --> P
    G --> P
    H --> P
    I --> P
    J --> P
    K --> P
    L --> P
    M --> P
    N --> P
    O --> H
```

### 2.3 Prinsip-Prinsip Desain (Design Principles)
- Separation of Concerns: Memisahkan tanggung jawab antar komponen
- Scalability: Desain yang dapat berkembang sesuai kebutuhan
- Maintainability: Kode yang mudah dipelihara dan dimodifikasi
- Security by Design: Keamanan diterapkan sejak tahap desain
- Performance: Optimalisasi kinerja dari awal desain
- Database Integration: Penggunaan database MySQL sesuai kredensial yang ditentukan

## 3. Desain Komponen (Component Design)

### 3.1 Modul Otentikasi (Authentication Module)

```mermaid
classDiagram
    class AuthenticationService {
        +authenticateUser(credentials): boolean
        +registerUser(userDetails): boolean
        +logoutUser(token): boolean
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
- Terkoneksi ke database MySQL menggunakan: mysql -h'127.0.0.1' -P'3306' -u'root' -p'VDkt52xIv7RMuN5u' -A

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
    
    class User {
        +userId: string
        +name: string
        +email: string
        +nip: string
        +schoolId: string
        +role: string
        +status: string
        +lastLogin: DateTime
    }
    
    UserManager --> User
```

**Deskripsi:**
- Modul ini mengelola data profil pengguna
- Menyediakan fungsi CRUD (Create, Read, Update, Delete) untuk pengguna
- Melakukan validasi data pengguna sebelum disimpan

### 3.3 Modul Pengajuan Mutasi (Mutation Request Module)

```mermaid
classDiagram
    class MutationRequestService {
        +createMutationRequest(requestData): MutationRequest
        +getMutationRequest(requestId): MutationRequest
        +updateMutationRequest(requestId, requestData): MutationRequest
        +deleteMutationRequest(requestId): boolean
        +getRequestsByUser(userId): List~MutationRequest~
        +getRequestsByStatus(status): List~MutationRequest~
        +validateRequestData(requestData): ValidationResult
    }
    
    class MutationRequest {
        +requestId: string
        +userId: string
        +sourceSchoolId: string
        +targetSchoolId: string
        +reason: string
        +status: string
        +submissionDate: DateTime
        +processedDate: DateTime
        +approverId: string
        +documents: List~Document~
    }
    
    MutationRequestService --> MutationRequest
```

**Deskripsi:**
- Modul ini mengelola permintaan mutasi dari pengguna
- Melacak status dan proses permintaan mutasi
- Mengelola hubungan antara permintaan dan dokumen pendukung

### 3.4 Modul Manajemen Dokumen (Document Management Module)

```mermaid
classDiagram
    class DocumentManagementService {
        +uploadDocument(file, metadata): Document
        +getDocument(documentId): Document
        +deleteDocument(documentId): boolean
        +validateDocument(file): ValidationResult
        +moveToStorage(file, path): boolean
        +getDocumentsByRequest(requestId): List~Document~
    }
    
    class Document {
        +documentId: string
        +requestId: string
        +fileName: string
        +fileType: string
        +fileSize: number
        +storagePath: string
        +uploadDate: DateTime
        +status: string
        +verifierId: string
    }
    
    DocumentManagementService --> Document
```

**Deskripsi:**
- Modul ini mengelola dokumen pendukung permintaan mutasi
- Menyediakan fungsi upload, download, dan validasi dokumen
- Mengelola penyimpanan dokumen secara aman

### 3.5 Modul Verifikasi (Verification Module)

```mermaid
classDiagram
    class VerificationService {
        +verifyDocument(documentId, verificationResult): Verification
        +verifyUser(userId): Verification
        +createVerificationRecord(verificationData): Verification
        +getVerificationByRequest(requestId): List~Verification~
        +updateVerificationStatus(verificationId, status): Verification
    }
    
    class Verification {
        +verificationId: string
        +documentId: string
        +verifierId: string
        +verificationDate: DateTime
        +status: string
        +notes: string
        +isCompleted: boolean
    }
    
    VerificationService --> Verification
```

**Deskripsi:**
- Modul ini bertanggung jawab atas proses verifikasi dokumen dan data pengguna
- Menyimpan riwayat verifikasi untuk audit trail
- Mengelola status verifikasi dan catatan verifikasi

### 3.6 Modul Persetujuan (Approval Module)

```mermaid
classDiagram
    class ApprovalService {
        +createApprovalWorkflow(requestId): Approval
        +processApproval(approvalId, decision): Approval
        +getApprovalsByStatus(status): List~Approval~
        +notifyParties(approvalId, status): boolean
        +logApprovalDecision(approvalData): boolean
    }
    
    class Approval {
        +approvalId: string
        +requestId: string
        +approverId: string
        +decision: string
        +decisionDate: DateTime
        +notes: string
        +status: string
    }
    
    ApprovalService --> Approval
```

**Deskripsi:**
- Modul ini mengelola proses persetujuan mutasi
- Menerapkan alur persetujuan berdasarkan kebijakan
- Mengirimkan notifikasi terkait keputusan persetujuan

## 4. Desain Data (Data Design)

### 4.1 Model Data Konseptual (Conceptual Data Model)

```mermaid
erDiagram
    USER {
        string user_id PK
        string name
        string email
        string password_hash
        string nip
        string school_id FK
        string role
        string status
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
        boolean is_active
    }
    
    MUTATION_REQUEST {
        string request_id PK
        string user_id FK
        string source_school_id FK
        string target_school_id FK
        string reason
        string status
        datetime submission_date
        datetime processed_date
        string approver_id FK
        boolean is_approved
    }
    
    DOCUMENT {
        string doc_id PK
        string request_id FK
        string file_path
        string file_name
        string file_type
        number file_size
        datetime upload_date
        string status
        string verifier_id FK
    }
    
    VERIFICATION {
        string verification_id PK
        string doc_id FK
        string verifier_id FK
        datetime verification_date
        string status
        string notes
        boolean is_completed
    }
    
    APPROVAL {
        string approval_id PK
        string request_id FK
        string approver_id FK
        string decision
        datetime decision_date
        string notes
        string status
    }
    
    NOTIFICATION {
        string notification_id PK
        string title
        string content
        string target_user_id FK
        datetime send_date
        boolean is_read
        string priority
    }
    
    USER ||--o{ MUTATION_REQUEST : submits
    USER ||--o{ DOCUMENT : uploads
    USER ||--o{ VERIFICATION : performs
    USER ||--o{ APPROVAL : gives
    USER ||--o{ NOTIFICATION : receives
    SCHOOL ||--o{ USER : belongs_to
    SCHOOL ||--o{ MUTATION_REQUEST : source
    SCHOOL ||--o{ MUTATION_REQUEST : target
    MUTATION_REQUEST ||--o{ DOCUMENT : supports
    DOCUMENT ||--o{ VERIFICATION : undergoes
    MUTATION_REQUEST ||--o{ APPROVAL : requires
```

### 4.2 Model Data Logis (Logical Data Model)

**Tabel User:**
- user_id: VARCHAR(36) (Primary Key, UUID)
- name: VARCHAR(100) (Not Null)
- email: VARCHAR(100) (Unique, Not Null)
- password_hash: VARCHAR(255) (Not Null)
- nip: VARCHAR(20) (Nullable)
- school_id: VARCHAR(36) (Foreign Key to School)
- role: ENUM('guru', 'siswa', 'admin', 'verifier', 'approver') (Not Null)
- status: ENUM('aktif', 'nonaktif', 'terverifikasi') (Default: 'aktif')
- created_date: TIMESTAMP (Not Null, Default: CURRENT_TIMESTAMP)
- last_login: TIMESTAMP (Nullable)
- is_active: BOOLEAN (Not Null, Default: TRUE)

**Tabel School:**
- school_id: VARCHAR(36) (Primary Key, UUID)
- school_name: VARCHAR(200) (Not Null)
- address: TEXT (Not Null)
- school_level: ENUM('sd', 'smp', 'sma', 'smk', 'slb') (Not Null)
- principal: VARCHAR(100) (Nullable)
- phone_number: VARCHAR(20) (Nullable)
- email: VARCHAR(100) (Nullable)
- is_active: BOOLEAN (Not Null, Default: TRUE)

**Tabel MutationRequest:**
- request_id: VARCHAR(36) (Primary Key, UUID)
- user_id: VARCHAR(36) (Foreign Key to User, Not Null)
- source_school_id: VARCHAR(36) (Foreign Key to School, Not Null)
- target_school_id: VARCHAR(36) (Foreign Key to School, Not Null)
- reason: TEXT (Not Null)
- status: ENUM('pengajuan', 'verifikasi', 'persetujuan', 'disetujui', 'ditolak', 'dibatalkan') (Default: 'pengajuan')
- submission_date: TIMESTAMP (Not Null, Default: CURRENT_TIMESTAMP)
- processed_date: TIMESTAMP (Nullable)
- approver_id: VARCHAR(36) (Foreign Key to User, Nullable)
- is_approved: BOOLEAN (Default: NULL)

**Tabel Document:**
- doc_id: VARCHAR(36) (Primary Key, UUID)
- request_id: VARCHAR(36) (Foreign Key to MutationRequest, Not Null)
- file_path: VARCHAR(500) (Not Null)
- file_name: VARCHAR(200) (Not Null)
- file_type: VARCHAR(20) (Not Null)
- file_size: INTEGER (Not Null)
- upload_date: TIMESTAMP (Not Null, Default: CURRENT_TIMESTAMP)
- status: ENUM('upload', 'verifikasi', 'terverifikasi', 'revisi') (Default: 'upload')
- verifier_id: VARCHAR(36) (Foreign Key to User, Nullable)

**Tabel Verification:**
- verification_id: VARCHAR(36) (Primary Key, UUID)
- doc_id: VARCHAR(36) (Foreign Key to Document, Not Null)
- verifier_id: VARCHAR(36) (Foreign Key to User, Not Null)
- verification_date: TIMESTAMP (Not Null, Default: CURRENT_TIMESTAMP)
- status: ENUM('pending', 'verified', 'rejected') (Not Null)
- notes: TEXT (Nullable)
- is_completed: BOOLEAN (Not Null, Default: FALSE)

**Tabel Approval:**
- approval_id: VARCHAR(36) (Primary Key, UUID)
- request_id: VARCHAR(36) (Foreign Key to MutationRequest, Not Null)
- approver_id: VARCHAR(36) (Foreign Key to User, Not Null)
- decision: ENUM('setuju', 'tolak', 'tunda') (Not Null)
- decision_date: TIMESTAMP (Not Null, Default: CURRENT_TIMESTAMP)
- notes: TEXT (Nullable)
- status: ENUM('pending', 'completed') (Not Null, Default: 'pending')

### 4.3 Model Data Fisik (Physical Data Model)
- Database: MySQL
- Connection: mysql -h'127.0.0.1' -P'3306' -u'root' -p'VDkt52xIv7RMuN5u' -A
- Engine: InnoDB
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
Request: { "name": "string", "email": "string", "password": "string", "nip": "string", "role": "string" }
Response: { "message": "string", "user": {...} }

POST /api/auth/logout
Authorization: Bearer <token>
Response: { "message": "string" }

POST /api/auth/forgot-password
Request: { "email": "string" }
Response: { "message": "string" }
```

#### 5.1.2 Endpoints Pengajuan Mutasi
```
GET /api/mutation-requests
Authorization: Bearer <token>
Response: [{ "request_id": "string", "status": "string", ... }]

POST /api/mutation-requests
Authorization: Bearer <token>
Request: { "source_school_id": "string", "target_school_id": "string", "reason": "string" }
Response: { "request_id": "string", "message": "string" }

GET /api/mutation-requests/{request_id}
Authorization: Bearer <token>
Response: { "request_id": "string", "status": "string", ... }

PUT /api/mutation-requests/{request_id}
Authorization: Bearer <token>
Request: { "reason": "string" }
Response: { "message": "string" }

DELETE /api/mutation-requests/{request_id}
Authorization: Bearer <token>
Response: { "message": "string" }
```

#### 5.1.3 Endpoints Dokumen
```
POST /api/mutation-requests/{request_id}/documents
Authorization: Bearer <token>
Content-Type: multipart/form-data
Request: { "file": "file" }
Response: { "doc_id": "string", "message": "string" }

GET /api/documents/{doc_id}/download
Authorization: Bearer <token>
Response: File download
```

#### 5.1.4 Endpoints Persetujuan
```
PUT /api/approvals/{approval_id}
Authorization: Bearer <token> (hanya untuk approver)
Request: { "decision": "setuju|tolak|tunda", "notes": "string" }
Response: { "message": "string" }
```

### 5.2 Antarmuka Pengguna (UI Component Design)

#### 5.2.1 Komponen Dashboard
```
Dashboard Layout:
- Sidebar: Menu navigasi
- Header: Informasi pengguna dan notifikasi
- Main Content: Ringkasan permintaan mutasi
- Footer: Informasi sistem
```

#### 5.2.2 Komponen Formulir Mutasi
```
Mutation Request Form:
- Dropdown sekolah asal
- Dropdown sekolah tujuan
- Textarea alasan mutasi
- Tombol submit permintaan
- Preview dokumen yang telah diupload
```

#### 5.2.3 Komponen Upload Dokumen
```
Document Upload Component:
- Drag and drop area
- List dokumen yang diupload
- Status verifikasi dokumen
- Tombol untuk melihat/detail dokumen
```

## 6. Desain Proses (Process Design)

### 6.1 Diagram Alur Proses (Process Flow Diagram)

```mermaid
flowchart TD
    A[User Access SIMUTASI Application] --> B{User Authenticated?}
    B -->|No| C[Redirect to Login Page]
    C --> D[User Login Process]
    D --> E[Validate Credentials with MySQL<br/>mysql -h'127.0.0.1' -P'3306' -u'root' -p'VDkt52xIv7RMuN5u' -A]
    E --> F{Valid?}
    F -->|Yes| G[Create Session & Token]
    F -->|No| H[Display Error Message]
    H --> C
    G --> I[Access Dashboard]
    I --> J[Submit Mutation Request]
    J --> K[Upload Supporting Documents]
    K --> L[Request goes to Verification Queue]
    L --> M[Verifier checks documents]
    M --> N{Documents Valid?}
    N -->|Yes| O[Request goes to Approval Queue]
    N -->|No| P[Request sent for revision]
    O --> Q[Approver reviews request]
    Q --> R{Approve Request?}
    R -->|Yes| S[Request approved]
    R -->|No| T[Request rejected]
    S --> U[Send approval notification]
    T --> V[Send rejection notification]
    P --> W[Notify for revision]
    S --> X[Update database status]
    T --> X
    V --> X
    W --> X
```

### 6.2 Diagram Urutan (Sequence Diagram)

```mermaid
sequenceDiagram
    participant U as User
    participant B as Browser
    participant A as API Gateway
    participant S as Authentication Service
    participant M as Mutation Service
    participant D as Document Service
    participant V as Verification Service
    participant App as Approval Service
    participant DB as MySQL Database<br/>Host: 127.0.0.1:3306<br/>User: root<br/>Pass: VDkt52xIv7RMuN5u
    
    U->>B: Akses halaman login
    B->>A: Request login form
    A->>B: Return login form
    U->>B: Masukkan kredensial
    B->>A: POST /login
    A->>S: Validate credentials
    S->>DB: Verify user credentials in MySQL
    DB-->>S: Return user data
    S-->>A: Return JWT token
    A-->>B: Return session token
    B-->>U: Redirect to dashboard
    U->>B: Akses formulir mutasi
    B->>A: Request mutation form
    A-->>B: Return mutation form
    U->>B: Isi formulir dan submit
    B->>A: POST mutation request
    A->>M: Create mutation request
    M->>DB: Store mutation request
    DB-->>M: Confirmation stored
    M-->>A: Return request ID
    A-->>B: Return request confirmation
    B-->>U: Tampilkan konfirmasi
    U->>B: Upload dokumen pendukung
    B->>A: Upload document
    A->>D: Process document upload
    D->>DB: Store document reference
    DB-->>D: Confirmation stored
    D-->>A: Return document confirmation
    A-->>B: Return document confirmation
    B-->>U: Tampilkan status upload
    Note over DB: Data stored in MySQL using<br/>mysql -h'127.0.0.1' -P'3306' -u'root' -p'VDkt52xIv7RMuN5u' -A
```

### 6.3 Diagram Aktivitas (Activity Diagram)

```mermaid
flowchart
    Start([Start: Submit Mutation Request]) --> A[User accesses mutation form]
    A --> B[Select source and target schools]
    B --> C[Fill reason for mutation]
    C --> D[Submit request to system]
    D --> E[Validate request data]
    E --> F{Data Valid?}
    F -->|No| G[Return to form with errors]
    G --> B
    F -->|Yes| H[Store request in database]
    H --> I[Generate request ID]
    I --> J[Set status to 'pengajuan']
    J --> K[Send notification to verifiers]
    K --> L[Wait for document upload]
    L --> M[User uploads supporting documents]
    M --> N[Validate document format]
    N --> O{Document Format Valid?}
    O -->|No| P[Request document re-upload]
    P --> M
    O -->|Yes| Q[Store document in file system]
    Q --> R[Update request with document reference]
    R --> S[Set status to 'verifikasi']
    S --> T[Verifier reviews documents]
    T --> U{Documents verified?}
    U -->|No| V[Set status to 'revisi']
    U -->|Yes| W[Set status to 'persetujuan']
    V --> X[Notify user for document revision]
    W --> Y[Approver reviews request]
    Y --> Z{Approve request?}
    Z -->|No| AA[Set status to 'ditolak']
    Z -->|Yes| AB[Set status to 'disetujui']
    AA --> AC[Send rejection notification]
    AB --> AD[Send approval notification]
    AC --> AE[Process complete]
    AD --> AE
    X --> AE
    AE --> AF([End: Mutation Request Process Complete])
```

## 7. Desain Non-Fungsional (Non-Functional Design)

### 7.1 Desain Keamanan (Security Design)
- Otentikasi berbasis JWT token
- Otorisasi berbasis peran (Role-Based Access Control)
- Enkripsi data sensitif di database MySQL
- Validasi input untuk mencegah serangan SQL Injection dan XSS
- Rate limiting untuk mencegah abuse API
- Koneksi aman ke database: mysql -h'127.0.0.1' -P'3306' -u'root' -p'VDkt52xIv7RMuN5u' -A

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
- Database: MySQL dengan koneksi: mysql -h'127.0.0.1' -P'3306' -u'root' -p'VDkt52xIv7RMuN5u' -A
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
- Host: 127.0.0.1
- Port: 3306
- Username: root
- Password: VDkt52xIv7RMuN5u
- Connection Command: mysql -h'127.0.0.1' -P'3306' -u'root' -p'VDkt52xIv7RMuN5u' -A

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
- Database Connection Details: mysql -h'127.0.0.1' -P'3306' -u'root' -p'VDkt52xIv7RMuN5u' -A