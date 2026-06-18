# Service A - Simple Node.js microservice

const express = require('express');
const os = require('os');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.json({
    service: 'service-a',
    hostname: os.hostname(),
    message: 'Hello from Service A'
  });
});

app.listen(port, () => console.log(`Service A listening on port ${port}`));
