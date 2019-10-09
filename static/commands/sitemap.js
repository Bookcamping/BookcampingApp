const axios = require("axios");
const fs = require("fs");
const path = require("path");

const URL = "http://localhost:3333";

main();

async function main() {
  const response = await axios.get(`${URL}/static/sitemap.txt`);
  fs.writeFileSync(path.join(__dirname, "..", "sitemap.txt"), response.data);
}
