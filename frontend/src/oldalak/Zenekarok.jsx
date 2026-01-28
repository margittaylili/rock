import React from 'react';
import "../styles/style.css"
import { Link } from 'react-router-dom';

import Header from '../komponensek/Header';
import ZenekarokLista from '../komponensek/zenekarokLista';

const Zenekarok = () => {
    return (
        <>
            <Header />
            <div className="row">
                <div className="col-12 text-center">
                    <h1>A Rock and Roll nagyjai</h1>
                </div>
            </div>
            <ZenekarokLista />
        </>
    );
};

export default Zenekarok;