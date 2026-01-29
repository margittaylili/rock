import React from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const UjegyuttesUrlap = () => {
    const [stilusok, setStilusok] = React.useState([]);
    const navigate = useNavigate();

    React.useEffect(() => {
        axios.get('http://localhost:3000/api/stilusok')
            .then(response => {
                setStilusok(response.data);
            })
            .catch(error => {
                console.error('Hiba a kérés során:', error);
            });
    }, []);

    const handleSubmit = (event) => {
        event.preventDefault();
        const formData = new FormData(event.target);
        const egyuttes = {
            nev: formData.get('nev'),
            stilus_id: formData.get('stilus'),
            orszag: formData.get('orszag'),
            varos: formData.get('varos'),
            aktiv_evek: formData.get('aktiv_evek'),
            tagok: formData.get('tagok'),
            legsikeresebb_album: formData.get('legsikeresebb_album'),
            kep_url: formData.get('kep_url'),
        };

        axios.post('http://localhost:3000/api/ujzenekar', egyuttes)
            .then(response => {
                navigate('/zenekarok');
            })
            .catch(error => {
                alert('Hiba történt a beküldés során.');
            });
    };

    return (
        <>
            <form onSubmit={handleSubmit} className='p-5'>
                <div className="form-group">
                    <label htmlFor="nev">Az együttes neve</label>
                    <input type="text" name="nev" className="form-control" required />
                </div>
                <div className="form-group">
                    <label htmlFor="stilus">A zenekar stílusa</label>
                    <select name="stilus" className="form-control" required>
                        {stilusok.map((stilus, index) => (
                            <option key={index} value={stilus.id}>{stilus.stilus_neve}</option>
                        ))}
                    </select>
                </div>
                <div className="form-group">
                    <label htmlFor="orszag">Az együttes országa</label>
                    <input type="text" name="orszag" className="form-control" required />
                </div>
                <div className="form-group">
                    <label htmlFor="varos">Az együttes városa</label>
                    <input type="text" name="varos" className="form-control" />
                </div>
                <div className="form-group">
                    <label htmlFor="aktiv_evek">Aktív évek</label>
                    <input type="text" name="aktiv_evek" className="form-control" required />
                </div>
                <div className="form-group">
                    <label htmlFor="tagok">Tagok</label>
                    <textarea name="tagok" className="form-control" required />
                </div>
                <div className="form-group">
                    <label htmlFor="legsikeresebb_album">Legsikeresebb album</label>
                    <input type="text" name="legsikeresebb_album" className="form-control" />
                </div>
                <div className="form-group">
                    <label htmlFor="kep_url">Az együttesről készült fénykép linkje</label>
                    <input type="url" name="kep_url" className="form-control" />
                </div> <br />
                <center>
                    <button type="submit" className="btn" style={{backgroundColor: "rgb(54, 24, 221)",color:"white"}}>Feltöltés</button>
                </center>
            </form>
        </>
    );
};

export default UjegyuttesUrlap;