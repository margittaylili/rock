# API Dokumentáció: POST /api/ujzenekar

## Áttekintés
Ez az API végpont egy új zenekar hozzáadására szolgál az adatbázishoz. A kérés egy POST kérés, amely JSON formátumban tartalmazza az új zenekar adatait a kérés törzsében (request body).

## Kód részletes magyarázata

```javascript
app.post('/api/ujzenekar', (req, res) => {
    // 1. Megnézzük, mit kapunk a Reacttól
    console.log("Beérkező adatok:", req.body);

    const { nev, stilus_id, orszag, varos, aktiv_evek, tagok, legsikeresebb_album, kep_url } = req.body;

    // 2. Kötelező mezők validálása
    if (!nev || !stilus_id || !orszag || !varos || !aktiv_evek || !tagok || !legsikeresebb_album || !kep_url) {
        return res.status(400).send('Hiányzó kötelező mezők!');
    }

    // 3. Ellenőrizzük, hogy a stilus_id létezik-e
    const checkStyleSql = 'SELECT COUNT(*) AS count FROM stilusok WHERE id = ?';
    adatbazis.query(checkStyleSql, [stilus_id], (err, results) => {
        if (err) {
            console.error("SQL Hiba történt (stilus_id ellenőrzés):", err.sqlMessage);
            return res.status(500).send('Adatbázis hiba történt.');
        }

        if (results[0].count === 0) {
            return res.status(400).send('Érvénytelen stilus_id!');
        }

        // 4. Ha minden rendben, beszúrjuk az új zenekart
        const sql = 'INSERT INTO zenekarok (nev, stilus_id, orszag, varos, aktiv_evek, tagok, legsikeresebb_album, kep_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
        adatbazis.query(sql, [nev, stilus_id, orszag, varos, aktiv_evek, tagok, legsikeresebb_album, kep_url], (err, results) => {
            if (err) {
                console.error("SQL Hiba történt:", err.sqlMessage);
                return res.status(500).send('Adatbázis hiba történt.');
            }
            res.status(201).json({ id: results.insertId });
        });
    });
});
```

### Soronkénti magyarázat:

1. **`app.post('/api/ujzenekar', (req, res) => {`**
   - Ez egy Express.js route handler, amely POST kéréseket kezel
   - Az `/api/ujzenekar` az útvonal (endpoint), ahová a kérés érkezik
   - A `req` (request) objektum tartalmazza a bejövő kérés adatait, beleértve a törzset is
   - A `res` (response) objektum segítségével küldjük vissza a választ

2. **`console.log("Beérkező adatok:", req.body);`**
   - Debug célú kiíratás: megjelenítjük a konzolon, hogy milyen adatokat kaptunk
   - A `req.body` tartalmazza a kérés törzsében küldött JSON adatokat
   - Ez segít a fejlesztés során, hogy lássuk, mit küld a frontend

3. **`const {nev, stilus_id, orszag, varos, aktiv_evek, tagok, legsikeresebb_album, kep_url } = req.body;`**
   - Destructuring (destruktúrálás): kinyerjük az adatokat a `req.body` objektumból
   - Ez egy rövidített írásmód, helyett a következőnek:
     ```javascript
     const nev = req.body.nev;
     const stilus_id = req.body.stilus_id;
     // stb...
     ```
   - Minden változó tartalmazza a megfelelő mező értékét

4. **`const sql = 'INSERT INTO zenekarok (nev, stilus_id, orszag, varos, aktiv_evek, tagok, legsikeresebb_album, kep_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';`**
   - SQL INSERT parancs létrehozása
   - A `INSERT INTO zenekarok` azt jelenti, hogy a `zenekarok` táblába szúrunk be új rekordot
   - A zárójelben felsorolt mezők: `nev, stilus_id, orszag, varos, aktiv_evek, tagok, legsikeresebb_album, kep_url`
   - A `VALUES (?, ?, ?, ?, ?, ?, ?, ?)` részben a `?` karakterek helyőrzők (placeholders)
   - Ezeket a helyőrzőket később töltjük fel az aktuális értékekkel
   - Ez a módszer biztonságos, mert megelőzi az SQL injection támadásokat

5. **`adatbazis.query(sql, [nev, stilus_id, orszag, varos, aktiv_evek, tagok, legsikeresebb_album, kep_url], (err, results) => {`**
   - Az adatbázis kapcsolaton keresztül végrehajtjuk az SQL INSERT parancsot
   - A második paraméter egy tömb, amely tartalmazza az értékeket a helyőrzők sorrendjében
   - Az első `?` helyére kerül a `nev`, a második helyére a `stilus_id`, stb.
   - Callback függvényt adunk meg, amely lefut, amikor az INSERT befejeződik
   - Az `err` paraméter tartalmazza a hibát, ha történt valami probléma
   - A `results` paraméter tartalmazza az INSERT művelet eredményét

6. **`if (err) {`**
   - Hibakezelés: ellenőrizzük, hogy történt-e hiba az INSERT során
   - Lehetséges hibák: duplikált kulcs, hiányzó kötelező mező, rossz adattípus, stb.

7. **`console.error("SQL Hiba történt:", err.sqlMessage);`**
   - A konkrét SQL hibaüzenetet kiírjuk a konzolra
   - Az `err.sqlMessage` tartalmazza az adatbázis által visszaadott hibaüzenetet
   - Ez segít a pontos probléma azonosításában

