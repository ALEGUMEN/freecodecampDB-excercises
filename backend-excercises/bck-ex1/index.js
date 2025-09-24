const express = require("express");
const app = express();

// para usar render
const PORT = process.env.PORT || 3000;

// Ruta principal
app.get("/", (req, res) => {
  res.send("La app está corriendo en Render");
});

// Levantar el servidor
app.listen(PORT, () => {
  console.log(`Servidor escuchando en http://localhost:${PORT}`);
});
