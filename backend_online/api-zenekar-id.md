# API Dokumentáció: DELETE /api/zenekar/:id

## Áttekintés
Ez az API végpont egy zenekar törlésére szolgál az adatbázisból az ID alapján. A kérés egy DELETE kérés, amely az URL-ben tartalmazza a törlendő zenekar azonosítóját (ID) paraméterként.

## Kód részletes magyarázata

```javascript
app.delete('/api/zenekar/:id', (req, res) => {
    const id = req.params.id;

    // 1. Ellenőrizzük, hogy az ID létezik-e
    const checkSql = 'SELECT COUNT(*) AS count FROM zenekarok WHERE id = ?';
    adatbazis.query(checkSql, [id], (err, results) => {
        if (err) {
            console.error('SQL Hiba (ellenőrzés):', err.sqlMessage);
            return res.status(500).send('Adatbázis hiba történt.');
        }

        if (results[0].count === 0) {
            return res.status(404).send('A megadott ID-val nem található zenekar.');
        }

        // 2. Ha az ID létezik, töröljük a rekordot
        const deleteSql = 'DELETE FROM zenekarok WHERE id = ?';
        adatbazis.query(deleteSql, [id], (err, results) => {
            if (err) {
                console.error('Törlési hiba:', err.sqlMessage);
                return res.status(500).send('Hiba a törlés során.');
            }

            if (results.affectedRows === 0) {
                return res.status(404).send('A megadott ID-val nem található zenekar.');
            }

            res.status(200).send('Sikeres törlés.');
        });
    });
});
```

### Soronkénti magyarázat:

1. **`app.delete('/api/zenekar/:id', (req, res) => {`**
   - Ez egy Express.js route handler, amely DELETE kéréseket kezel
   - Az `/api/zenekar/:id` az útvonal (endpoint), ahol a `:id` egy dinamikus paraméter
   - A `:id` azt jelenti, hogy az URL-ben szereplő érték bekerül az `id` változóba
   - Például: `/api/zenekar/5` esetén az `id` értéke `5` lesz
   - A `req` (request) objektum tartalmazza a bejövő kérés adatait, beleértve a paramétereket is
   - A `res` (response) objektum segítségével küldjük vissza a választ

2. **`const sql = 'DELETE FROM zenekarok WHERE id = ?';`**
   - SQL DELETE parancs létrehozása
   - A `DELETE FROM zenekarok` azt jelenti, hogy a `zenekarok` táblából törlünk rekordokat
   - A `WHERE id = ?` feltétel azt mondja meg, hogy melyik rekordot töröljük
   - A `?` egy helyőrző (placeholder), amelyet később töltünk fel az aktuális ID értékkel
   - Ez a módszer biztonságos, mert megelőzi az SQL injection támadásokat
   - Fontos: ha nincs WHERE feltétel, akkor az ÖSSZES rekord törlődne! Ezért kritikus a WHERE használata

3. **`adatbazis.query(sql, [req.params.id], (err, results) => {`**
   - Az adatbázis kapcsolaton keresztül végrehajtjuk az SQL DELETE parancsot
   - A második paraméter egy tömb: `[req.params.id]`
   - Az `req.params.id` tartalmazza az URL-ből kinyert ID értéket
   - Például: ha az URL `/api/zenekar/5`, akkor `req.params.id` értéke `"5"` (string)
   - Ez az érték kerül be a `?` helyére az SQL parancsban
   - Callback függvényt adunk meg, amely lefut, amikor a DELETE befejeződik
   - Az `err` paraméter tartalmazza a hibát, ha történt valami probléma
   - A `results` paraméter tartalmazza a DELETE művelet eredményét (pl. hány sor érintett)

4. **`if (err) {`**
   - Hibakezelés: ellenőrizzük, hogy történt-e hiba a törlés során
   - Ha `err` nem üres (truthy), akkor hiba történt
   - Lehetséges hibák: adatbázis kapcsolat megszakadt, rekord nem létezik, külső kulcs korlátozás, stb.

5. **`console.error('Törlési hiba:', err);`**
   - A hiba részleteit kiírjuk a konzolra
   - A `console.error` piros színnel jelenik meg a konzolon
   - Ez segít a fejlesztés során a problémák azonosításában
   - A hiba objektum tartalmazza a részletes információkat (hibaüzenet, kód, stb.)

