import mysql from "mysql2";

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "pmo2026api_24sa11a159",
});

db.connect((err) => {
  if (err) {
    console.log("Database gagal terhubung: ", err.message);
  } else {
    console.log("Connected to MySQL database.");
  }
});

export default db;
