#!/bin/bash

#  Script Otomatisasi Tes API Bookshelf dengan Logging
#  Dokumentasi Lengkap Bahasa Indonesia
#
#  Script ini menjalankan serangkaian tes API untuk aplikasi Bookshelf dan mencatat
#  hasilnya ke dalam file log. Anda dapat memilih tes individual atau menjalankan
#  semua tes sekaligus.
#
#  Cara Penggunaan:
#  1.  Simpan script ini sebagai file .sh (misalnya, `test_bookshelf_api.sh`).
#  2.  Ubah permission agar bisa dieksekusi: `chmod +x test_bookshelf_api.sh`
#  3.  Jalankan script: `./test_bookshelf_api.sh`
#  4.  Ikuti petunjuk di menu untuk memilih tes yang ingin dijalankan.
#
#  Prasyarat:
#  -   Aplikasi Bookshelf API harus sudah berjalan dan dapat diakses.
#  -   Pastikan nilai-nilai variabel di dalam script sesuai dengan environment Anda.
#      (Terutama `BASE_URL`). Data buku akan dibuat otomatis oleh script.
#  -   (Opsional) Install `jq` untuk memformat output JSON: `sudo apt install jq` (Debian/Ubuntu)
#
#  Output:
#  -   Script akan menampilkan hasil setiap tes (status code, header, body) ke terminal
#      dan juga mencatatnya ke file log.
#  -   Nama file log akan berdasarkan tanggal dan waktu saat script dijalankan.
#  -   Jika terjadi kesalahan, script akan menampilkan pesan error yang informatif.

# Konfigurasi Environment (Ganti dengan nilai sesuai environment Anda)
BASE_URL="http://localhost:9000"  # Pastikan API Anda berjalan di sini

# Variabel Global untuk Menyimpan bookId
BOOK_ID=""
BOOK_ID_FINISHED=""
LOG_FILE="bookshelf_api_test_$(date +'%Y%m%d_%H%M%S').log"

# Fungsi untuk Menjalankan Perintah dengan Error Handling dan Logging
run_command() {
  local command="$1"
  local description="$2" # Deskripsi untuk log
  echo "Menjalankan: $description" | tee -a "$LOG_FILE"
  eval "$command" 2>>"$LOG_FILE" # Redirect stderr ke log file
  local status=$?
  if [ $status -ne 0 ]; then
    echo "Gagal menjalankan: $description" | tee -a "$LOG_FILE"
    echo "Perintah: $command" | tee -a "$LOG_FILE"
    echo "Status: $status" | tee -a "$LOG_FILE"
    echo "Tes dibatalkan karena kesalahan." | tee -a "$LOG_FILE"
    exit 1 # Keluar dari script jika ada error
  fi
}

