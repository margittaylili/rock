# Frontend Dokumentáció

## Áttekintés
Ez a frontend egy React alapú Single Page Application (SPA), amely egy rock zenekarok kezelő rendszert valósít meg. Az alkalmazás lehetővé teszi a zenekarok listázását, új zenekar hozzáadását és kezelését. A frontend egy REST API-val kommunikál, amely a backend mappában található.

## Technológiai stack
- **React 19**: Modern JavaScript könyvtár felhasználói felületek építéséhez
- **React Router DOM**: Routing (útvonalak kezelése) az alkalmazásban
- **Vite**: Modern build eszköz és fejlesztési szerver
- **Bootstrap 5**: CSS keretrendszer előre definiált komponensekkel
- **Tachyons**: Utility-first CSS keretrendszer
- **Axios**: HTTP kliens az API hívásokhoz

## Projekt struktúra

```
frontend/
├── public/
│   └── rocknroll.png          # Statikus kép fájl
├── src/
│   ├── main.jsx               # Alkalmazás belépési pontja
│   ├── App.jsx                # Fő komponens, routing kezelés
│   ├── komponensek/           # Újrafelhasználható komponensek
│   │   ├── Header.jsx        # Fejléc komponens
│   │   ├── UjegyuttesUrlap.jsx # Új zenekar űrlap komponens
│   │   └── zenekarokLista.jsx # Zenekarok listázó komponens
│   ├── oldalak/              # Oldal komponensek
│   │   ├── Kezdolap.jsx      # Kezdőlap
│   │   ├── Zenekarok.jsx     # Zenekarok listája oldal
│   │   └── Ujegyuttes.jsx    # Új zenekar hozzáadása oldal
│   └── styles/               # CSS stílus fájlok
│       ├── global.css        # Globális stílusok
│       ├── style.css         # Általános stílusok
│       └── zenekarokLista.css # Zenekarok lista specifikus stílusok
├── index.html                # HTML belépési pont
├── package.json              # Projekt konfiguráció és függőségek
├── vite.config.js            # Vite konfiguráció
└── README.md                  # Ez a fájl
```

## Telepítés és futtatás

### Előfeltételek
1. **Node.js** telepítve (ajánlott verzió: 18.x vagy újabb)
2. **npm** vagy **yarn** csomagkezelő
3. **Backend szerver** fut (lásd: `../backend/README.md`)

### Telepítési lépések

1. **Navigálj a frontend könyvtárba**:
   ```bash
   cd frontend
   ```

2. **Telepítsd a függőségeket**:
   ```bash
   npm install
   ```

3. **Indítsd el a fejlesztési szervert**:
   ```bash
   npm run dev
   ```

4. **Nyisd meg a böngészőt**:
   A konzolon megjelenik az URL, általában: `http://localhost:5173`
   Nyisd meg ezt az URL-t a böngészőben.

### Éles build készítése

Éles környezetben való telepítéshez:

```bash
npm run build
```

Ez létrehozza az `dist/` mappát optimalizált fájlokkal, amelyeket egy web szerverre lehet feltölteni.

## Főbb fájlok magyarázata

### main.jsx
Az alkalmazás belépési pontja. Felelős:
- React alkalmazás inicializálása
- DOM-ba való renderelés
- BrowserRouter beállítása routing-hoz
- Globális CSS importálása

**Részletes dokumentáció**: [src/main.jsx.md](./src/main.jsx.md)

### App.jsx
A fő alkalmazás komponens. Felelős:
- Útvonalak (routes) definiálása
- Komponensek importálása
- CSS keretrendszerek betöltése

**Részletes dokumentáció**: [src/App.jsx.md](./src/App.jsx.md)

### Komponensek

#### Header.jsx
Fejléc komponens, amely navigációs menüt tartalmaz.

#### UjegyuttesUrlap.jsx
Űrlap komponens új zenekar hozzáadásához. Tartalmazza:
- Input mezőket az adatok megadásához
- Validációt
- API hívást az új zenekar létrehozásához

#### zenekarokLista.jsx
Komponens a zenekarok listázásához. Megjeleníti:
- Zenekarok listáját kártyák formájában
- Zenekar adatait (név, ország, stílus, stb.)
- Törlés funkciót

### Oldalak

#### Kezdolap.jsx
A kezdőlap komponens, amely az alkalmazás főoldalát jeleníti meg.

#### Zenekarok.jsx
Az oldal, amely a zenekarok listáját jeleníti meg. Használja a `zenekarokLista` komponenst.

#### Ujegyuttes.jsx
Az oldal, amely az új zenekar hozzáadásához szükséges űrlapot tartalmazza. Használja az `UjegyuttesUrlap` komponenst.

## Útvonalak (Routes)

Az alkalmazás a következő útvonalakat támogatja:

