# Backend API Dokumentáció

## Áttekintés
Ez a backend egy Express.js alapú REST API, amely egy MySQL adatbázissal kommunikál. Az API egy rock zenekarok adatbázisát kezeli, lehetővé teszi a zenekarok listázását, új zenekar hozzáadását, stílusok lekérdezését és zenekarok törlését.

## Technológiai stack
- **Node.js**: JavaScript futási környezet
- **Express.js**: Web framework Node.js-hez
- **MySQL**: Relációs adatbázis
- **mysql**: MySQL adatbázis kapcsolódáshoz szükséges csomag
- **cors**: Cross-Origin Resource Sharing engedélyezése
- **body-parser**: HTTP kérés törzsének feldolgozása

## Telepítés és futtatás

### Előfeltételek
1. **Node.js** telepítve (ajánlott verzió: 14.x vagy újabb)
2. **MySQL** adatbázis szerver fut (pl. XAMPP, WAMP, vagy önálló MySQL szerver)
3. Az adatbázis létrehozva és a táblák inicializálva (lásd: `rock_zenekarok_70s.sql`)

### Telepítési lépések

1. **Navigálj a backend könyvtárba**:
   ```bash
   cd backend
   ```

2. **Telepítsd a függőségeket**:
   ```bash
   npm install
   ```

3. **Állítsd be az adatbázis kapcsolatot**:
   Nyisd meg az `index.js` fájlt és módosítsd az adatbázis beállításokat:
   ```javascript
   const adatbazis = mysql.createConnection({
       host: 'localhost',
       port: 3306,          // Változtasd meg, ha más portot használsz
       user: 'root',        // Változtasd meg, ha más felhasználónevet használsz
       password: 'root',    // XAMPP esetén gyakran üres string: ""
       database: 'rock_zenekarok_70s'
   });
   ```

4. **Indítsd el a szervert**:
   ```bash
   node index.js
   ```

5. **Ellenőrizd, hogy fut-e**:
   A konzolon meg kell jelennie:
   ```
   Sikeresen kapcsolódva az adatbázishoz.
   Szerver fut a 3000 porton
   ```

## API Végpontok

### 1. GET /api/zenekar
Az összes zenekar lekérdezése.

**Kérés**: `GET http://localhost:3000/api/zenekar`

**Válasz**: JSON tömb az összes zenekarral

**Részletes dokumentáció**: [api-zenekar.md](./api-zenekar.md)

---

### 2. POST /api/ujzenekar
Új zenekar hozzáadása az adatbázishoz.

**Kérés**: `POST http://localhost:3000/api/ujzenekar`
```json
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

**Válasz**: `{ "id": 5 }` (az újonnan létrehozott rekord ID-ja)

**Részletes dokumentáció**: [api-ujzenekar.md](./api-ujzenekar.md)

---

### 3. GET /api/stilusok
Az összes elérhető zenei stílus lekérdezése.

**Kérés**: `GET http://localhost:3000/api/stilusok`

**Válasz**: JSON tömb a stílusokkal (id és stilus_neve)

**Részletes dokumentáció**: [api-stilusok.md](./api-stilusok.md)

---

### 4. DELETE /api/zenekar/:id
Zenekar törlése ID alapján.

**Kérés**: `DELETE http://localhost:3000/api/zenekar/5`

**Válasz**: `"Sikeres törlés"`

**Részletes dokumentáció**: [api-zenekar-id.md](./api-zenekar-id.md)

## Projekt struktúra

```
backend/
├── index.js                 # Fő szerver fájl, tartalmazza az összes API végpontot
├── package.json            # Node.js projekt konfiguráció és függőségek
├── package-lock.json       # Pontos függőség verziók
├── rock_zenekarok_70s.sql  # Adatbázis séma és inicializáló script
├── README.md               # Ez a fájl
├── api-zenekar.md          # GET /api/zenekar részletes dokumentációja
├── api-ujzenekar.md        # POST /api/ujzenekar részletes dokumentációja
├── api-stilusok.md         # GET /api/stilusok részletes dokumentációja
└── api-zenekar-id.md       # DELETE /api/zenekar/:id részletes dokumentációja
```

## Főbb fájlok magyarázata

### index.js
Ez a fő szerver fájl, amely tartalmazza:
- Express.js alkalmazás inicializálása
- Middleware beállítások (CORS, body-parser)
- MySQL adatbázis kapcsolat létrehozása
- Minden API végpont definíciója
- Szerver indítása a 3000-es porton

### package.json
A projekt konfigurációs fájlja, amely tartalmazza:
- Projekt neve és verziója
- Függőségek listája (dependencies)
- Script parancsok (ha vannak)

## Hibakeresés

### Gyakori problémák és megoldások

1. **"Cannot connect to database" hiba**
   - Ellenőrizd, hogy fut-e a MySQL szerver
   - Ellenőrizd az adatbázis beállításokat (host, port, user, password)
   - XAMPP esetén gyakran a jelszó üres string: `""`

2. **"Table doesn't exist" hiba**
   - Futtasd le az `rock_zenekarok_70s.sql` fájlt az adatbázisban
   - Ellenőrizd, hogy a megfelelő adatbázis van kiválasztva

3. **Port már használatban**
   - Változtasd meg a portot az `index.js` fájlban
   - Vagy állítsd le a másik alkalmazást, amely használja a 3000-es portot

4. **CORS hiba a frontendből**
   - Ellenőrizd, hogy a `app.use(cors());` sor szerepel az `index.js`-ben
   - Telepítve van-e a `cors` csomag: `npm install cors`

## Biztonsági megjegyzések

⚠️ **Fontos**: Ez egy fejlesztési/oktatási projekt. Éles környezetben a következőket javasoljuk:

1. **Autentikáció és autorizáció**: Jelenleg bárki hozzáférhet az API-hoz
2. **Adatbázis jelszó**: Ne használj gyenge jelszavakat éles környezetben
3. **SQL injection védelem**: A jelenlegi kód prepared statement-eket használ, ami jó
4. **Input validáció**: Adjon hozzá validációt a bejövő adatokhoz
5. **Hibakezelés**: Ne küldj vissza részletes hibákat a kliensnek éles környezetben

## További fejlesztési lehetőségek

- [ ] PUT/PATCH végpont zenekar frissítéséhez
- [ ] Keresési funkció (név, stílus szerint)
- [ ] Oldalazás (pagination) a nagy listákhoz
- [ ] Autentikáció (JWT token)
- [ ] Képfeltöltés funkció
- [ ] API dokumentáció (Swagger/OpenAPI)
- [ ] Unit tesztek
- [ ] Logolás rendszer

## Kapcsolat a frontenddel

A backend a `http://localhost:3000` címen fut, és a frontend ezt az URL-t használja az API hívásokhoz. A CORS be van kapcsolva, így a frontend (általában `http://localhost:5173` vagy hasonló) hozzáférhet az API-hoz.

## Hasznos linkek

- [Express.js dokumentáció](https://expressjs.com/)
- [MySQL Node.js dokumentáció](https://github.com/mysqljs/mysql)
- [Node.js dokumentáció](https://nodejs.org/)
