const express = require('express');
const app = express();
const port = 8080;

const jokes = {
  green: "Why was the math book sad? Because it had too many problems!",
  red: "What did one strawberry say to the other? If you weren't so sweet, we wouldn't be in this jam!",
  yellow: "Why don't scientists trust atoms? Because they make up everything!"
};

app.get('/green', (req, res) => {
  res.send(jokes.green);
});

app.get('/red', (req, res) => {
  res.send(jokes.red);
});

app.get('/yellow', (req, res) => {
  res.send(jokes.yellow);
});

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
