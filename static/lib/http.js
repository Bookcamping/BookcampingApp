const axios = require("axios");

const SERVER_APP = "http://localhost:3333";

async function fetch(url) {
  const response = await axios.get(`${SERVER_APP}/${url}`);
  return response.data;
}

module.exports = { fetch };
