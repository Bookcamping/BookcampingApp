const files = require("../lib/files");
const http = require("../lib/http");

main();

function wait() {
  return new Promise((accept) => setTimeout(accept, 500));
}

function shouldProcess(line) {
  return line.startsWith("- [ ]");
}

async function main() {
  const sitemap = await files.readConfig("sitemap.txt");
  const lines = sitemap.split("\n").map((n) => n.trim());

  for (let line of lines) {
    if (shouldProcess(line)) {
      try {
        // console.log("PROCESS", line);
        const url = line.slice(line.indexOf("/") + 1);
        const filename = url.length ? `${url}.html` : "index.html";
        const isCached = await files.buildFileExists(filename);
        if (!isCached) {
          console.log("FETCHING", url);
          await http.fetch(url);
          // console.log("DONE", url);
          // await wait();
        }
      } catch (err) {
        console.error("ERROR", line, err);
      }
    }
  }
  console.log("Done.");
}
