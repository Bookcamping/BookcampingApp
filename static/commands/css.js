const files = require("../lib/files");
const http = require("../lib/http");

const PATHS = [
  "assets/application.css",
  "/assets/fontawesome-webfont.eot",
  "/assets/fontawesome-webfont.woff",
  "/assets/fontawesome-webfont.ttf",
  "/assets/glyphicons-halflings.png",
  "/assets/glyphicons-halflings-white.png"
];

main();

async function main() {
  for (let path of PATHS) {
    const content = await http.fetch(path);
    await files.writeBuild(path, content);
  }
}
