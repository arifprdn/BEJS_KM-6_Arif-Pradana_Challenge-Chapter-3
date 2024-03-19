--membuat database bank
CREATE DATABASE bank;


--membuat enum untuk dipakai di table nasabah
CREATE TYPE JENIS_KELAMIN AS ENUM('pria', 'wanita');

--membuat table nasabah
CREATE TABLE nasabah (
    id BIGSERIAL PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    alamat TEXT,
    tgl_lahir DATE NOT NULL,
    jenis_kelamin JENIS_KELAMIN NOT NULL
);

--membuat table akun
CREATE TABLE akun (
    id BIGSERIAL PRIMARY KEY,
    saldo INT NOT NULL,
    tgl_pembuatan DATE NOT NULL DEFAULT CURRENT_DATE,
    pin VARCHAR(6) NOT NULL,
    id_nasabah BIGINT NOT NULL REFERENCES nasabah(id)
);

--membuat enum untuk dipakai di table transaksi
CREATE TYPE JENIS_TRANSAKSI AS ENUM('deposit', 'withdraw', 'transfer');
CREATE TYPE STATUS AS ENUM('berhasil', 'gagal', 'diproses');

--membuat table transaksi
CREATE TABLE transaksi (
    id BIGSERIAL PRIMARY KEY,
    tgl_transaksi DATE NOT NULL DEFAULT CURRENT_DATE,
    jenis_transaksi JENIS_TRANSAKSI NOT NULL,
    jumlah INT NOT NULL,
    status_transaksi STATUS NOT NULL, 
    catatan VARCHAR(255),
    id_akun BIGINT NOT NULL REFERENCES akun(id)
);

--insert data kedalam table nasabah
INSERT INTO nasabah
    (nama, alamat, tgl_lahir, jenis_kelamin)
VALUES
    ('Arif Pradana','jalan medan jaya','2002-05-31','pria'),
    ('Budi Doremi','jalan horas','2001-03-12','pria'),
    ('Dinda Imoet','jalan hujan deras','1999-08-17','wanita');

--insert data kedalam table akun
INSERT INTO akun
    (saldo, pin, id_nasabah)
VALUES
    (500000, '123321', 1),
    (0, '325098', 2),
    (2000000, '090909', 3);

--insert data kedalam transaksi
INSERT INTO transaksi
    (jenis_transaksi, jumlah, status_transaksi, catatan, id_akun)
VALUES
    ('deposit', 100000, 'berhasil', 'nabung', 1),
    ('transfer', 2000000, 'gagal', '', 2),
    ('withdraw', 500000, 'diproses', '', 3);


--menampilkan isi table
SELECT * FROM nasabah;
SELECT * FROM akun;
SELECT * FROM transaksi;

--mengganti pin pada table akun
UPDATE akun SET pin = '666777' WHERE id=1;

--menghapus data pada table transaksi
DELETE FROM transaksi WHERE id=3;