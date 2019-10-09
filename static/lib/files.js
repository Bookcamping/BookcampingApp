const util = require("util");
const fs = require("fs");
const { join } = require("path");

const ROOT = join(__dirname, "..", "..");
const STATIC = join(ROOT, "static");
const BUILD = join(ROOT, "build");

const readFile = util.promisify(fs.readFile);
const writeFile = util.promisify(fs.writeFile);

async function readConfig(file) {
  const content = await readFile(join(STATIC, file));
  return content.toString();
}

async function writeBuild(path, file) {
  return writeFile(join(BUILD, path), file);
}

function buildFileExists(file) {
  file = join(BUILD, file);
  return fs.promises
    .access(file, fs.constants.R_OK)
    .then(() => true)
    .catch(() => false);
}

module.exports = {
  ROOT,
  STATIC,
  BUILD,
  readConfig,
  writeBuild,
  buildFileExists
};
