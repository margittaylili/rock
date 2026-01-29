# Frontend Dokumentáció: main.jsx

## Áttekintés
A `main.jsx` fájl a React alkalmazás belépési pontja (entry point). Ez a fájl felelős az alkalmazás inicializálásáért, a React alkalmazás DOM-ba való rendereléséért, és a szükséges szolgáltatások (pl. routing) beállításáért.

## Kód részletes magyarázata

```javascript
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'

import { BrowserRouter } from 'react-router-dom'

import App from './App.jsx'
import "./styles/global.css"

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </StrictMode>,
)
```

### Soronkénti magyarázat:

1. **`import { StrictMode } from 'react'`**
   - A `StrictMode` komponens importálása a React könyvtárból
   - A `StrictMode` egy fejlesztési eszköz, amely segít azonosítani a potenciális problémákat az alkalmazásban
   - **Fontos**: Ez csak fejlesztési módban működik, éles környezetben nem jelentkezik
   - Segít azonosítani:
     - Elavult életciklus metódusokat
     - Biztonsági figyelmeztetéseket
     - Előrejelzett API változásokat

2. **`import { createRoot } from 'react-dom/client'`**
   - A `createRoot` függvény importálása a `react-dom/client` modulból
   - Ez a React 18+ verzió új API-ja a root létrehozásához
   - A `createRoot` egy root objektumot hoz létre, amely lehetővé teszi a React komponensek renderelését
   - **Régi módszer** (React 17 és korábbi): `ReactDOM.render()`
   - **Új módszer** (React 18+): `createRoot()` - ez a jelenlegi kódban használt

3. **`import { BrowserRouter } from 'react-router-dom'`**
   - A `BrowserRouter` komponens importálása a React Router könyvtárból
   - A `BrowserRouter` biztosítja a routing funkcionalitást az alkalmazás számára
   - HTML5 History API-t használ az URL kezeléséhez
   - Ez lehetővé teszi, hogy az URL változzon anélkül, hogy az oldal újratöltődne (SPA - Single Page Application)

4. **`import App from './App.jsx'`**
   - Az `App` komponens importálása
   - Ez a fő alkalmazás komponens, amely tartalmazza az útvonalakat
   - A `./App.jsx` relatív útvonal, ami azt jelenti, hogy ugyanabban a mappában van

5. **`import "./styles/global.css"`**
   - Globális CSS fájl importálása
   - Ez a fájl tartalmazza az alkalmazás szintű stílusokat
   - A CSS fájlok importálása után automatikusan alkalmazódnak az alkalmazásra
   - Például: alapértelmezett betűtípusok, színek, reset stílusok stb.

6. **`createRoot(document.getElementById('root'))`**
   - Root létrehozása a DOM elemhez
   - A `document.getElementById('root')` megkeresi azt a DOM elemet, amelynek az `id` attribútuma `"root"`
   - Ez az elem általában az `index.html` fájlban található:
     ```html
     <div id="root"></div>
     ```
   - A `createRoot()` egy root objektumot ad vissza, amely lehetővé teszi a renderelést

7. **`.render(...)`**
   - A `render` metódus meghívása a root objektumon
   - Ez a metódus rendereli a React komponenseket a DOM-ba
   - A paraméterként megadott JSX lesz az, ami megjelenik a böngészőben

8. **`<StrictMode>`**
   - A `StrictMode` komponens megnyitása
   - Ez egy wrapper komponens, amely nem renderel semmit, csak fejlesztési figyelmeztetéseket ad
   - A benne lévő komponensek fejlesztési módban dupla renderelődnek (csak fejlesztésben!), hogy segítsen azonosítani a problémákat

9. **`<BrowserRouter>`**
   - A `BrowserRouter` komponens megnyitása
   - Ez biztosítja a routing funkcionalitást az alkalmazás számára
   - Minden komponens, amely ezen belül van, hozzáférhet a routing funkciókhoz
   - Fontos: Az `App` komponensben lévő `Routes` és `Route` komponensek csak akkor működnek, ha egy `BrowserRouter`-en belül vannak