8. **`console.error("Hiba kód:", err.code);`**
   - A hiba kódját is kiírjuk, amely segít a hiba típusának azonosításában
   - Például: `ER_DUP_ENTRY` (duplikált bejegyzés), `ER_NO_REFERENCED_ROW_2` (külső kulcs hiba), stb.

9. **`res.status(500).send('Adatbázis hiba: ' + err.sqlMessage);`**
   - HTTP státuszkód beállítása: 500 (Internal Server Error)
   - Visszaküldjük a hibát a kliensnek, beleértve az SQL hibaüzenetet is
   - A `return` biztosítja, hogy a kód ne folytatódjon tovább

10. **`res.status(201).json({ id: results.insertId });`**
    - Ha nem volt hiba, akkor sikeres választ küldünk vissza
    - HTTP státuszkód: 201 (Created) - ez a szabványos válasz egy sikeres létrehozáskor
    - A `results.insertId` tartalmazza az újonnan létrehozott rekord ID-ját
    - JSON formátumban küldjük vissza: `{ "id": 5 }` például

## Használat

### Kérés formátuma:
```
POST http://localhost:3000/api/ujzenekar
Content-Type: application/json

{
  "nev": "Led Zeppelin",
  "stilus_id": 1,
  "orszag": "Egyesült Királyság",
  "varos": "London",
  "aktiv_evek": "1968-1980",
  "tagok": 4,
  "legsikeresebb_album": "Led Zeppelin IV",
  "kep_url": "https://example.com/ledzeppelin.jpg"
}
```

### Válasz formátuma (sikeres esetben):
```json
Status: 201 Created
{
  "id": 5
}
```

### Válasz formátuma (hiba esetén):
```
Status: 500 Internal Server Error
Body: "Adatbázis hiba: [konkrét SQL hibaüzenet]"
```

## Kötelező mezők

Az összes mező kötelező, kivéve ha az adatbázisban NULL értéket engedélyeznek:
- `nev` - A zenekar neve (string)
- `stilus_id` - A stílus azonosítója (number)
- `orszag` - Az ország neve (string)
- `varos` - A város neve (string)
- `aktiv_evek` - Az aktív évek (string, pl. "1968-1980")
- `tagok` - A tagok száma (number)
- `legsikeresebb_album` - A legsikeresebb album neve (string)
- `kep_url` - A kép URL-je (string)

## Tesztelés

A következő módszerekkel tesztelheted az API-t:

1. **Postman/Thunder Client**:
   - Módszer: POST
   - URL: `http://localhost:3000/api/ujzenekar`
   - Headers: `Content-Type: application/json`
   - Body (raw JSON):
     ```json
     {
       "nev": "Test Zenekar",
       "stilus_id": 1,
       "orszag": "Magyarország",
       "varos": "Budapest",
       "aktiv_evek": "2020-2024",
       "tagok": 4,
       "legsikeresebb_album": "Test Album",
       "kep_url": "https://example.com/test.jpg"
     }
     ```

2. **cURL parancs**:
   ```bash
   curl -X POST http://localhost:3000/api/ujzenekar \
     -H "Content-Type: application/json" \
     -d '{"nev":"Test Zenekar","stilus_id":1,"orszag":"Magyarország","varos":"Budapest","aktiv_evek":"2020-2024","tagok":4,"legsikeresebb_album":"Test Album","kep_url":"https://example.com/test.jpg"}'
   ```

## Fontos megjegyzések

- Az API nem igényel autentikációt vagy autorizációt
- A `stilus_id`-nak létező ID-nak kell lennie a `stilusok` táblában (külső kulcs kapcsolat)
- Az SQL injection támadások ellen védett a prepared statement használata miatt
- A hibaüzenetek részletesek, ami segít a hibakeresésben
- A sikeres válasz tartalmazza az újonnan létrehozott rekord ID-ját, amit a frontend használhat

/*Fájl célja: Új zenekar hozzáadása az adatbázishoz.

Hibák:
SQL hibaüzenet közvetlen visszaküldése:

A res.status(500).send('Adatbázis hiba: ' + err.sqlMessage); sorban az SQL hibaüzenet közvetlenül visszaküldésre kerül a kliensnek, ami biztonsági kockázatot jelenthet.
Javítás: Általános hibaüzenetet kell küldeni a kliensnek, például: "Adatbázis hiba történt. Kérjük, próbálja újra később."
Kötelező mezők validálása:

A kötelező mezők validálása csak azt ellenőrzi, hogy az értékek léteznek-e, de nem ellenőrzi az adattípusokat vagy a formátumot.
Javítás: Ellenőrizni kell, hogy a mezők megfelelnek-e az elvárt típusoknak (pl. stilus_id szám, kep_url érvényes URL).
stilus_id ellenőrzése:

A stilus_id mező ellenőrzése megtörténik, de a kód nem kezeli azt az esetet, ha az adatbázisban nem létezik a megadott stilus_id.
Javítás: Ha a stilus_id nem létezik, részletesebb hibaüzenetet kell küldeni a kliensnek.
Nem használt mezők:

A tagok mező típusa nem egyértelmű (szám vagy szöveg). A dokumentációban és az adatbázisban is pontosítani kell.
*/