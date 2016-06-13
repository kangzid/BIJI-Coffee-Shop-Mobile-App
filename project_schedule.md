# Jadwal Proyek: BIJI Coffee Shop Mobile App (Tim Sederhana)

![Simple Gantt Chart](C:/Users/ASUS/.gemini/antigravity/brain/081f6b58-4a20-4125-8cb3-5d56b99c1a0b/simple_team_gantt_chart_1766105628218.png)

Berikut adalah jadwal pelaksanaan proyek yang disederhanakan untuk **4 Orang** dengan peran spesifik: **2 Developer, 1 Tester, dan 1 Reporter**.
Waktu pengerjaan efitif adalah **2 Minggu** (Minggu 3 & 4) untuk menyelesaikan Back End dan Integrasi.

## Peran & Tanggung Jawab
1.  **Developer 1 (Back End A)**: Fokus pada User Management (Auth) & Database Core.
2.  **Developer 2 (Back End B)**: Fokus pada Fitur Utama (Produk, Transaksi) & API Logic.
3.  **Tester (QA)**: Fokus pada Uji Coba Manual/Automated & Quality Control.
4.  **Reporter (Admin)**: Fokus pada Dokumentasi Proyek, User Manual, & Laporan Akhir.

## Gantt Chart Sederhana

```mermaid
gantt
    title Jadwal Proyek - Tim Sederhana (4 Orang)
    dateFormat  YYYY-MM-DD
    axisFormat  %W

    section Fase 1: Front End (Selesai)
    UI/UX & Slicing (Selesai) :done, fe, 2025-12-01, 14d

    section Fase 2: Development (Minggu 3)
    Dev 1: Auth & DB Setup    :active, d1a, 2025-12-15, 5d
    Dev 2: Product & API Logic:active, d2a, 2025-12-15, 5d
    Tester: Plan & Initial Test:active, qa1, after 2025-12-16, 4d
    Reporter: Draft Laporan   :active, rep1, 2025-12-15, 5d

    section Fase 3: Integrasi & Final (Minggu 4)
    Dev 1: Integration (Login): d1b, after d1a, 3d
    Dev 2: Integration (Trans): d2b, after d2a, 3d
    Tester: Full Testing E2E  : qa2, after d1b, 3d
    Reporter: Finalisasi Docs : rep2, after rep1, 5d
    Deployment & Release      : milestone, 2025-12-28, 0d
```

## Detail Pembagian Tugas Mingguan

### Minggu 3: Development (Fokus Back End)
| Peran | Tugas Utama |
| :--- | :--- |
| **Developer 1** | Setup Server/Repo, ERD User, API Login/Register/Profile. |
| **Developer 2** | ERD Produk/Transaksi, API List Produk, Detail, & Checkout Dummy. |
| **Tester** | Membuat Test Case, Cek database setup, Testing API via Postman (sebagai data masuk). |
| **Reporter** | Mengumpulkan struktur Project, mulai menyusun Bab Pendahuluan & Perancangan Laporan. |

### Minggu 4: Integrasi & Finalisasi
| Peran | Tugas Utama |
| :--- | :--- |
| **Developer 1** | Integrasi Login di Aplikasi Mobile, Bug Fixing User Auth. |
| **Developer 2** | Integrasi List Produk & Cart di Mobile, Bug Fixing Transaksi. |
| **Tester** | Menjalankan Full Cycle Test (Login -> Belanja -> Checkout), Mencatat Bug. |
| **Reporter** | Screenshot bukti testing, Finalisasi kesimpulan Laporan, Menyusun User Manual. |
