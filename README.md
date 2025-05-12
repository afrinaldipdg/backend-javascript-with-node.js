#   Bookshelf API - Postman Collection

[![Awesome Project](https://img.shields.io/badge/Awesome-Project-brightgreen.svg)](https://github.com/your-github-username/your-repo-name)
[![Version](https://img.shields.io/badge/Version-1.0.0-blue.svg)](https://github.com/your-github-username/your-repo-name/releases)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/your-github-username/your-repo-name/blob/main/LICENSE)

A meticulously crafted Postman collection for testing the Bookshelf API. This collection provides a comprehensive suite of tests to ensure the API's robustness and reliability.

##   ?  Elegant Introduction

Embark on a seamless journey to validate your Bookshelf API with this thoughtfully designed Postman collection.  Each test case is crafted with precision, ensuring every facet of your API behaves as expected. From adding new literary treasures to retrieving detailed information and managing updates, this collection is your trusted companion.

##   ??  Table of Contents

-   [Features](#features)
-   [Getting Started](#getting-started)
    -   [Prerequisites](#prerequisites)
    -   [Installation](#installation)
    -   [Environment Setup](#environment-setup)
-   [Collection Overview](#collection-overview)
    -   [Adding Books](#adding-books)
    -   [Retrieving Books](#retrieving-books)
    -   [Updating Books](#updating-books)
    -   [Deleting Books](#deleting-books)  **(Bonus)**
-   [Environment Variables](#environment-variables)
-   [Testing Philosophy](#testing-philosophy)
-   [Contributing](#contributing)
-   [License](#license)
-   [Acknowledgments](#acknowledgments)

##   ??  Features

This Postman collection offers a wide range of tests, covering essential Bookshelf API functionalities:

-   **Adding Books:**
    -   Adding books with complete data.
    -   Handling scenarios with missing book names.
    -   Validating `readPage` against `pageCount`.
-   **Retrieving Books:**
    -   Fetching all books with concise details.
    -   Retrieving detailed information for a specific book.
    -   Handling cases where a book ID is invalid.
-   **Updating Books:**
    -   Updating book details with comprehensive data.
    -   Managing updates when the book's `name` is missing.
    -   Ensuring `readPage` doesn't exceed `pageCount` during updates.
-   **Deleting Books:** **(Bonus - Included in Pre-request Script)**
    -   Efficiently deleting books.

##   ??  Getting Started

###   Prerequisites

Before you begin, ensure you have the following installed:

-   **Postman:** The latest version of the Postman application.  You can download it from [https://www.postman.com/downloads/](https://www.postman.com/downloads/)
-   **Bookshelf API:** A running instance of the Bookshelf API you wish to test.

###   Installation

1.  **Clone the repository:**
    ```bash
    git clone <your-repository-url>
    cd <your-repository-directory>
    ```
2.  **Import the collection:**
    -   Open Postman.
    -   Click on "Import".
    -   Select the `Bookshelf API Test.postman_collection.json` file.

###   Environment Setup

1.  **Import the environment:**
    -   In Postman, click on "Import".
    -   Select the `Bookshelf API Test.postman_environment.json` file.
2.  **Configure the environment variables:**
    -   Select the "Bookshelf API Test" environment from the dropdown.
    -   Edit the environment variables:
        -   `port`:  Set this to the port where your Bookshelf API is running (e.g., `9000`).
        -   Optionally, you can modify the default values for book properties like `newName`, `newAuthor`, etc., to suit your testing needs.

##   ??  Collection Overview

###   Adding Books

-   **[Mandatory] Add Book With Complete Data:** Tests successful book creation with all required fields.
-   **[Mandatory] Add Book With Finished Reading:** Verifies book creation when `readPage` equals `pageCount`.
-   **[Mandatory] Add Book Without Name:** Ensures the API correctly rejects book creation when the `name` field is missing.
-   **[Mandatory] Add Book with Page Read More Than Page Count:** Validates that the API prevents creating books where `readPage` exceeds `pageCount`.

###   Retrieving Books

-   **[Mandatory] Get All Books:** Retrieves a list of all books, verifying the response structure.
-   **[Mandatory] Get Detail Books With Correct Id:** Fetches detailed information for a specific book using its ID.
-   **[Mandatory] Get Detail Finished Book:** Retrieves details for a book marked as finished (readPage = pageCount).
-   **[Mandatory] Get Detail Books With Invalid Id:** Confirms the API's behavior when an invalid book ID is provided.

###   Updating Books

-   **[Mandatory] Update Book With Complete Data:** Tests the successful modification of book details.
-   **[Mandatory] Update Book Without Name:** Checks if the API handles updates correctly when the book's `name` is missing.
-   **[Mandatory] Update Book With Page Read More Than Page Count:** Validates the API's response when trying to update a book with `readPage` greater than `pageCount`.
-   **[Mandatory] Update Book with Invalid Id:** Verifies that the API returns an error when attempting to update a book with an ID that does not exist.

###   Deleting Books  **(Bonus)**

-   **[Bonus] Delete All Books:** This request is included as a pre-request script in the "Get All Books" request.  It efficiently cleans up all books in the database before fetching the list, ensuring a consistent testing environment.  This showcases an advanced Postman technique for managing test data.

##   ??  Environment Variables

The `Bookshelf API Test.postman_environment.json` file contains the following key variables:

| Variable                     | Description                                                          | Default Value                        |
| :--------------------------- | :------------------------------------------------------------------- | :----------------------------------- |
| `port`                       | The port where the Bookshelf API is running.                         | `9000`                               |
| `bookId`                     | (Generated) The ID of a newly created book.                          | *Empty* |
| `bookIdWithFinishedReading`   | (Generated) ID of a book with finished reading.                     | *Empty* |
| `newName`                    | The name of a new book.                                              | `Buku A`                             |
| `newYear`                    | The publication year of a new book.                                  | `2010`                               |
| `newAuthor`                  | The author of a new book.                                            | `John Doe`                           |
| `newSummary`                 | The summary of a new book.                                           | `Lorem ipsum dolor sit amet`           |
| `newPublisher`               | The publisher of a new book.                                         | `Dicoding Indonesia`                 |
| `newPageCount`               | The total number of pages in a new book.                             | `100`                                |
| `newReadPage`                | The number of pages read in a new book.                               | `25`                                 |
| `newReading`                 | Whether the book is currently being read.                             | `false`                              |
| `updateName`                 | The updated name of a book.                                          | `Buku A Revisi`                      |
| `updateYear`                 | The updated publication year of a book.                              | `2011`                               |
| `updateAuthor`               | The updated author of a book.                                        | `Jane Doe`                           |
| `updateSummary`                | The updated summary of a book.                                         | `Updated Lorem Ipsum`                |
| `updatePublisher`              | The updated publisher of a book.                                       | `Dicoding Academy`                   |
| `updatePageCount`              | The updated total number of pages in a book.                         | `120`                                |
| `updateReadPage`               | The updated number of pages read in a book.                           | `30`                                 |
| `updateReading`                | Whether the book is currently being read (updated).                   | `true`                               |

##   ??  Testing Philosophy

This collection adheres to a philosophy of thorough and precise testing.  Each test case is designed to validate specific aspects of the API, providing clear and actionable feedback.  Assertions are used extensively to ensure responses match expected outcomes, covering status codes, headers, and response body content.

##   ??  Contributing

Contributions are welcome!  If you have suggestions for new test cases, improvements to existing ones, or any other enhancements, please feel free to:

1.  Fork the repository.
2.  Create a new branch for your feature or bug fix.
3.  Make your changes.
4.  Submit a pull request.

##   ??  License

This project is licensed under the MIT License.  See the `LICENSE` file for details.

##   ??  Acknowledgments

-   Special thanks to the developers of the Bookshelf API for creating such a wonderful platform.
-   Thanks to the Postman team for providing an excellent tool for API testing.

---

**Note:** Replace `<your-github-username>` and `<your-repo-name>` with your actual GitHub information.  Feel free to further customize this `README.md` to perfectly match your project's style and needs!
