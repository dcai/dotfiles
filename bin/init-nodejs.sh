#!/bin/bash
# npm init -y

npx mrm gitignore prettier jest eslint
npm i -D @babel/core @babel/eslint-parser babel-jest
npm i -D eslint-config-prettier eslint-plugin-node
npm i -D @babel/preset-env @babel/plugin-transform-modules-commonjs

rm .eslintrc.json

echo "
module.exports = {
  parser: '@babel/eslint-parser',
  parserOptions: {
    sourceType: "module"
  },
  env: {
    commonjs: true,
    jest: true,
    es6: true,
    node: true,
    browser: true,
  },
  extends: ['plugin:node/recommended', 'prettier'],
  rules: {
    'no-undef': 'error',
    'no-unused-vars': 'warn',
    'no-console': 'off',
  },
};" | tee ".eslintrc.js" &>/dev/null

echo '
module.exports = {
  "$schema": "http://json.schemastore.org/prettierrc",
  arrowParens: "always",
  printWidth: 88,
  useTabs: false,
  singleQuote: true,
  tabWidth: 2,
  trailingComma: "all",
  overrides: [
    {
      files: ["*.yaml", "*.yml"],
      options: {
        singleQuote: false,
      },
    },
  ],
};' | tee "prettier.config.js" &>/dev/null

echo '
[*.{js,ts}]
charset = utf-8
indent_style = space
indent_size = 2

[git/config]
indent_style = tab

[Makefile]
indent_style = tab

[*.{json,yaml,yml}]
indent_style = space
indent_size = 2
' | tee ".editorconfig" &>/dev/null
