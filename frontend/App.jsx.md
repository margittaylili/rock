# Frontend Dokumentáció: App.jsx

## Áttekintés
Az `App.jsx` fájl a React alkalmazás fő komponense, amely felelős az útvonalak (routes) kezeléséért. Ez a fájl határozza meg, hogy melyik komponens jelenjen meg, amikor a felhasználó egy bizonyos URL-re navigál az alkalmazásban.

## Kód részletes magyarázata

```javascript
import { useState } from 'react'
import { Route } from 'react-router-dom'
import { Routes } from 'react-router-dom'

import Kezdolap from './oldalak/Kezdolap.jsx'
import Zenekarok from './oldalak/Zenekarok.jsx'
import Ujegyuttes from './oldalak/Ujegyuttes.jsx'

import "tachyons/css/tachyons.min.css"
import "bootstrap/dist/css/bootstrap.min.css"

function App() {
  return (
    <Routes>
      <Route path="/" element={<Kezdolap/>} />
      <Route path="/zenekarok" element={<Zenekarok/>} />
      <Route path="/hozzaadasEgyuttes" element={<Ujegyuttes/>} />
    </Routes>
  )
}

export default App
```

### Soronkénti magyarázat:

1. **`import { useState } from 'react'`**
   - React hook importálása
   - A `useState` lehetővé teszi állapot (state) kezelését a komponensekben
   - **Megjegyzés**: Ebben a fájlban jelenleg nem használjuk, de lehet, hogy később szükség lesz rá

2. **`import { Route } from 'react-router-dom'`**
   - A `Route` komponens importálása a React Router könyvtárból
   - A `Route` komponens egy útvonalat (route) definiál
   - Ez mondja meg, hogy melyik komponens jelenjen meg egy adott URL-nél

3. **`import { Routes } from 'react-router-dom'`**
   - A `Routes` komponens importálása
   - A `Routes` egy konténer, amely tartalmazza az összes `Route` komponenst
   - Ez biztosítja, hogy csak egy útvonal legyen aktív egyszerre

4. **`import Kezdolap from './oldalak/Kezdolap.jsx'`**
   - A `Kezdolap` komponens importálása
   - Ez a kezdőlap komponens, amely a főoldalt jeleníti meg
   - A `./oldalak/` azt jelenti, hogy az `oldalak` mappában található a fájl

5. **`import Zenekarok from './oldalak/Zenekarok.jsx'`**
   - A `Zenekarok` komponens importálása
   - Ez a komponens jeleníti meg a zenekarok listáját

6. **`import Ujegyuttes from './oldalak/Ujegyuttes.jsx'`**
   - Az `Ujegyuttes` komponens importálása
   - Ez a komponens tartalmazza az új zenekar hozzáadásához szükséges űrlapot

7. **`import "tachyons/css/tachyons.min.css"`**
   - Tachyons CSS keretrendszer importálása
   - A Tachyons egy utility-first CSS keretrendszer
   - Utility-first azt jelenti, hogy kis, újrafelhasználható CSS osztályokat használunk
   - Például: `className="pa3 ma2 bg-blue"` (padding, margin, háttérszín)

8. **`import "bootstrap/dist/css/bootstrap.min.css"`**
   - Bootstrap CSS keretrendszer importálása
   - A Bootstrap egy népszerű CSS keretrendszer, amely előre definiált stílusokat és komponenseket biztosít
   - Például: gombok, kártyák, navigációs sávok stb.

9. **`function App() {`**
   - A `App` komponens definíciója
   - Ez egy funkcionális komponens (function component)
   - A React 16.8+ verzió óta a funkcionális komponensek is használhatnak hook-okat

10. **`return (`**
    - A komponens visszatérési értéke
    - A `return` után JSX (JavaScript XML) következik, ami HTML-hez hasonló szintaxis

11. **`<Routes>`**
    - A `Routes` komponens megnyitása
    - Ez egy konténer az összes útvonal számára
    - A React Router ezt használja az útvonalak kezeléséhez

