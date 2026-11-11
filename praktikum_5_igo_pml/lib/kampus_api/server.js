import express from "express";
import bodyParser from "body-parser";
import cors from "cors";
import mahasiswaRoutes from "./routes/mahasiswa.js";

const app = express();
const PORT = 3000;

app.use(cors());
app.use(bodyParser.json());
app.use("/api/mahasiswa", mahasiswaRoutes);
app.get("/", (req, res) => {
    res.send("RESTful API Mahasiswa Pertemuan 05 berjalan ");
});
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});