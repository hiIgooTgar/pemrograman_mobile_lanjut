import express from "express";
import db from "../db.js";
const router = express.Router();

router.get("/", (req, res) => {
  db.query("SELECT * FROM mahasiswa", (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});
router.post("/", (req, res) => {
  const { nim, nama, email, prodi, semester, nomor_hp, alamat, ipk } = req.body;
  const sql = "INSERT INTO mahasiswa (nim, nama, email, prodi, semester, nomor_hp, alamat, ipk) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
  db.query(sql, [nim, nama, email, prodi, semester, nomor_hp, alamat, ipk], (err) => {
    if (err) {
      if (err.code === "ER_DUP_ENTRY") {
        return res.status(409).json({
          error: `NIM '${nim}' sudah terdaftar di database!`
        });
      }
      return res.status(500).json({ error: err.message });
    }
    res.json({ message: "Mahasiswa added successfully" });
  });
});

router.put("/:nim", (req, res) => {
  const { nim } = req.params;
  const { nama, email, prodi, semester, nomor_hp, alamat, ipk } = req.body;
  const sql = "UPDATE mahasiswa SET nama=?, email=?, prodi=?, semester=?, nomor_hp=?, alamat=?, ipk=? WHERE nim=?";
  db.query(sql, [nama, email, prodi, semester, nomor_hp, alamat, ipk, nim], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });

    if (result.affectedRows === 0) return res.status(404).json({ message: "Mahasiswa not found" });
    res.json({ message: "Mahasiswa updated successfully" });
  });
});

router.delete("/:nim", (req, res) => {
  const { nim } = req.params;
  db.query("DELETE FROM mahasiswa WHERE nim = ?", [nim], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });

    if (result.affectedRows === 0) return res.status(404).json({ message: "Mahasiswa not found" });

    res.json({ message: "Mahasiswa deleted successfully" });
  });
});


router.get("/search", (req, res) => {
  const query = req.query.query || "";
  const sql = "SELECT * FROM mahasiswa WHERE nama LIKE ? OR nim LIKE ?";
  const searchValue = `%${query}%`;
  
  db.query(sql, [searchValue, searchValue], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

export default router;