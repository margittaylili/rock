const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const mysql = require('mysql');

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

// 1. ELLENŐRIZD: A jelszó (password) XAMPP esetén gyakran üres string: ""
// Ha a portod biztosan jó, akkor hagyd úgy, ahogy beállítottad.
const adatbazis = mysql.createConnection({
    host: 'localhost',
    port: 3306,          // Ha nálad 3307 vagy más, írd át arra!
    user: 'root',
    password: 'root',    // TIPP: XAMPP-nál ez gyakran csak: ""
    database: 'rock_zenekarok_70s'
});

adatbazis.connect((err) => {
    if (err) {
        console.error('------------------------------------------------');
        console.error('Kritikus hiba az adatbázis kapcsolódásakor!');
        console.error('Hiba kódja:', err.code);
        console.error('Hiba üzenet:', err.sqlMessage);
        console.error('------------------------------------------------');
        return;
    }
    console.log('Sikeresen kapcsolódva az adatbázishoz.');
});

app.get('/api/zenekar', (req, res) => {
    const sql = 'SELECT * FROM zenekarok';
    adatbazis.query(sql, (err, results) => {
        if (err) {
            console.error('Lekérdezési hiba:', err);
            res.status(500).send('Hiba a lekérdezés során');
            return;
        }
        res.json(results);
    });
});

app.post('/api/ujzenekar', (req, res) => {
    // 1. Megnézzük, mit kapunk a Reacttól
    console.log("Beérkező adatok:", req.body); 

    const {nev, stilus_id, orszag, varos, aktiv_evek, tagok, legsikeresebb_album, kep_url } = req.body;
    
    const sql = 'INSERT INTO zenekarok (nev, stilus_id, orszag, varos, aktiv_evek, tagok, legsikeresebb_album, kep_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
    
    adatbazis.query(sql, [nev, stilus_id, orszag, varos, aktiv_evek, tagok, legsikeresebb_album, kep_url], (err, results) => {
        if (err) {
            // 2. Kiírjuk a konkrét SQL hibát!
            console.error("SQL Hiba történt:", err.sqlMessage); 
            console.error("Hiba kód:", err.code);
            res.status(500).send('Adatbázis hiba: ' + err.sqlMessage);
            return;
        }
        res.status(201).json({ id: results.insertId });
    });
});

app.get('/api/stilusok', (req, res) => {
    const sql = 'SELECT stilus_neve, id FROM stilusok';
    adatbazis.query(sql, (err, results) => {
        if (err) {
            console.error('Stílusok lekérdezési hiba:', err);
            res.status(500).send('Hiba a lekérdezés során');
            return;
        }
        res.json(results);
    });
});

app.delete('/api/zenekar/:id', (req, res) => {
    const sql = 'DELETE FROM zenekarok WHERE id = ?';
    adatbazis.query(sql, [req.params.id], (err, results) => {
        if (err) {
            console.error('Törlési hiba:', err);
            res.status(500).send('Hiba a törlés során');
            return;
        }
        res.send('Sikeres törlés');
    });
});

app.listen(port, () => {
    console.log(`Szerver fut a ${port} porton`);
});