#!/bin/bash

echo 'Running Bookshelf API tests with curl...'

echo '==> [Mandatory] Add Book With Complete Data'
curl -X POST  --data-raw '{
    "name": "{{newName}}",
    "year": {{newYear}},
    "author": "{{newAuthor}}",
    "summary": "{{newSummary}}",
    "publisher": "{{newPublisher}}",
    "pageCount": {{newPageCount}},
    "readPage": {{newReadPage}},
    "reading": {{newReading}}
}' "http://localhost:9000/books"
echo -e '\n'
echo '==> [Mandatory] Add Book With Finished Reading'
curl -X POST  --data-raw '{
    "name": "{{newName}}",
    "year": {{newYear}},
    "author": "{{newAuthor}}",
    "summary": "{{newSummary}}",
    "publisher": "{{newPublisher}}",
    "pageCount": 100,
    "readPage": 100,
    "reading": {{newReading}}
}' "http://localhost:9000/books"
echo -e '\n'
echo '==> [Mandatory] Add Book Without Name'
curl -X POST  --data-raw '{
    "year": {{newYear}},
    "author": "{{newAuthor}}",
    "summary": "{{newSummary}}",
    "publisher": "{{newPublisher}}",
    "pageCount": {{newPageCount}},
    "readPage": {{newReadPage}},
    "reading": {{newReading}}
}' "http://localhost:9000/books"
echo -e '\n'
echo '==> [Mandatory] Add Book with Page Read More Than Page Count'
curl -X POST  --data-raw '{
    "name": "{{newName}}",
    "year": {{newYear}},
    "author": "{{newAuthor}}",
    "summary": "{{newSummary}}",
    "publisher": "{{newPublisher}}",
    "pageCount": 80,
    "readPage": 90,
    "reading": {{newReading}}
}' "http://localhost:9000/books"
echo -e '\n'
echo '==> [Mandatory] Get All Books'
curl -X GET   "http://localhost:9000/books"
echo -e '\n'
echo '==> [Mandatory] Get Detail Books With Correct Id'
curl -X GET   "http://localhost:9000/books/"
echo -e '\n'
echo '==> [Mandatory] Get Detail Finished Book'
curl -X GET   "http://localhost:9000/books/"
echo -e '\n'
echo '==> [Mandatory] Get Detail Books With Invalid Id'
curl -X GET   "http://localhost:9000/books/xxxxx"
echo -e '\n'
echo '==> [Mandatory] Update Book With Complete Data'
curl -X PUT  --data-raw '{
    "name": "{{updateName}}",
    "year": {{updateYear}},
    "author": "{{updateAuthor}}",
    "summary": "{{updateSummary}}",
    "publisher": "{{updatePublisher}}",
    "pageCount": {{updatePageCount}},
    "readPage": {{updateReadPage}},
    "reading": {{updateReading}}
}' "http://localhost:9000/books/"
echo -e '\n'
echo '==> [Mandatory] Update Book Without Name'
curl -X PUT  --data-raw '{
    "year": {{updateYear}},
    "author": "{{updateAuthor}}",
    "summary": "{{updateSummary}}",
    "publisher": "{{updatePublisher}}",
    "pageCount": {{updatePageCount}},
    "readPage": {{updateReadPage}},
    "reading": {{updateReading}}
}' "http://localhost:9000/books/"
echo -e '\n'
echo '==> [Mandatory] Update Book With Page Read More Than Page Count'
curl -X PUT  --data-raw '{
    "name": "{{updateName}}",
    "year": {{updateYear}},
    "author": "{{updateAuthor}}",
    "summary": "{{updateSummary}}",
    "publisher": "{{updatePublisher}}",
    "pageCount": 80,
    "readPage": 90,
    "reading": {{updateReading}}
}' "http://localhost:9000/books/"
echo -e '\n'
echo '==> [Mandatory] Update Book with Invalid Id'
curl -X PUT  --data-raw '{
    "name": "{{updateName}}",
    "year": {{updateYear}},
    "author": "{{updateAuthor}}",
    "summary": "{{updateSummary}}",
    "publisher": "{{updatePublisher}}",
    "pageCount": {{updatePageCount}},
    "readPage": {{updateReadPage}},
    "reading": {{updateReading}}
}' "http://localhost:9000/books/xxxxx"
echo -e '\n'
echo '==> [Mandatory] Delete Book with Correct Id'
curl -X DELETE   "http://localhost:9000/books/"
echo -e '\n'
echo '==> [Mandatory] Delete Finished book'
curl -X DELETE   "http://localhost:9000/books/"
echo -e '\n'
echo '==> [Mandatory] Delete Book with Invalid Id'
curl -X DELETE   "http://localhost:9000/books/xxxxx"
echo -e '\n'
echo '==> Add Reading and Finished Book'
curl -X POST  --data-raw '{
    "name": "{{newName}}",
    "year": {{newYear}},
    "author": "{{newAuthor}}",
    "summary": "{{newSummary}}",
    "publisher": "{{newPublisher}}",
    "pageCount": 100,
    "readPage": 100,
    "reading": true
}' "http://localhost:9000/books"
echo -e '\n'
echo '==> Add Reading and Unfinished Book with "Dicoding" Name'
curl -X POST  --data-raw '{
    "name": "Kelas Dicoding",
    "year": {{newYear}},
    "author": "{{newAuthor}}",
    "summary": "{{newSummary}}",
    "publisher": "{{newPublisher}}",
    "pageCount": 100,
    "readPage": 99,
    "reading": true
}' "http://localhost:9000/books"
echo -e '\n'
echo '==> Add Unreading Books and Unfinished Book "Dicoding" Name'
curl -X POST  --data-raw '{
    "name": "dicoding Jobs",
    "year": {{newYear}},
    "author": "{{newAuthor}}",
    "summary": "{{newSummary}}",
    "publisher": "{{newPublisher}}",
    "pageCount": 100,
    "readPage": 0,
    "reading": false
}' "http://localhost:9000/books"
echo -e '\n'
echo '==> Add Unreading Books and Unfinished Book'
curl -X POST  --data-raw '{
    "name": "{{newName}}",
    "year": {{newYear}},
    "author": "{{newAuthor}}",
    "summary": "{{newSummary}}",
    "publisher": "{{newPublisher}}",
    "pageCount": 100,
    "readPage": 0,
    "reading": false
}' "http://localhost:9000/books"
echo -e '\n'
echo '==> [Optional] Get All Reading Books'
curl -X GET   "http://localhost:9000/books?reading=1"
echo -e '\n'
echo '==> [Optional] Get All Unreading Books'
curl -X GET   "http://localhost:9000/books?reading=0"
echo -e '\n'
echo '==> [Optional] Get All Finished Books'
curl -X GET   "http://localhost:9000/books?finished=1"
echo -e '\n'
echo '==> [Optional] Get All Unfinished Books'
curl -X GET   "http://localhost:9000/books?finished=0"
echo -e '\n'
echo '==> [Optional] Get All Books Contains "Dicoding" Name'
curl -X GET   "http://localhost:9000/books?name=Dicoding"
echo -e '\n'