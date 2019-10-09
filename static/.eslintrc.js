module.exports = {
  parserOptions: {
    ecmaVersion: 2017
  },
  env: {
    es6: true,
    node: true
  },
  extends: "eslint:recommended",
  rules: {
    // disable rules from base configurations
    "no-console": "off"
  }
};
