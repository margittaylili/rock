import React from 'react';
import "../styles/style.css"
import { Link } from 'react-router-dom';

import Header from '../komponensek/Header';
import UjegyuttesUrlap from '../komponensek/UjegyuttesUrlap';

const Ujegyuttes = () => {
    return (
        <>
            <Header />
            <div className="row">
                <div className="col-12 text-center">
                    <h1>Egy új együttes rögzítése</h1>
                </div>
            </div>
            <UjegyuttesUrlap />
        </>
    );
};

export default Ujegyuttes;