# Fungsi untuk Menjalankan Tes dan Mencatat Log
run_test() {
  local test_number="$1"
  echo "========================================" | tee -a "$LOG_FILE"
  echo "Menjalankan Tes $test_number: ${test_descriptions[$test_number]}" | tee -a "$LOG_FILE"
  echo "========================================" | tee -a "$LOG_FILE"

  case $test_number in
    1)  # Tes 1: Add Book With Complete Data
      NEW_BOOK_DATA='{
        "name": "Buku A",
        "year": 2010,
        "author": "John Doe",
        "summary": "Lorem ipsum dolor sit amet",
        "publisher": "Dicoding Indonesia",
        "pageCount": 100,
        "readPage": 25,
        "reading": false
      }'
      run_command "curl -s -X POST \"$BASE_URL/books\" \
                        -H 'Content-Type: application/json' \
                        -d '$NEW_BOOK_DATA'" "Tes 1: Add Book With Complete Data"
      response=$(curl -s -X POST "$BASE_URL/books" \
                        -H 'Content-Type: application/json' \
                        -d "$NEW_BOOK_DATA")
      echo "$response" | jq | tee -a "$LOG_FILE"

      # Ekstrak bookId dari response (untuk tes selanjutnya)
      BOOK_ID=$(echo "$response" | jq -r '.data.bookId')
      if [ -z "$BOOK_ID" ]; then
        echo "ERROR: Gagal mendapatkan BOOK_ID dari response Tes 1" | tee -a "$LOG_FILE"
        exit 1
      fi
      ;;

    2)  # Tes 2: Add Book With Finished Reading
      NEW_BOOK_DATA_FINISHED='{
        "name": "Buku B",
        "year": 2024,
        "author": "Jane Doe",
        "summary": "Buku tentang petualangan seru",
        "publisher": "Penerbit Maju",
        "pageCount": 100,
        "readPage": 100,
        "reading": true
      }'
      run_command "curl -s -X POST \"$BASE_URL/books\" \
                        -H 'Content-Type: application/json' \
                        -d '$NEW_BOOK_DATA_FINISHED'" "Tes 2: Add Book With Finished Reading"
      response=$(curl -s -X POST "$BASE_URL/books" \
                        -H 'Content-Type: application/json' \
                        -d "$NEW_BOOK_DATA_FINISHED")
      echo "$response" | jq | tee -a "$LOG_FILE"

      BOOK_ID_FINISHED=$(echo "$response" | jq -r '.data.bookId')
       if [ -z "$BOOK_ID_FINISHED" ]; then
        echo "ERROR: Gagal mendapatkan BOOK_ID_FINISHED dari response Tes 2" | tee -a "$LOG_FILE"
        exit 1
      fi
      ;;

    3)  # Tes 3: Add Book Without Name
      NEW_BOOK_DATA_WITHOUT_NAME='{
        "year": 2010,
        "author": "John Doe",
        "summary": "Lorem ipsum dolor sit amet",
        "publisher": "Dicoding Indonesia",
        "pageCount": 100,
        "readPage": 25,
        "reading": false
      }'
      run_command "curl -s -X POST \"$BASE_URL/books\" \
                        -H 'Content-Type: application/json' \
                        -d '$NEW_BOOK_DATA_WITHOUT_NAME'" "Tes 3: Add Book Without Name"
      curl -s -X POST "$BASE_URL/books" \
            -H 'Content-Type: application/json' \
            -d "$NEW_BOOK_DATA_WITHOUT_NAME" | jq | tee -a "$LOG_FILE"
      ;;

    4)  # Tes 4: Add Book with Page Read More Than Page Count
      NEW_BOOK_DATA_INVALID_PAGE='{
        "name": "Buku C",
        "year": 2023,
        "author": "Anonim",
        "summary": "Misteri di pulau terpencil",
        "publisher": "Pustaka Abadi",
        "pageCount": 80,
        "readPage": 90,
        "reading": true
      }'
      run_command "curl -s -X POST \"$BASE_URL/books\" \
                        -H 'Content-Type: application/json' \
                        -d '$NEW_BOOK_DATA_INVALID_PAGE'" "Tes 4: Add Book with Page Read More Than Page Count"
      curl -s -X POST "$BASE_URL/books" \
            -H 'Content-Type: application/json' \
            -d "$NEW_BOOK_DATA_INVALID_PAGE" | jq | tee -a "$LOG_FILE"
      ;;

    5)  # Tes 5: Get All Books
      run_command "curl -s \"$BASE_URL/books\"" "Tes 5: Get All Books"
      curl -s "$BASE_URL/books" | jq | tee -a "$LOG_FILE"
      ;;

    6)  # Tes 6: Get Detail Books With Correct Id
      run_command "curl -s \"$BASE_URL/books/$BOOK_ID\"" "Tes 6: Get Detail Books With Correct Id"
      curl -s "$BASE_URL/books/$BOOK_ID" | jq | tee -a "$LOG_FILE"
      ;;

    7)  # Tes 7: Get Detail Finished Book
      run_command "curl -s \"$BASE_URL/books/$BOOK_ID_FINISHED\"" "Tes 7: Get Detail Finished Book"
      curl -s "$BASE_URL/books/$BOOK_ID_FINISHED" | jq | tee -a "$LOG_FILE"
      ;;

    8)  # Tes 8: Get Detail Books With Invalid Id
      run_command "curl -s \"$BASE_URL/books/xxxxx\"" "Tes 8: Get Detail Books With Invalid Id"
      curl -s "$BASE_URL/books/xxxxx" | jq | tee -a "$LOG_FILE"
      ;;

    9)  # Tes 9: Update Book With Complete Data
      UPDATE_BOOK_DATA='{
        "name": "Buku A Revisi",
        "year": 2011,
        "author": "Jane Doe",
        "summary": "Update: Lorem ipsum dolor",
        "publisher": "Penerbit Maju Jaya",
        "pageCount": 150,
        "readPage": 50,
        "reading": true
      }'
      run_command "curl -s -X PUT \"$BASE_URL/books/$BOOK_ID\" \
                        -H 'Content-Type: application/json' \
                        -d '$UPDATE_BOOK_DATA'" "Tes 9: Update Book With Complete Data"
      curl -s -X PUT "$BASE_URL/books/$BOOK_ID" \
            -H 'Content-Type: application/json' \
            -d "$UPDATE_BOOK_DATA" | jq | tee -a "$LOG_FILE"

      # Verifikasi Update (Opsional)
      echo "Verifikasi Update (GET detail buku setelah update):" | tee -a "$LOG_FILE"
      run_command "curl -s \"$BASE_URL/books/$BOOK_ID\""  "Tes 9 Verifikasi: GET detail buku setelah update"
      curl -s "$BASE_URL/books/$BOOK_ID" | jq | tee -a "$LOG_FILE"
      ;;

    10) # Tes 10: Update Book Without Name
      UPDATE_BOOK_DATA_WITHOUT_NAME='{
        "year": 2011,
        "author": "Jane Doe",
        "summary": "Update: Lorem ipsum dolor",
        "publisher": "Penerbit Maju Jaya",
        "pageCount": 150,
        "readPage": 50,
        "reading": true
      }'
      run_command "curl -s -X PUT \"$BASE_URL/books/$BOOK_ID\" \
                        -H 'Content-Type: application/json' \
                        -d '$UPDATE_BOOK_DATA_WITHOUT_NAME'" "Tes 10: Update Book Without Name"
      curl -s -X PUT "$BASE_URL/books/$BOOK_ID" \
            -H 'Content-Type: application/json' \
            -d "$UPDATE_BOOK_DATA_WITHOUT_NAME" | jq | tee -a "$LOG_FILE"
      ;;

    11) # Tes 11: Update Book With Page Read More Than Page Count
      UPDATE_BOOK_DATA_INVALID_PAGE='{
        "name": "Buku A Revisi",
        "year": 2011,
        "author": "Jane Doe",
        "summary": "Update: Lorem ipsum dolor",
        "publisher": "Penerbit Maju Jaya",
        "pageCount": 80,
        "readPage": 90,
        "reading": true
      }'
      run_command "curl -s -X PUT \"$BASE_URL/books/$BOOK_ID\" \
                        -H 'Content-Type: application/json' \
                        -d '$UPDATE_BOOK_DATA_INVALID_PAGE'"  "Tes 11: Update Book With Page Read More Than Page Count"
      curl -s -X PUT "$BASE_URL/books/$BOOK_ID" \
            -H 'Content-Type: application/json' \
            -d "$UPDATE_BOOK_DATA_INVALID_PAGE" | jq | tee -a "$LOG_FILE"
      ;;

    12) # Tes 12: Update Book with Invalid Id
      run_command "curl -s -X PUT \"$BASE_URL/books/xxxxx\" \
                        -H 'Content-Type: application/json' \
                        -d '$UPDATE_BOOK_DATA'" "Tes 12: Update Book with Invalid Id"
      curl -s -X PUT "$BASE_URL/books/xxxxx" \
            -H 'Content-Type: application/json' \
            -d "$UPDATE_BOOK_DATA" | jq | tee -a "$LOG_FILE"
      ;;

    13) # Tes 13: Delete Book With Correct Id
      run_command "curl -s -X DELETE \"$BASE_URL/books/$BOOK_ID\"" "Tes 13: Delete Book With Correct Id"
      curl -s -X DELETE "$BASE_URL/books/$BOOK_ID" | jq | tee -a "$LOG_FILE"

      # Verifikasi Delete (Opsional)
      echo "Verifikasi Delete (GET detail buku setelah delete):" | tee -a "$LOG_FILE"
      run_command "curl -s \"$BASE_URL/books/$BOOK_ID\"" "Tes 13 Verifikasi: Get setelah Delete"
      curl -s "$BASE_URL/books/$BOOK_ID" | jq | tee -a "$LOG_FILE"
      ;;

    14) # Tes 14: Delete Book With Invalid Id
      run_command "curl -s -X DELETE \"$BASE_URL/books/xxxxx\"" "Tes 14: Delete Book With Invalid Id"
      curl -s -X DELETE "$BASE_URL/books/xxxxx" | jq | tee -a "$LOG_FILE"
      ;;
    
    15)  # Tes 15: Get Books with Name
      run_command "curl -s \"$BASE_URL/books?name=Dicoding\"" "Tes 15: Get Books with Name"
      curl -s "$BASE_URL/books?name=Dicoding" | jq | tee -a "$LOG_FILE"
      ;;

    16)  # Tes 16: Jalankan Semua Tes
      run_all_tests
      ;;

    *)  # Opsi Tidak Valid
      echo "Opsi tidak valid." | tee -a "$LOG_FILE"
      ;;
  esac
}

