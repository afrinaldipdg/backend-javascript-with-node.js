const express = require("express");
const path = require("path");
const booksRoutes = require("./routes/books");

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware parsing
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Menyajikan file statis dari folder 'public'
app.use(express.static(path.join(__dirname, "public")));

// Rute API
app.use("/books", booksRoutes);

// Rute utama untuk menyajikan index.html
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "index.html"));
});

// Menjalankan server
app.listen(PORT, () => {
  console.log(`✅ Server berjalan di http://localhost:${PORT}`);
});
