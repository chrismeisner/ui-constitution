const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Serve static files from root
app.use(express.static(__dirname, {
  extensions: ['html'],
  setHeaders: (res, filePath) => {
    // Set correct content types
    if (filePath.endsWith('.md')) {
      res.setHeader('Content-Type', 'text/plain; charset=utf-8');
    }
    if (filePath.endsWith('.sh')) {
      res.setHeader('Content-Type', 'text/plain; charset=utf-8');
    }
  }
}));

// Serve index.html for root
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

app.listen(PORT, () => {
  console.log(`UI Constitution running on port ${PORT}`);
});