# Fungsi untuk Menjalankan Semua Tes
run_all_tests() {
  for i in $(seq 1 15); do
    run_test $i
    echo "Selesai Tes $i. Tekan Enter untuk melanjutkan..."
    read -r -n 1 -s -p ""
    echo "" | tee -a "$LOG_FILE" # Tambahkan baris kosong ke log setelah setiap tes
  done
}

# Daftar Deskripsi Tes
declare -A test_descriptions
test_descriptions[1]="Add Book With Complete Data"
test_descriptions[2]="Add Book With Finished Reading"
test_descriptions[3]="Add Book Without Name"
test_descriptions[4]="Add Book with Page Read More Than Page Count"
test_descriptions[5]="Get All Books"
test_descriptions[6]="Get Detail Books With Correct Id"
test_descriptions[7]="Get Detail Finished Book"
test_descriptions[8]="Get Detail Books With Invalid Id"
test_descriptions[9]="Update Book With Complete Data"
test_descriptions[10]="Update Book Without Name"
test_descriptions[11]="Update Book With Page Read More Than Page Count"
test_descriptions[12]="Update Book with Invalid Id"
test_descriptions[13]="Delete Book With Correct Id"
test_descriptions[14]="Delete Book With Invalid Id"
test_descriptions[15]="Get Books with Name"
test_descriptions[16]="Jalankan Semua Tes"

