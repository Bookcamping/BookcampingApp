const files = require("../lib/files");

const LIBRARIES = [
  "estanterias",
  "editoras",
  "lo-cultura",
  "LibroMadrid15MccBiblio",
  "antecedentes",
  "espacios",
  "visitas",
  "videoclub",
  "cultura-libre",
  "hacerelfavor",
  "archivos",
  "listas",
  "educacion",
  "ciudad-mundos",
  "Domesticidades",
  "estapasando",
];

main();

async function main() {
  for (const library of LIBRARIES) {
    console.log("library", library);
    const path = `bibliotecas/${library}.html`;
    const content = `<meta http-equiv="Refresh" content="0; url=/${library}">`;
    await files.writeBuild(path, content);
    console.log("done", path);
  }
}
