CREATE DATABASE pmo2026api_24sa11a159;
USE pmo2026api_24sa11a159;

CREATE TABLE mahasiswa (
	nim VARCHAR(10) NOT NULL PRIMARY KEY,
	nama VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	prodi VARCHAR(128) NOT NULL,
	semester INT NOT NULL,
	nomor_hp VARCHAR(32) NOT NULL,
	alamat VARCHAR(255) NOT NULL,
	ipk DECIMAL(3, 2) NOT NULL
);

INSERT INTO mahasiswa (nim, nama, email, prodi, semester, nomor_hp, alamat, ipk) VALUES
('220101', 'Ahmad Dahlan (Server API)', 'ahmad@kampus.ac.id', 'Informatika', 5, '089287848374', 'Banyumas', 3.85),
('220102', 'Siti Nurhaliza (Server API)', 'siti@kampus.ac.id', 'Sistem Informasi', 5, '089128712733', 'Banyumas', 3.90);

SELECT * FROM mahasiswa

ON DUPLICATE KEY UPDATE nama = VALUES(nama);