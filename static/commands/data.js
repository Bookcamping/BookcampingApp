const files = require("../lib/files");
const http = require("../lib/http");

main();

async function main() {
  const data = await http.fetch("static/bibliotecas.json");
  await files.writeBuild("data/libraries.json", data);
}
