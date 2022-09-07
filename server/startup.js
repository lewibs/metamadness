const fs = require('fs').promises;
const express = require('express');

//Load HTTP module
const http = require("http");
const hostname = '127.0.0.1';
const port = 3000;

//Create HTTP server and listen on port 3000 for requests
const server = http.createServer((req, res) => {
    if (req.method == "GET") {
        console.warn("user clicked on link...");

        fs.readFile(__dirname + "/static/index.html").then((content)=>{
            //Set the response HTTP header with HTTP status and Content type
            res.statusCode = 200;
            res.setHeader('Content-Type', 'text/html');
            res.end(content);
    
            const app = express();
        });
    } else if (req.method == "POST") {
        console.warn("user sent in password and username:");
        console.log("got post");
    }
});

//listen for request on port 3000, and as a callback function have the port listened on logged
server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
