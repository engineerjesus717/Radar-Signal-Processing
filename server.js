"use strict";

// Minimal local-only static server for opening the simulator without file:// restrictions.
const http = require("node:http");
const fs = require("node:fs");
const path = require("node:path");

const requestedPort = Number.parseInt(process.argv[2] || "3000", 10);
const port = Number.isInteger(requestedPort) && requestedPort > 0 && requestedPort < 65536 ? requestedPort : 3000;
const root = __dirname;
const mimeTypes = {
  ".css": "text/css; charset=utf-8",
  ".html": "text/html; charset=utf-8",
  ".js": "text/javascript; charset=utf-8",
  ".json": "application/json; charset=utf-8",
  ".svg": "image/svg+xml"
};

const server = http.createServer((request, response) => {
  const requestUrl = new URL(request.url, "http://localhost");
  const relativePath = decodeURIComponent(requestUrl.pathname === "/" ? "/index.html" : requestUrl.pathname)
    .replace(/^[/\\]+/, "");
  const requestedFile = path.resolve(root, relativePath);

  if (!requestedFile.startsWith(`${root}${path.sep}`)) {
    response.writeHead(403, { "Content-Type": "text/plain; charset=utf-8" });
    response.end("Forbidden");
    return;
  }

  fs.readFile(requestedFile, (error, contents) => {
    if (error) {
      response.writeHead(error.code === "ENOENT" ? 404 : 500, { "Content-Type": "text/plain; charset=utf-8" });
      response.end(error.code === "ENOENT" ? "Not found" : "Unable to read the requested file");
      return;
    }
    response.writeHead(200, { "Content-Type": mimeTypes[path.extname(requestedFile).toLowerCase()] || "application/octet-stream" });
    response.end(contents);
  });
});

server.on("error", (error) => {
  if (error.code === "EADDRINUSE") {
    console.error(`Port ${port} is already in use. Try: node server.js ${port + 1}`);
    return;
  }
  console.error(error.message);
});

server.listen(port, "127.0.0.1", () => {
  console.log(`Radar simulator is running at http://localhost:${port}`);
  console.log("Press Ctrl+C to stop the server.");
});