10. **`<App />`**
    - Az `App` komponens használata
    - Ez a fő alkalmazás komponens, amely tartalmazza az útvonalakat
    - Ez egy önbezáró tag (self-closing tag)

11. **`</BrowserRouter>`**
    - A `BrowserRouter` komponens bezárása

12. **`</StrictMode>`**
    - A `StrictMode` komponens bezárása

## Hogyan működik az inicializálás?

1. **HTML betöltődik**: A böngésző betölti az `index.html` fájlt
2. **JavaScript fájlok betöltődnek**: A `main.jsx` (vagy lefordítva `main.js`) betöltődik
3. **DOM elem keresése**: A `document.getElementById('root')` megkeresi a root div-et
4. **Root létrehozása**: A `createRoot()` létrehozza a React root-ot
5. **Komponensek renderelése**: A `render()` metódus rendereli a komponenseket
6. **Hierarchia**: A komponensek hierarchiája:
   ```
   StrictMode
     └── BrowserRouter
           └── App
                 └── Routes
                       ├── Route (Kezdolap)
                       ├── Route (Zenekarok)
                       └── Route (Ujegyuttes)
   ```

## Fontos fogalmak

### StrictMode
- Csak fejlesztési módban működik
- Segít azonosítani a problémákat
- Dupla renderelést végez (csak fejlesztésben!)
- Nem befolyásolja az éles alkalmazást

### BrowserRouter
- HTML5 History API-t használ
- Lehetővé teszi az URL változtatását újratöltés nélkül
- Példa URL-ek: `/`, `/zenekarok`, `/hozzaadasEgyuttes`
- Alternatíva: `HashRouter` (használ `#` jelet az URL-ben)

### createRoot (React 18+)
- Új API a React 18-ban
- Jobb teljesítmény, mint a régi `ReactDOM.render()`
- Támogatja a Concurrent Features-t
- Aszinkron renderelést tesz lehetővé

## Példa: index.html struktúra

Az `index.html` fájl általában így néz ki:

```html
<!DOCTYPE html>
<html lang="hu">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Rock Zenekarok</title>
</head>
<body>
  <div id="root"></div>
  <!-- Itt fog megjelenni a React alkalmazás -->
  <script type="module" src="/src/main.jsx"></script>
</body>
</html>
```

## Vite és React

Ez a projekt Vite-t használ build eszközként:
- **Vite**: Modern build eszköz, gyors fejlesztési szerver
- A `main.jsx` fájl Vite által feldolgozva lesz
- Vite támogatja a JSX szintaxist és az ES modulokat
- Fejlesztés közben: `npm run dev` (gyors HMR - Hot Module Replacement)
- Éles build: `npm run build` (optimalizált fájlok)

## Fontos megjegyzések

- A `main.jsx` csak egyszer fut le, amikor az alkalmazás betöltődik
- A `BrowserRouter`-t csak egyszer kell használni, az alkalmazás legfelső szintjén
- A `StrictMode` opcionális, de ajánlott fejlesztés során
- A CSS importálás sorrendje számít: a később importált fájlok felülírhatják az előzőeket

## Hibakeresés

### Gyakori problémák:

1. **"root element not found"**
   - Ellenőrizd, hogy az `index.html`-ben létezik-e a `<div id="root"></div>` elem

2. **Routing nem működik**
   - Ellenőrizd, hogy a `BrowserRouter` megfelelően van-e beállítva
   - Ellenőrizd, hogy a `react-router-dom` telepítve van-e

3. **CSS nem alkalmazódik**
   - Ellenőrizd, hogy a CSS fájl útvonala helyes-e
   - Ellenőrizd, hogy a fájl létezik-e

## További fejlesztési lehetőségek

- [ ] Error Boundary hozzáadása hibakezeléshez
- [ ] Context Provider hozzáadása (pl. Theme, Auth)
- [ ] Service Worker hozzáadása offline működéshez
- [ ] Analytics inicializálása
- [ ] Redux vagy más state management hozzáadása
