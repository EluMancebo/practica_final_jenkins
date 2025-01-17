const babelParser = require("@babel/eslint-parser");

module.exports = [
  {
    files: ["**/*.js", "**/*.jsx"], // Archivos a analizar
    ignores: ["build/**/*", "node_modules/**/*"], // Archivos/carpeta a excluir
    languageOptions: {
      ecmaVersion: "latest", // Última versión de ECMAScript
      sourceType: "module", // Código moderno de tipo módulo
      parser: babelParser, // Usa @babel/eslint-parser como parser
      parserOptions: {
        requireConfigFile: false, // No necesita archivo de configuración de Babel
        babelOptions: {
          presets: ["@babel/preset-react"], // Soporte para JSX y React
        },
      },
    },
    rules: {
      "react/react-in-jsx-scope": "off", // React 17+ no requiere 'import React'
      "react/prop-types": "off", // Opcional según el proyecto
      "no-unused-expressions": "error",
      "no-mixed-operators": "warn",
      "no-sequences": "warn",
    },
  },
];