# Menu Utama
show_menu() {
  echo "========================================" | tee -a "$LOG_FILE"
  echo " Selamat Datang di Script Tes API Bookshelf" | tee -a "$LOG_FILE"
  echo "========================================" | tee -a "$LOG_FILE"
  echo "Pilih tes yang ingin dijalankan:" | tee -a "$LOG_FILE"
  for i in $(seq 1 16); do
    echo "$i. ${test_descriptions[$i]}" | tee -a "$LOG_FILE"
  done
  echo "0. Keluar" | tee -a "$LOG_FILE"
  echo "Masukkan nomor tes: " | tee -a "$LOG_FILE"
  read -r test_choice
}

# Main Program
while true; do
  show_menu
  if [[ "$test_choice" -eq 0 ]]; then
    echo "Keluar dari script." | tee -a "$LOG_FILE"
    break
  elif [[ "$test_choice" -ge 1 && "$test_choice" -le 16 ]]; then
    run_test "$test_choice"
  else
    echo "Pilihan tidak valid. Silakan coba lagi." | tee -a "$LOG_FILE"
  fi
  echo "" | tee -a "$LOG_FILE" # Tambahkan baris kosong ke log setelah setiap iterasi
done

echo "Semua tes selesai. Hasil tes dicatat di file: $LOG_FILE" | tee -a "$LOG_FILE"