6. **`res.status(500).send('Hiba a törlés során');`**
   - HTTP státuszkód beállítása: 500 (Internal Server Error)
   - Ez azt jelenti, hogy szerveroldali hiba történt
   - Visszaküldjük a hibát a kliensnek szöveges formában
   - A `return` biztosítja, hogy a kód ne folytatódjon tovább, ne próbáljon sikeres választ küldeni

7. **`res.send('Sikeres törlés');`**
   - Ha nem volt hiba, akkor sikeres választ küldünk vissza
   - A `res.send()` szöveges választ küld (nem JSON-t)
   - HTTP státuszkód: 200 (OK) - ez az alapértelmezett sikeres válasz
   - A válasz üzenet: "Sikeres törlés"

## Használat

### Kérés formátuma:
```
DELETE http://localhost:3000/api/zenekar/5
```
Ahol a `5` a törlendő zenekar ID-ja.

### Válasz formátuma (sikeres esetben):
```
Status: 200 OK
Body: "Sikeres törlés"
```

### Válasz formátuma (hiba esetén):
```
Status: 500 Internal Server Error
Body: "Hiba a törlés során"
```

## Paraméterek

- **`:id`** (URL paraméter, kötelező)
  - Típus: szám (number) vagy számként értelmezhető string
  - Leírás: A törlendő zenekar egyedi azonosítója (ID)
  - Példa: `/api/zenekar/5` esetén az ID értéke `5`

## Tesztelés

A következő módszerekkel tesztelheted az API-t:

1. **Postman/Thunder Client**:
   - Módszer: DELETE
   - URL: `http://localhost:3000/api/zenekar/5` (ahol 5 a törlendő zenekar ID-ja)

2. **cURL parancs**:
   ```bash
   curl -X DELETE http://localhost:3000/api/zenekar/5
   ```

3. **JavaScript fetch**:
   ```javascript
   fetch('http://localhost:3000/api/zenekar/5', {
     method: 'DELETE'
   })
   .then(response => response.text())
   .then(data => console.log(data));
   ```

## Fontos megjegyzések

- Az API nem igényel autentikációt vagy autorizációt
- Az SQL injection támadások ellen védett a prepared statement használata miatt
- Ha a megadott ID-val nem létezik zenekar, a DELETE művelet nem okoz hibát, de nem töröl semmit
- A `results.affectedRows` tartalmazza, hogy hány sor volt érintett (0 vagy 1)
- Ha más táblákban vannak kapcsolódó rekordok (külső kulcsok), előfordulhat, hogy az adatbázis nem engedi a törlést
- A hibaüzenetek a szerver konzolján is megjelennek, ami segít a hibakeresésben

## Biztonsági megfontolások

- **Jelenleg nincs autentikáció**: Bárki törölhet zenekarokat, ha ismeri az ID-t
- **Javasolt fejlesztések**:
  - Autentikáció hozzáadása (pl. JWT token)
  - Autorizáció ellenőrzése (csak admin törölhet)
  - Validáció: ellenőrizni, hogy létezik-e a rekord a törlés előtt
  - Soft delete: ne töröljük fizikailag, csak jelöljük meg töröltként

## Példa használat frontendből

```javascript
// React komponensben
const handleDelete = async (id) => {
  try {
    const response = await fetch(`http://localhost:3000/api/zenekar/${id}`, {
      method: 'DELETE'
    });
    
    if (response.ok) {
      alert('Zenekar sikeresen törölve!');
      // Frissítsd a listát
      loadZenekarok();
    } else {
      alert('Hiba történt a törlés során!');
    }
  } catch (error) {
    console.error('Hiba:', error);
    alert('Hiba történt a törlés során!');
  }
}; /*

Fájl célja: Zenekar törlése az adatbázisból az ID alapján.

Hibák:
Nem ellenőrzi, hogy az ID létezik-e a törlés előtt:

A kód nem ellenőrzi, hogy a megadott ID-val létezik-e rekord a zenekarok táblában.
Javítás: A törlés előtt ellenőrizni kell, hogy az ID létezik-e. Ha nem, akkor 404-es státuszkóddal kell visszatérni.
Hibakezelés általánossága:

A hibakezelés során a kliensnek küldött hibaüzenet nem részletezi, hogy miért történt a hiba.
Javítás: A hibakezelést részletesebbé kell tenni, például: "A megadott ID-val nem található zenekar."
SQL injection elleni védelem:

Bár a prepared statement használata biztonságos, érdemes megemlíteni, hogy az ID-t validálni kell (pl. szám-e).
*/