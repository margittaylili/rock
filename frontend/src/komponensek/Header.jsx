import React from 'react';
import { NavLink } from 'react-router-dom';

const Header = () => {
    return (
        <>
            <nav className="pa3 pa4-ns">
                <div className="tc pb3">
                    <NavLink
                        className="link dim gray f6 f5-ns dib mr3"
                        activeClassName="active"
                        to="/"
                    >
                        Kezdőlap
                    </NavLink>
                    <NavLink
                        className="link dim gray f6 f5-ns dib mr3"
                        activeClassName="active"
                        to="/zenekarok"
                    >
                        A rock zene nagy csapatai
                    </NavLink>
                    <NavLink
                        className="link dim gray f6 f5-ns dib mr3"
                        activeClassName="active"
                        to="/hozzaadasEgyuttes"
                    >
                        Együttes feltöltés
                    </NavLink>
                </div>
            </nav>
        </>
    );
};

export default Header;