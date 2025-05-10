# 📚 Bookshelf API Test Script

Shell script ini digunakan untuk melakukan **pengujian otomatis terhadap semua endpoint dari Bookshelf API menggunakan `curl`**. Seluruh hasil pengujian akan dicatat dalam file log, sehingga memudahkan analisis respon dan deteksi error.

---

## 🧪 Fitur Pengujian

Script akan menguji endpoint berikut:

- ✅ **Tambah Buku** – Berhasil & Gagal (tanpa `name`, `readPage > pageCount`)
- 📥 **Ambil Semua Buku**
- 🔍 **Ambil Buku berdasarkan ID** – (gagal / ID tidak ditemukan)
- ✏️ **Ubah Buku berdasarkan ID** – (gagal / ID tidak ditemukan)
- 🗑️ **Hapus Buku berdasarkan ID** – (gagal / ID tidak ditemukan)
- 🔎 **Query Buku** berdasarkan:
  - Nama (`?name=`)
  - Status dibaca (`?reading=`)
  - Selesai dibaca (`?finished=`)

---

## 📦 Persiapan

Pastikan server Bookshelf API sudah berjalan di:

```
http://localhost:9000
```

Jika belum, jalankan dengan perintah:

```bash
npm run start
```

---

## 🚀 Menjalankan Pengujian

1. **Clone** repositori atau salin file script ke direktori proyek kamu.
2. Beri izin eksekusi pada script:

```bash
chmod +x test_bookshelf_api_with_logging.sh
```

3. Jalankan script pengujian:

```bash
./test_bookshelf_api_with_logging.sh
```

---

## 📝 Output Pengujian

Semua hasil pengujian akan dicatat otomatis ke file log:

```bash
bookshelf_api_test_results.log
```

Log ini mencakup:

- ✅ Nama pengujian
- 📡 Respon lengkap dari server (format JSON)
- 🕓 Log terurut sesuai waktu eksekusi
- 🧾 Detail yang mudah dibaca untuk setiap endpoint

---

## 🔄 Parsing ID Otomatis

Script ini secara otomatis akan:

- 🔧 **Menyimpan ID buku** dari respon endpoint POST `/books`
- 🧩 **Menggunakan ID tersebut** untuk pengujian GET/PUT/DELETE
- 📌 Menghindari hardcoded ID yang tidak valid

---

## 📂 Struktur File

```bash
.
├── test_bookshelf_api_with_logging.sh   # Script pengujian otomatis
└── bookshelf_api_test_results.log       # Hasil pengujian (terbuat otomatis)
```

---

## ✅ Contoh Output Log

```txt
==> Add Book - success
{"status":"success","message":"Buku berhasil ditambahkan","data":{"bookId":"xyz123"}}

==> Add Book - failed (no name)
{"status":"fail","message":"Gagal menambahkan buku. Mohon isi nama buku"}

==> Get All Books
{"status":"success","data":{"books":[...]}}

==> Get Book by ID (not found)
{"status":"fail","message":"Buku tidak ditemukan"}

==> Delete Book by ID (not found)
{"status":"fail","message":"Buku gagal dihapus. Id tidak ditemukan"}
```

---

## 🛠️ Catatan Tambahan

- Script **tidak membutuhkan input manual** dan dapat digunakan berkali-kali untuk regression test.
- Kamu bisa memodifikasi file script untuk menambahkan pengujian lebih lanjut (autentikasi, pagination, dll).

---

## 👨‍💻 Kontributor

**Afrinaldi**  
📍 [GitHub](https://github.com/afrinaldipdg) • [LinkedIn](https://www.linkedin.com/in/afrinaldi1983/)

---

Happy testing! 🚀