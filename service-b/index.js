# Service B - Simple Node.js microservice

const express = require('express');
const os = require('os');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.json({
    service: 'service-b',
    hostname: os.hostname(),
    message: 'Hello from Service B'
  });
});

app.listen(port, () => console.log(`Service B listening on port ${port}`));