exit 0


#  Script Otomatisasi Tes API Bookshelf dengan Logging
#  Dokumentasi Lengkap Bahasa Indonesia
#
#  Script ini menjalankan serangkaian tes API untuk aplikasi Bookshelf dan mencatat
#  hasilnya ke dalam file log. Anda dapat memilih tes individual atau menjalankan
#  semua tes sekaligus.
#
#  Cara Penggunaan:
#  1.  Simpan script ini sebagai file .sh (misalnya, `test_bookshelf_api.sh`).
#  2.  Ubah permission agar bisa dieksekusi: `chmod +x test_bookshelf_api.sh`
#  3.  Jalankan script: `./test_bookshelf_api.sh`
#  4.  Ikuti petunjuk di menu untuk memilih tes yang ingin dijalankan.
#
#  Prasyarat:
#  -   Aplikasi Bookshelf API harus sudah berjalan.
#  -   Pastikan nilai-nilai variabel di dalam script sesuai dengan environment Anda.
#      (Terutama `BASE_URL`, `NEW_BOOK_DATA`, dan `UPDATE_BOOK_DATA`).
#  -   (Opsional) Install `jq` untuk memformat output JSON: `sudo apt install jq` (Debian/Ubuntu)
#
#  Output:
#  -   Script akan menampilkan hasil setiap tes (status code, header, body) ke terminal
#      dan juga mencatatnya ke file log.
#  -   Nama file log akan berdasarkan tanggal dan waktu saat script dijalankan.

# Konfigurasi Environment (Ganti dengan nilai sesuai environment Anda)
BASE_URL="http://localhost:9000"

# Data untuk Add Book (Tes 1 & 2)
NEW_BOOK_DATA='{
  "name": "Buku A",
  "year": 2010,
  "author": "John Doe",
  "summary": "Lorem ipsum dolor sit amet",
  "publisher": "Dicoding Indonesia",
  "pageCount": 100,
  "readPage": 25,
  "reading": false
}'

# Data untuk Update Book (Tes 9)
UPDATE_BOOK_DATA='{
  "name": "Buku A Revisi",
  "year": 2011,
  "author": "Jane Doe",
  "summary": "Update: Lorem ipsum dolor",
  "publisher": "Penerbit Maju Jaya",
  "pageCount": 150,
  "readPage": 50,
  "reading": true
}'

# Variabel Global untuk Menyimpan bookId
BOOK_ID=""
BOOK_ID_FINISHED=""

# Membuat Nama File Log Berdasarkan Tanggal dan Waktu
LOG_FILE="bookshelf_api_test_$(date +'%Y%m%d_%H%M%S').log"

