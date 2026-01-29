# API Dokumentáció: GET /api/zenekar

## Áttekintés
Ez az API végpont az összes zenekar adatainak lekérdezésére szolgál az adatbázisból. A kérés egy egyszerű GET kérés, amely nem igényel semmilyen paramétert vagy kérési törzset.

## Kód részletes magyarázata

```javascript
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
```

### Soronkénti magyarázat:

1. **`app.get('/api/zenekar', (req, res) => {`**
   - Ez egy Express.js route handler, amely GET kéréseket kezel
   - Az `/api/zenekar` az útvonal (endpoint), ahová a kérés érkezik
   - A `req` (request) objektum tartalmazza a bejövő kérés adatait
   - A `res` (response) objektum segítségével küldjük vissza a választ

2. **`const sql = 'SELECT * FROM zenekarok';`**
   - SQL lekérdezés létrehozása
   - A `SELECT *` minden oszlopot lekérdez a `zenekarok` táblából
   - Ez a lekérdezés nem tartalmaz WHERE feltételt, ezért az összes rekordot visszaadja

3. **`adatbazis.query(sql, (err, results) => {`**
   - Az adatbázis kapcsolaton keresztül végrehajtjuk az SQL lekérdezést
   - A `query` metódus aszinkron műveletet végez
   - Callback függvényt adunk meg, amely lefut, amikor a lekérdezés befejeződik
   - Az `err` paraméter tartalmazza a hibát, ha történt valami probléma
   - A `results` paraméter tartalmazza a lekérdezés eredményét (a zenekarok tömbjét)

4. **`if (err) {`**
   - Hibakezelés: ellenőrizzük, hogy történt-e hiba a lekérdezés során
   - Ha `err` nem üres (truthy), akkor hiba történt

5. **`console.error('Lekérdezési hiba:', err);`**
   - A hiba részleteit kiírjuk a konzolra
   - Ez segít a fejlesztés során a problémák azonosításában
   - A `console.error` piros színnel jelenik meg a konzolon

6. **`res.status(500).send('Hiba a lekérdezés során');`**
   - HTTP státuszkód beállítása: 500 (Internal Server Error)
   - Ez azt jelenti, hogy szerveroldali hiba történt
   - Visszaküldjük a hibát a kliensnek szöveges formában
   - A `return` biztosítja, hogy a kód ne folytatódjon tovább

7. **`res.json(results);`**
   - Ha nem volt hiba, akkor a lekérdezés eredményét JSON formátumban küldjük vissza
   - A `results` egy tömb, amely tartalmazza az összes zenekar adatait
   - A `res.json()` automatikusan beállítja a megfelelő Content-Type fejlécet (application/json)

## Használat

### Kérés formátuma:
```
GET http://localhost:3000/api/zenekar
```

### Válasz formátuma (sikeres esetben):
```json
[
  {
    "id": 1,
    "nev": "Led Zeppelin",
    "stilus_id": 1,
    "orszag": "Egyesült Királyság",
    "varos": "London",
    "aktiv_evek": "1968-1980",
    "tagok": 4,
    "legsikeresebb_album": "Led Zeppelin IV",
    "kep_url": "https://example.com/ledzeppelin.jpg"
  },
  {
    "id": 2,
    "nev": "Pink Floyd",
    ...
  }
]
```

### Válasz formátuma (hiba esetén):
```
Status: 500 Internal Server Error
Body: "Hiba a lekérdezés során"
```

## Tesztelés

A következő módszerekkel tesztelheted az API-t:

1. **Böngészőben**: Nyisd meg a `http://localhost:3000/api/zenekar` címet
2. **Postman/Thunder Client**: Küldj egy GET kérést az endpointra
3. **cURL parancs**:
   ```bash
   curl http://localhost:3000/api/zenekar
   ```

## Fontos megjegyzések

- Az API nem igényel autentikációt vagy autorizációt
- Az összes zenekar adatait visszaadja, nincs limit vagy oldalazás
- Ha az adatbázis üres, akkor egy üres tömböt (`[]`) ad vissza
- A hibaüzenetek a szerver konzolján is megjelennek, ami segít a hibakeresésben
