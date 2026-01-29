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