# Fungsi untuk Menjalankan Tes dan Mencatat Log
run_test() {
  test_number="$1"

  echo "========================================" | tee -a "$LOG_FILE"
  echo "Menjalankan Tes $test_number: $test_descriptions[$test_number]" | tee -a "$LOG_FILE"
  echo "========================================" | tee -a "$LOG_FILE"

  case $test_number in
    1)  # Tes 1: Add Book With Complete Data
      response=$(curl -s -X POST "$BASE_URL/books" \
                       -H 'Content-Type: application/json' \
                       -d "$NEW_BOOK_DATA")
      echo "$response" | jq | tee -a "$LOG_FILE"

      # Ekstrak bookId dari response (untuk tes selanjutnya)
      BOOK_ID=$(echo "$response" | jq -r '.data.bookId')
      ;;

    2)  # Tes 2: Add Book With Finished Reading
      NEW_BOOK_DATA_FINISHED='{
        "name": "Buku B",
        "year": 2024,
        "author": "Jane Doe",
        "summary": "Buku tentang petualangan seru",
        "publisher": "Penerbit Maju",
        "pageCount": 100,
        "readPage": 100,
        "reading": true
      }'
      response=$(curl -s -X POST "$BASE_URL/books" \
                       -H 'Content-Type: application/json' \
                       -d "$NEW_BOOK_DATA_FINISHED")
      echo "$response" | jq | tee -a "$LOG_FILE"

      BOOK_ID_FINISHED=$(echo "$response" | jq -r '.data.bookId')
      ;;

    3)  # Tes 3: Add Book Without Name
      NEW_BOOK_DATA_WITHOUT_NAME='{
        "year": 2010,
        "author": "John Doe",
        "summary": "Lorem ipsum dolor sit amet",
        "publisher": "Dicoding Indonesia",
        "pageCount": 100,
        "readPage": 25,
        "reading": false
      }'
      curl -s -X POST "$BASE_URL/books" \
           -H 'Content-Type: application/json' \
           -d "$NEW_BOOK_DATA_WITHOUT_NAME" | jq | tee -a "$LOG_FILE"
      ;;

    4)  # Tes 4: Add Book with Page Read More Than Page Count
      NEW_BOOK_DATA_INVALID_PAGE='{
        "name": "Buku C",
        "year": 2023,
        "author": "Anonim",
        "summary": "Misteri di pulau terpencil",
        "publisher": "Pustaka Abadi",
        "pageCount": 80,
        "readPage": 90,
        "reading": true
      }'
      curl -s -X POST "$BASE_URL/books" \
           -H 'Content-Type: application/json' \
           -d "$NEW_BOOK_DATA_INVALID_PAGE" | jq | tee -a "$LOG_FILE"
      ;;

    5)  # Tes 5: Get All Books
      curl -s "$BASE_URL/books" | jq | tee -a "$LOG_FILE"
      ;;

    6)  # Tes 6: Get Detail Books With Correct Id
      curl -s "$BASE_URL/books/$BOOK_ID" | jq | tee -a "$LOG_FILE"
      ;;

    7)  # Tes 7: Get Detail Finished Book
      curl -s "$BASE_URL/books/$BOOK_ID_FINISHED" | jq | tee -a "$LOG_FILE"
      ;;

    8)  # Tes 8: Get Detail Books With Invalid Id
      curl -s "$BASE_URL/books/xxxxx" | jq | tee -a "$LOG_FILE"
      ;;

    9)  # Tes 9: Update Book With Complete Data
      curl -s -X PUT "$BASE_URL/books/$BOOK_ID" \
           -H 'Content-Type: application/json' \
           -d "$UPDATE_BOOK_DATA" | jq | tee -a "$LOG_FILE"

      # Verifikasi Update (Opsional)
      echo "Verifikasi Update (GET detail buku setelah update):" | tee -a "$LOG_FILE"
      curl -s "$BASE_URL/books/$BOOK_ID" | jq | tee -a "$LOG_FILE"
      ;;

    10) # Tes 10: Update Book Without Name
      UPDATE_BOOK_DATA_WITHOUT_NAME='{
        "year": 2011,
        "author": "Jane Doe",
        "summary": "Update: Lorem ipsum dolor",
        "publisher": "Penerbit Maju Jaya",
        "pageCount": 150,
        "readPage": 50,
        "reading": true
      }'
      curl -s -X PUT "$BASE_URL/books/$BOOK_ID" \
           -H 'Content-Type: application/json' \
           -d "$UPDATE_BOOK_DATA_WITHOUT_NAME" | jq | tee -a "$LOG_FILE"
      ;;

    11) # Tes 11: Update Book With Page Read More Than Page Count
      UPDATE_BOOK_DATA_INVALID_PAGE='{
        "name": "Buku A Revisi",
        "year": 2011,
        "author": "Jane Doe",
        "summary": "Update: Lorem ipsum dolor",
        "publisher": "Penerbit Maju Jaya",
        "pageCount": 80,
        "readPage": 90,
        "reading": true
      }'
      curl -s -X PUT "$BASE_URL/books/$BOOK_ID" \
           -H 'Content-Type: application/json' \
           -d "$UPDATE_BOOK_DATA_INVALID_PAGE" | jq | tee -a "$LOG_FILE"
      ;;

    12) # Tes 12: Update Book with Invalid Id
      curl -s -X PUT "$BASE_URL/books/xxxxx" \
           -H 'Content-Type: application/json' \
           -d "$UPDATE_BOOK_DATA" | jq | tee -a "$LOG_FILE"
      ;;

    13) # Tes 13: Delete Book With Correct Id
      curl -s -X DELETE "$BASE_URL/books/$BOOK_ID" | jq | tee -a "$LOG_FILE"

      # Verifikasi Delete (Opsional)
      echo "Verifikasi Delete (GET detail buku setelah delete):" | tee -a "$LOG_FILE"
      curl -s "$BASE_URL/books/$BOOK_ID" | jq | tee -a "$LOG_FILE"
      ;;

    14) # Tes 14: Delete Book With Invalid Id
      curl -s -X DELETE "$BASE_URL/books/xxxxx" | jq | tee -a "$LOG_FILE"
      ;;

    15) # Tes 15: Get Books with Name
      curl -s "$BASE_URL/books?name=Dicoding" | jq | tee -a "$LOG_FILE"
      ;;

    16)  # Tes 16: Jalankan Semua Tes
      run_all_tests
      ;;

    *)  # Opsi Tidak Valid
      echo "Opsi tidak valid." | tee -a "$LOG_FILE"
      ;;
  esac
}

