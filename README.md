#   📚 Bookshelf API - Koleksi Postman

[![Awesome Project](https://img.shields.io/badge/Awesome-Project-brightgreen.svg)](https://github.com/your-github-username/your-repo-name)
[![Version](https://img.shields.io/badge/Version-1.0.0-blue.svg)](https://github.com/your-github-username/your-repo-name/releases)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/your-github-username/your-repo-name/blob/main/LICENSE)

Sebuah koleksi Postman yang dibuat dengan cermat untuk menguji Bookshelf API. Koleksi ini menyediakan serangkaian pengujian lengkap untuk memastikan ketahanan dan keandalan API.

##   ✨ Pendahuluan yang Elegan

Mulailah perjalanan tanpa hambatan untuk memvalidasi Bookshelf API Anda dengan koleksi Postman yang dirancang dengan saksama ini. Setiap kasus pengujian dibuat dengan presisi, memastikan setiap aspek API Anda berfungsi seperti yang diharapkan. Mulai dari menambahkan buku-buku baru hingga mengambil informasi detail dan mengelola pembaruan, koleksi ini adalah rekan terpercaya Anda.

##   📖 Daftar Isi

-   [Fitur](#fitur)
-   [Mulai](#mulai)
    -   [Prasyarat](#prasyarat)
    -   [Instalasi](#instalasi)
    -   [Pengaturan Environment](#pengaturan-environment)
-   [Gambaran Umum Koleksi](#gambaran-umum-koleksi)
    -   [Menambah Buku](#menambah-buku)
    -   [Mengambil Buku](#mengambil-buku)
    -   [Memperbarui Buku](#memperbarui-buku)
    -   [Menghapus Buku](#menghapus-buku) **(Bonus)**
-   [Variabel Environment](#variabel-environment)
-   [Filosofi Pengujian](#filosofi-pengujian)
-   [Berkontribusi](#berkontribusi)
-   [Lisensi](#lisensi)
-   [Ucapan Terima Kasih](#ucapan-terima-kasih)

##   🌟 Fitur

Koleksi Postman ini menawarkan berbagai pengujian, mencakup fungsionalitas penting Bookshelf API:

-   **Menambah Buku:**
    -   Menambah buku dengan data lengkap.
    -   Menangani skenario dengan nama buku yang hilang.
    -   Memvalidasi `readPage` terhadap `pageCount`.
-   **Mengambil Buku:**
    -   Mengambil semua buku dengan detail ringkas.
    -   Mengambil informasi detail untuk buku tertentu.
    -   Menangani kasus di mana ID buku tidak valid.
-   **Memperbarui Buku:**
    -   Memperbarui detail buku dengan data lengkap.
    -   Mengelola pembaruan saat nama buku hilang.
    -   Memastikan `readPage` tidak melebihi `pageCount` selama pembaruan.
-   **Menghapus Buku:** **(Bonus - Termasuk dalam Skrip Pra-permintaan)**
    -   Menghapus buku secara efisien.

##   🚀 Mulai

###   Prasyarat

Sebelum memulai, pastikan Anda telah menginstal yang berikut:

-   **Postman:** Versi terbaru aplikasi Postman. Anda dapat mengunduhnya dari [https://www.postman.com/downloads/](https://www.postman.com/downloads/)
-   **Bookshelf API:** Instance Bookshelf API yang sedang berjalan dan ingin Anda uji.

###   Instalasi

1.  **Klon repositori:**
    ```bash
    git clone <your-repository-url>
    cd <your-repository-directory>
    ```
2.  **Impor koleksi:**
    -   Buka Postman.
    -   Klik "Impor".
    -   Pilih file `Bookshelf API Test.postman_collection.json`.

###   Pengaturan Environment

1.  **Impor environment:**
    -   Di Postman, klik "Impor".
    -   Pilih file `Bookshelf API Test.postman_environment.json`.
2.  **Konfigurasi variabel environment:**
    -   Pilih environment "Bookshelf API Test" dari dropdown.
    -   Edit variabel environment:
        -   `port`: Atur ini ke port tempat Bookshelf API Anda berjalan (misalnya, `9000`).
        -   Secara opsional, Anda dapat memodifikasi nilai default untuk properti buku seperti `newName`, `newAuthor`, dll., sesuai kebutuhan pengujian Anda.

##   📦 Gambaran Umum Koleksi

###   Menambah Buku

-   **[Wajib] Tambah Buku Dengan Data Lengkap:** Menguji keberhasilan pembuatan buku dengan semua bidang yang diperlukan.
-   **[Wajib] Tambah Buku Dengan Selesai Dibaca:** Memverifikasi pembuatan buku saat `readPage` sama dengan `pageCount`.
-   **[Wajib] Tambah Buku Tanpa Nama:** Memastikan API dengan benar menolak pembuatan buku saat bidang `name` hilang.
-   **[Wajib] Tambah Buku dengan Halaman Dibaca Lebih Banyak dari Jumlah Halaman:** Memvalidasi bahwa API mencegah pembuatan buku di mana `readPage` melebihi `pageCount`.

###   Mengambil Buku

-   **[Wajib] Ambil Semua Buku:** Mengambil daftar semua buku, memverifikasi struktur respons.
-   **[Wajib] Ambil Detail Buku Dengan ID yang Benar:** Mengambil informasi detail untuk buku tertentu menggunakan ID-nya.
-   **[Wajib] Ambil Detail Buku Selesai Dibaca:** Mengambil detail untuk buku yang ditandai selesai (readPage = pageCount).
-   **[Wajib] Ambil Detail Buku Dengan ID Tidak Valid:** Mengonfirmasi perilaku API saat ID buku yang tidak valid diberikan.

###   Memperbarui Buku

-   **[Wajib] Perbarui Buku Dengan Data Lengkap:** Menguji keberhasilan modifikasi detail buku.
-   **[Wajib] Perbarui Buku Tanpa Nama:** Memeriksa apakah API menangani pembaruan dengan benar saat `name` buku hilang.
-   **[Wajib] Perbarui Buku Dengan Halaman Dibaca Lebih Banyak dari Jumlah Halaman:** Memvalidasi respons API saat mencoba memperbarui buku dengan `readPage` lebih besar dari `pageCount`.
-   **[Wajib] Perbarui Buku dengan ID Tidak Valid:** Memverifikasi bahwa API mengembalikan error saat mencoba memperbarui buku dengan ID yang tidak ada.

###   Menghapus Buku **(Bonus)**

-   **[Bonus] Hapus Semua Buku:** Permintaan ini termasuk sebagai skrip pra-permintaan dalam permintaan "Ambil Semua Buku". Ini secara efisien membersihkan semua buku dalam database sebelum mengambil daftar, memastikan lingkungan pengujian yang konsisten. Ini menunjukkan teknik Postman tingkat lanjut untuk mengelola data pengujian.

##   ⚙️ Variabel Environment

File `Bookshelf API Test.postman_environment.json` berisi variabel-variabel kunci berikut:

| Variabel                      | Deskripsi                                                                  | Nilai Default                       |
| :---------------------------- | :------------------------------------------------------------------------- | :---------------------------------- |
| `port`                        | Port tempat Bookshelf API berjalan.                                        | `9000`                              |
| `bookId`                      | (Dihasilkan) ID buku yang baru dibuat.                                      | *Kosong* |
| `bookIdWithFinishedReading`   | (Dihasilkan) ID buku dengan status selesai dibaca.                          | *Kosong* |
| `newName`                     | Nama buku baru.                                                            | `Buku A`                            |
| `newYear`                     | Tahun publikasi buku baru.                                                  | `2010`                              |
| `newAuthor`                   | Penulis buku baru.                                                          | `John Doe`                          |
| `newSummary`                  | Ringkasan buku baru.                                                        | `Lorem ipsum dolor sit amet`          |
| `newPublisher`                | Penerbit buku baru.                                                         | `Dicoding Indonesia`                |
| `newPageCount`                | Jumlah total halaman dalam buku baru.                                       | `100`                               |
| `newReadPage`                 | Jumlah halaman yang dibaca dalam buku baru.                                 | `25`                                |
| `newReading`                  | Apakah buku sedang dibaca saat ini.                                          | `false`                             |
| `updateName`                  | Nama buku yang diperbarui.                                                  | `Buku A Revisi`                     |
| `updateYear`                  | Tahun publikasi buku yang diperbarui.                                       | `2011`                              |
| `updateAuthor`                | Penulis buku yang diperbarui.                                               | `Jane Doe`                          |
| `updateSummary`                 | Ringkasan buku yang diperbarui.                                             | `Updated Lorem Ipsum`               |
| `updatePublisher`               | Penerbit buku yang diperbarui.                                              | `Dicoding Academy`                  |
| `updatePageCount`               | Jumlah total halaman dalam buku yang diperbarui.                             | `120`                               |
| `updateReadPage`                | Jumlah halaman yang dibaca dalam buku yang diperbarui.                       | `30`                                |
| `updateReading`                 | Apakah buku sedang dibaca saat ini (setelah diperbarui).                    | `true`                              |

##   🧪 Filosofi Pengujian

Koleksi ini menganut filosofi pengujian yang menyeluruh dan tepat. Setiap kasus pengujian dirancang untuk memvalidasi aspek spesifik API, memberikan umpan balik yang jelas dan dapat ditindaklanjuti. Assertions digunakan secara ekstensif untuk memastikan respons sesuai dengan hasil yang diharapkan, mencakup kode status, header, dan konten body respons.

##   🤝 Berkontribusi

Kontribusi dipersilakan! Jika Anda memiliki saran untuk kasus pengujian baru, perbaikan pada yang sudah ada, atau peningkatan lainnya, jangan ragu untuk:

1.  Fork repositori.
2.  Buat branch baru untuk fitur atau perbaikan bug Anda.
3.  Lakukan perubahan Anda.
4.  Kirim pull request.

##   📜 Lisensi

Proyek ini dilisensikan di bawah Lisensi MIT. Lihat file `LICENSE` untuk detailnya.

##   🙏 Ucapan Terima Kasih

-   Terima kasih khusus kepada para pengembang Bookshelf API karena telah menciptakan platform yang luar biasa ini.
-   Terima kasih kepada tim Postman karena telah menyediakan alat yang sangat baik untuk pengujian API.

---

**Catatan:** 

Jangan ragu untuk menyesuaikan lebih lanjut `README.md` ini agar sesuai dengan gaya dan kebutuhan proyek Anda!

---

## 👨‍💻 Kontributor

**Afrinaldi**  
📍 [GitHub](https://github.com/afrinaldipdg) • [LinkedIn](https://www.linkedin.com/in/afrinaldi1983/)

---

Happy testing! 🚀 
