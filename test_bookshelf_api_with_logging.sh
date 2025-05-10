#!/bin/bash

# Bookshelf API Automated Test Script with Logging
LOG_FILE="bookshelf_api_test_results.log"
API_URL="http://localhost:9000"

echo "Running Bookshelf API tests..." | tee $LOG_FILE

# 1. Add Book - success
echo -e "\n==> Add Book - success" | tee -a $LOG_FILE
curl -X POST $API_URL/books \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Buku A",
    "year": 2020,
    "author": "Penulis A",
    "summary": "Ini ringkasan",
    "publisher": "Penerbit A",
    "pageCount": 100,
    "readPage": 50,
    "reading": true
  }' | tee -a $LOG_FILE

# 2. Add Book - fail (missing name)
echo -e "\n==> Add Book - fail (missing name)" | tee -a $LOG_FILE
curl -X POST $API_URL/books \
  -H "Content-Type: application/json" \
  -d '{
    "year": 2020,
    "author": "Penulis A",
    "summary": "Ini ringkasan",
    "publisher": "Penerbit A",
    "pageCount": 100,
    "readPage": 50,
    "reading": true
  }' | tee -a $LOG_FILE

# 3. Add Book - fail (readPage > pageCount)
echo -e "\n==> Add Book - fail (readPage > pageCount)" | tee -a $LOG_FILE
curl -X POST $API_URL/books \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Buku Salah",
    "year": 2020,
    "author": "Penulis Salah",
    "summary": "Ini salah",
    "publisher": "Penerbit Salah",
    "pageCount": 100,
    "readPage": 150,
    "reading": true
  }' | tee -a $LOG_FILE

# 4. Get All Books
echo -e "\n==> Get All Books" | tee -a $LOG_FILE
curl -X GET $API_URL/books | tee -a $LOG_FILE

# 5. Get Book by ID (replace 'book-id-not-found' later)
echo -e "\n==> Get Book by ID (not found)" | tee -a $LOG_FILE
curl -X GET $API_URL/books/book-id-not-found | tee -a $LOG_FILE

# 6. Update Book by ID (replace 'book-id-not-found' later)
echo -e "\n==> Update Book by ID (not found)" | tee -a $LOG_FILE
curl -X PUT $API_URL/books/book-id-not-found \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Updated Book",
    "year": 2021,
    "author": "Updated Author",
    "summary": "Updated Summary",
    "publisher": "Updated Publisher",
    "pageCount": 120,
    "readPage": 60,
    "reading": false
  }' | tee -a $LOG_FILE

# 7. Delete Book by ID (replace 'book-id-not-found' later)
echo -e "\n==> Delete Book by ID (not found)" | tee -a $LOG_FILE
curl -X DELETE $API_URL/books/book-id-not-found | tee -a $LOG_FILE

# 8. Get Books by Query (name)
echo -e "\n==> Get Books by Query (name)" | tee -a $LOG_FILE
curl -X GET "$API_URL/books?name=buku" | tee -a $LOG_FILE

# 9. Get Books by Query (reading = 1)
echo -e "\n==> Get Books by Query (reading = 1)" | tee -a $LOG_FILE
curl -X GET "$API_URL/books?reading=1" | tee -a $LOG_FILE

# 10. Get Books by Query (finished = 0)
echo -e "\n==> Get Books by Query (finished = 0)" | tee -a $LOG_FILE
curl -X GET "$API_URL/books?finished=0" | tee -a $LOG_FILE

echo -e "\nAll tests finished. Output saved to $LOG_FILE"
