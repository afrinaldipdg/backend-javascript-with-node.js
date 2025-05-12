const baseUrl = '/books';

const tests = [
  {
    title: 'Add Book (Valid)',
    method: 'POST',
    endpoint: '',
    body: {
      name: "Book A",
      year: 2023,
      author: "John Doe",
      summary: "This is a great book.",
      publisher: "Publisher X",
      pageCount: 200,
      readPage: 100,
      reading: true
    }
  },
  {
    title: 'Get All Books',
    method: 'GET',
    endpoint: ''
  },
  {
    title: 'Get Book Detail (Requires bookId)',
    method: 'GET',
    endpoint: '/:id'
  },
  {
    title: 'Update Book (Requires bookId)',
    method: 'PUT',
    endpoint: '/:id',
    body: {
      name: "Updated Book",
      year: 2024,
      pageCount: 250,
      readPage: 200,
      reading: false
    }
  },
  {
    title: 'Delete Book (Requires bookId)',
    method: 'DELETE',
    endpoint: '/:id'
  }
];

let lastBookId = '';

function createCard(test, index) {
  const card = document.createElement('div');
  card.className = 'card';
  const title = document.createElement('h3');
  title.textContent = test.title;

  const btn = document.createElement('button');
  btn.textContent = 'Run Test';
  btn.onclick = () => runTest(index);

  const result = document.createElement('pre');
  result.id = `result-${index}`;

  card.append(title, btn, result);
  return card;
}

function renderTests() {
  const grid = document.createElement('div');
  grid.className = 'grid';
  tests.forEach((test, i) => grid.appendChild(createCard(test, i)));
  document.body.appendChild(grid);
}

async function runTest(index) {
  const test = tests[index];
  let url = baseUrl + test.endpoint;
  if (url.includes(':id')) {
    if (!lastBookId) return alert('bookId not available yet. Please run Add Book first.');
    url = url.replace(':id', lastBookId);
  }

  const options = {
    method: test.method,
    headers: { 'Content-Type': 'application/json' }
  };

  if (test.body) options.body = JSON.stringify(test.body);

  try {
    const res = await fetch(url, options);
    const data = await res.json();
    document.getElementById(`result-${index}`).textContent = JSON.stringify(data, null, 2);

    if (index === 0 && data?.data?.bookId) {
      lastBookId = data.data.bookId;
    }
  } catch (err) {
    document.getElementById(`result-${index}`).textContent = 'Error: ' + err.message;
  }
}

window.onload = renderTests;

