# API Dokumentáció: GET /api/stilusok

## Áttekintés
Ez az API végpont az összes elérhető zenei stílus (műfaj) lekérdezésére szolgál az adatbázisból. A kérés egy egyszerű GET kérés, amely nem igényel semmilyen paramétert vagy kérési törzset. Ez az endpoint általában a frontend számára szolgál, hogy betöltse a stílusok listáját egy legördülő menübe vagy választó mezőbe.

## Kód részletes magyarázata

```javascript
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
```

### Soronkénti magyarázat:

1. **`app.get('/api/stilusok', (req, res) => {`**
   - Ez egy Express.js route handler, amely GET kéréseket kezel
   - Az `/api/stilusok` az útvonal (endpoint), ahová a kérés érkezik
   - A `req` (request) objektum tartalmazza a bejövő kérés adatait
   - A `res` (response) objektum segítségével küldjük vissza a választ

2. **`const sql = 'SELECT stilus_neve, id FROM stilusok';`**
   - SQL lekérdezés létrehozása
   - A `SELECT stilus_neve, id` csak két oszlopot kérdez le: a stílus nevét és az ID-ját
   - Ez hatékonyabb, mint a `SELECT *`, mert csak a szükséges adatokat kéri le
   - A `FROM stilusok` azt jelenti, hogy a `stilusok` táblából kérdezzük le az adatokat
   - Ez a lekérdezés nem tartalmaz WHERE feltételt, ezért az összes stílust visszaadja

3. **`adatbazis.query(sql, (err, results) => {`**
   - Az adatbázis kapcsolaton keresztül végrehajtjuk az SQL lekérdezést
   - A `query` metódus aszinkron műveletet végez
   - Callback függvényt adunk meg, amely lefut, amikor a lekérdezés befejeződik
   - Az `err` paraméter tartalmazza a hibát, ha történt valami probléma
   - A `results` paraméter tartalmazza a lekérdezés eredményét (a stílusok tömbjét)

4. **`if (err) {`**
   - Hibakezelés: ellenőrizzük, hogy történt-e hiba a lekérdezés során
   - Ha `err` nem üres (truthy), akkor hiba történt
   - Lehetséges hibák: adatbázis kapcsolat megszakadt, tábla nem létezik, stb.

5. **`console.error('Stílusok lekérdezési hiba:', err);`**
   - A hiba részleteit kiírjuk a konzolra
   - A `console.error` piros színnel jelenik meg a konzolon
   - Ez segít a fejlesztés során a problémák azonosításában
   - A hiba objektum tartalmazza a részletes információkat (hibaüzenet, kód, stb.)

6. **`res.status(500).send('Hiba a lekérdezés során');`**
   - HTTP státuszkód beállítása: 500 (Internal Server Error)
   - Ez azt jelenti, hogy szerveroldali hiba történt
   - Visszaküldjük a hibát a kliensnek szöveges formában
   - A `return` biztosítja, hogy a kód ne folytatódjon tovább, ne próbáljon sikeres választ küldeni

7. **`res.json(results);`**
   - Ha nem volt hiba, akkor a lekérdezés eredményét JSON formátumban küldjük vissza
   - A `results` egy tömb, amely tartalmazza az összes stílus adatait
   - Minden elem tartalmazza a `stilus_neve` és `id` mezőket
   - A `res.json()` automatikusan beállítja a megfelelő Content-Type fejlécet (application/json)

## Használat

### Kérés formátuma:
```
GET http://localhost:3000/api/stilusok
```

### Válasz formátuma (sikeres esetben):
```json
[
  {
    "id": 1,
    "stilus_neve": "Hard Rock"
  },
  {
    "id": 2,
    "stilus_neve": "Progressive Rock"
  },
  {
    "id": 3,
    "stilus_neve": "Psychedelic Rock"
  }
]
```

### Válasz formátuma (hiba esetén):
```
Status: 500 Internal Server Error
Body: "Hiba a lekérdezés során"
```

## Használati esetek

Ez az API végpont általában a következő helyzetekben használatos:

1. **Új zenekar hozzáadása**: A frontend betölti a stílusok listáját, hogy a felhasználó kiválaszthassa a zenekar stílusát
2. **Szűrés**: A felhasználók stílus szerint szűrhetik a zenekarokat
3. **Statisztikák**: Megjeleníthető, hogy hány zenekar tartozik az egyes stílusokhoz

## Tesztelés

A következő módszerekkel tesztelheted az API-t:

1. **Böngészőben**: Nyisd meg a `http://localhost:3000/api/stilusok` címet
2. **Postman/Thunder Client**: Küldj egy GET kérést az endpointra
3. **cURL parancs**:
   ```bash
   curl http://localhost:3000/api/stilusok
   ```

## Fontos megjegyzések

- Az API nem igényel autentikációt vagy autorizációt
- Az összes stílust visszaadja, nincs limit vagy oldalazás
- Ha az adatbázis üres, akkor egy üres tömböt (`[]`) ad vissza
- A válasz csak a stílus nevét és ID-ját tartalmazza, nem minden mezőt
- Ez optimalizált lekérdezés, mert csak a szükséges adatokat kéri le
- A hibaüzenetek a szerver konzolján is megjelennek, ami segít a hibakeresésben

## Kapcsolat más API-kkal

Ez az endpoint gyakran használatos az `/api/ujzenekar` endpointtal együtt:
- A frontend először lekéri a stílusok listáját (`/api/stilusok`)
- Majd ezt a listát használja egy legördülő menüben vagy választó mezőben
- Amikor a felhasználó új zenekart ad hozzá, a kiválasztott `stilus_id`-t küldi el az `/api/ujzenekar` endpointnak