# Fungsi untuk Menjalankan Semua Tes
run_all_tests() {
  for i in $(seq 1 15); do
    run_test $i
    echo "Selesai Tes $i. Tekan Enter untuk melanjutkan..."
    read -r -n 1 -s -p ""
    echo "" | tee -a "$LOG_FILE" # Tambahkan baris kosong ke log setelah setiap tes
  done
}

# Daftar Deskripsi Tes
declare -A test_descriptions
test_descriptions[1]="Add Book With Complete Data"
test_descriptions[2]="Add Book With Finished Reading"
test_descriptions[3]="Add Book Without Name"
test_descriptions[4]="Add Book with Page Read More Than Page Count"
test_descriptions[5]="Get All Books"
test_descriptions[6]="Get Detail Books With Correct Id"
test_descriptions[7]="Get Detail Finished Book"
test_descriptions[8]="Get Detail Books With Invalid Id"
test_descriptions[9]="Update Book With Complete Data"
test_descriptions[10]="Update Book Without Name"
test_descriptions[11]="Update Book With Page Read More Than Page Count"
test_descriptions[12]="Update Book with Invalid Id"
test_descriptions[13]="Delete Book With Correct Id"
test_descriptions[14]="Delete Book With Invalid Id"
test_descriptions[15]="Get Books with Name"
test_descriptions[16]="Jalankan Semua Tes"

# Menu Utama
show_menu() {
  echo "========================================"
  echo "  Selamat Datang di Script Tes API Bookshelf"
  echo "========================================"
  echo "Pilih tes yang ingin dijalankan:"
  for i in $(seq 1 16); do
    echo "$i. ${test_descriptions[$i]}"
  done
  echo "0. Keluar"
  echo "Masukkan nomor tes: "
  read -r test_choice
}

# Main Program
while true; do
  show_menu | tee -a "$LOG_FILE" # Catat menu ke log
  if [[ "$test_choice" -eq 0 ]]; then
    echo "Keluar dari script." | tee -a "$LOG_FILE"
    break
  elif [[ "$test_choice" -ge 1 && "$test_choice" -le 16 ]]; then
    run_test "$test_choice"
  else
    echo "Pilihan tidak valid. Silakan coba lagi." | tee -a "$LOG_FILE"
  fi
  echo "" | tee -a "$LOG_FILE" # Tambahkan baris kosong ke log setelah setiap iterasi
done

echo "Semua tes selesai. Hasil tes dicatat di file: $LOG_FILE" | tee -a "$LOG_FILE"

exit 0