| Útvonal | Komponens | Leírás |
|---------|-----------|--------|
| `/` | `Kezdolap` | Kezdőlap, főoldal |
| `/zenekarok` | `Zenekarok` | Zenekarok listája |
| `/hozzaadasEgyuttes` | `Ujegyuttes` | Új zenekar hozzáadása |

## API Kommunikáció

A frontend a következő API végpontokat használja:

### Backend URL
Alapértelmezetten: `http://localhost:3000`

### API Végpontok

1. **GET /api/zenekar**
   - Zenekarok listájának lekérdezése
   - Használat: Zenekarok listázása

2. **POST /api/ujzenekar**
   - Új zenekar hozzáadása
   - Használat: Új zenekar létrehozása az űrlapból

3. **GET /api/stilusok**
   - Stílusok listájának lekérdezése
   - Használat: Legördülő menü feltöltése

4. **DELETE /api/zenekar/:id**
   - Zenekar törlése ID alapján
   - Használat: Zenekar törlése a listából

### Példa API hívás

```javascript
import axios from 'axios';

// Zenekarok lekérdezése
const fetchZenekarok = async () => {
  try {
    const response = await axios.get('http://localhost:3000/api/zenekar');
    return response.data;
  } catch (error) {
    console.error('Hiba a zenekarok lekérdezése során:', error);
    throw error;
  }
};

// Új zenekar hozzáadása
const addZenekar = async (zenekarData) => {
  try {
    const response = await axios.post('http://localhost:3000/api/ujzenekar', zenekarData);
    return response.data;
  } catch (error) {
    console.error('Hiba a zenekar hozzáadása során:', error);
    throw error;
  }
};
```

## Stílusok

Az alkalmazás két CSS keretrendszert használ:

### Bootstrap 5
- Előre definiált komponensek (gombok, kártyák, formok)
- Reszponzív grid rendszer
- Használat: `className="btn btn-primary"`

### Tachyons
- Utility-first megközelítés
- Kis, újrafelhasználható osztályok
- Használat: `className="pa3 ma2 bg-blue"`

### Egyedi CSS fájlok
- `global.css`: Globális stílusok (betűtípusok, színek, reset)
- `style.css`: Általános komponens stílusok
- `zenekarokLista.css`: Zenekarok lista specifikus stílusok

## Fejlesztési parancsok

```bash
# Fejlesztési szerver indítása
npm run dev

# Éles build készítése
npm run build

# Build előnézete
npm run preview

# Kód ellenőrzés (linting)
npm run lint
```

## Hibakeresés

### Gyakori problémák és megoldások

1. **"Cannot connect to API" hiba**
   - Ellenőrizd, hogy fut-e a backend szerver (`http://localhost:3000`)
   - Ellenőrizd a CORS beállításokat a backend-en
   - Ellenőrizd a hálózati kapcsolatot

2. **"Module not found" hiba**
   - Futtasd le: `npm install`
   - Ellenőrizd, hogy a fájl útvonalak helyesek-e

3. **Routing nem működik**
   - Ellenőrizd, hogy a `BrowserRouter` megfelelően van-e beállítva a `main.jsx`-ben
   - Ellenőrizd, hogy a `react-router-dom` telepítve van-e

4. **Stílusok nem alkalmazódnak**
   - Ellenőrizd, hogy a CSS fájlok importálva vannak-e
   - Ellenőrizd a fájl útvonalakat
   - Ellenőrizd a böngésző konzolt CSS hibákért

## További fejlesztési lehetőségek

- [ ] State management hozzáadása (Context API, Redux, Zustand)
- [ ] Form validáció fejlesztése
- [ ] Loading állapotok hozzáadása
- [ ] Hibaüzenetek megjelenítése a felhasználónak
- [ ] Keresési funkció
- [ ] Szűrési lehetőségek (stílus, ország szerint)
- [ ] Pagination (oldalazás) nagy listákhoz
- [ ] Zenekar szerkesztése funkció
- [ ] Képfeltöltés funkció
- [ ] Responsive design fejlesztése
- [ ] Dark mode támogatás
- [ ] Unit tesztek hozzáadása
- [ ] E2E tesztek hozzáadása

## Kapcsolat a backenddel

A frontend a `http://localhost:3000` címen futó backend API-val kommunikál. Fontos, hogy:

1. A backend szerver futjon a frontend indítása előtt
2. A CORS be legyen kapcsolva a backend-en
3. Az API végpontok URL-jei helyesek legyenek

## Hasznos linkek

- [React dokumentáció](https://react.dev/)
- [React Router dokumentáció](https://reactrouter.com/)
- [Vite dokumentáció](https://vitejs.dev/)
- [Bootstrap dokumentáció](https://getbootstrap.com/)
- [Tachyons dokumentáció](https://tachyons.io/)