12. **`<Route path="/" element={<Kezdolap/>} />`**
    - Első útvonal definíciója
    - A `path="/"` azt jelenti, hogy ez az útvonal akkor aktív, amikor a felhasználó a gyökér URL-re navigál (pl. `http://localhost:5173/`)
    - Az `element={<Kezdolap/>}` azt mondja meg, hogy a `Kezdolap` komponens jelenjen meg ezen az útvonalon
    - Ez egy önbezáró tag (self-closing tag), mert nincs benne tartalom

13. **`<Route path="/zenekarok" element={<Zenekarok/>} />`**
    - Második útvonal definíciója
    - A `path="/zenekarok"` azt jelenti, hogy ez az útvonal akkor aktív, amikor a felhasználó a `/zenekarok` URL-re navigál
    - Az `element={<Zenekarok/>}` azt mondja meg, hogy a `Zenekarok` komponens jelenjen meg

14. **`<Route path="/hozzaadasEgyuttes" element={<Ujegyuttes/>} />`**
    - Harmadik útvonal definíciója
    - A `path="/hozzaadasEgyuttes"` azt jelenti, hogy ez az útvonal akkor aktív, amikor a felhasználó a `/hozzaadasEgyuttes` URL-re navigál
    - Az `element={<Ujegyuttes/>}` azt mondja meg, hogy az `Ujegyuttes` komponens jelenjen meg

15. **`</Routes>`**
    - A `Routes` komponens bezárása

16. **`export default App`**
    - A komponens exportálása
    - A `default` kulcsszó azt jelenti, hogy ez az alapértelmezett export
    - Más fájlokban így importálhatjuk: `import App from './App.jsx'`

## Útvonalak (Routes) összefoglalása

| Útvonal (Path) | Komponens | Leírás |
|----------------|-----------|--------|
| `/` | `Kezdolap` | Kezdőlap, főoldal |
| `/zenekarok` | `Zenekarok` | Zenekarok listája |
| `/hozzaadasEgyuttes` | `Ujegyuttes` | Új zenekar hozzáadása |

## Hogyan működik a routing?

1. **Felhasználó navigál**: A felhasználó megnyitja az alkalmazást vagy egy linkre kattint
2. **URL változik**: A böngésző URL-je változik (pl. `/zenekarok`)
3. **React Router ellenőrzi**: A React Router ellenőrzi, hogy melyik `Route` komponens `path` attribútuma egyezik meg az aktuális URL-lel
4. **Komponens renderelődik**: A megtalált `Route` `element` prop-jában lévő komponens renderelődik
5. **Megjelenik**: A komponens megjelenik a felhasználó számára

## Példa navigációra

```javascript
// Egy másik komponensben navigálás
import { useNavigate } from 'react-router-dom';

function MyComponent() {
  const navigate = useNavigate();
  
  const goToZenekarok = () => {
    navigate('/zenekarok'); // Navigálás a /zenekarok útvonalra
  };
  
  return <button onClick={goToZenekarok}>Zenekarok</button>;
}
```

## Fontos megjegyzések

- A `Routes` komponens csak akkor működik, ha az alkalmazás egy `BrowserRouter` komponensben van becsomagolva (ez a `main.jsx`-ben történik)
- A `path` attribútumok pontos egyezést követelnek meg (kivéve, ha wildcard-okat használunk)
- A komponensek csak akkor renderelődnek, amikor az útvonal aktív
- A CSS keretrendszerek (Tachyons, Bootstrap) globálisan elérhetőek lesznek az összes komponensben

## További fejlesztési lehetőségek

- [ ] 404 oldal hozzáadása (nem található útvonal esetén)
- [ ] Védett útvonalak (autentikáció szükséges)
- [ ] Navigációs menü komponens
- [ ] Breadcrumb navigáció
- [ ] URL paraméterek használata (pl. `/zenekarok/:id`)
