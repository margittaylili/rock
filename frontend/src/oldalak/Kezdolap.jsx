import React from 'react';
import "../styles/style.css"
import { Link } from 'react-router-dom';

import Header from '../komponensek/Header';

const Kezdolap = () => {
    return (
        <>
            <Header />
            <div className="start">
                <h1>A rock zene nagy csapatai</h1>
                <div className="row">
                <div className="col-6 flex justify-content-center">
                    <Link class="btn btn-primary" to="/zenekarok">Együttesek adatai</Link>
                </div>
                <div className="col-6 flex justify-content-center">
                    <Link class="btn btn-primary" to="/hozzaadasEgyuttes">Együttesek adatainak feltöltése</Link>
                </div>
            </div>
            </div>
            
        </>
    );
};

export default Kezdolap;