-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3307
-- Létrehozás ideje: 2025. Máj 20. 12:40
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `rock_zenekarok_70s`
--
CREATE DATABASE IF NOT EXISTS `rock_zenekarok_70s` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `rock_zenekarok_70s`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `stilusok`
--

CREATE TABLE `stilusok` (
  `id` int(11) NOT NULL,
  `stilus_neve` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `stilusok`
--

INSERT INTO `stilusok` (`id`, `stilus_neve`) VALUES
(1, 'Rock'),
(2, 'Hard rock'),
(3, 'Progresszív rock'),
(4, 'Pszichedelikus rock'),
(5, 'Altarnatív rock'),
(6, 'Punk rock'),
(7, 'Dzsesszrock'),
(8, 'Heavy metal');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `zenekarok`
--

CREATE TABLE `zenekarok` (
  `id` int(11) NOT NULL,
  `nev` varchar(100) NOT NULL,
  `stilus_id` int(11) DEFAULT NULL,
  `orszag` varchar(50) DEFAULT NULL,
  `varos` varchar(50) DEFAULT NULL,
  `aktiv_evek` varchar(50) DEFAULT NULL,
  `tagok` text DEFAULT NULL,
  `legsikeresebb_album` varchar(100) DEFAULT NULL,
  `kep_url` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `zenekarok`
--

INSERT INTO `zenekarok` (`id`, `nev`, `stilus_id`, `orszag`, `varos`, `aktiv_evek`, `tagok`, `legsikeresebb_album`, `kep_url`) VALUES
(1, 'Queen', 1, 'Egyesült Királyság', 'London', '1970–1991', 'Freddie Mercury, Brian May, John Deacon, Roger Taylor', 'A Night at the Opera', 'https://www.rockbook.hu/sites/default/files/queen.jpg'),
(2, 'Led Zeppelin', 2, 'Egyesült Királyság', 'London', '1968–1980', 'Robert Plant, Jimmy Page, John Paul Jones, John Bonham', 'Led Zeppelin IV', 'https://www.rockbook.hu/sites/default/files/Led_Zeppelin_1979%20rockbook.jpg'),
(3, 'Pink Floyd', 3, 'Egyesült Királyság', 'Cambridge', '1965–1995', 'David Gilmour, Roger Waters, Nick Mason, Richard Wright', 'The Dark Side of the Moon', 'https://www.rockbook.hu/sites/default/files/pink%20floyd%20rockbook%207.jpg'),
(4, 'The Rolling Stones', 1, 'Egyesült Királyság', 'London', '1962–napjainkig', 'Mick Jagger, Keith Richards, Charlie Watts, Ronnie Wood', 'Sticky Fingers', 'https://www.rockbook.hu/sites/default/files/the%20rolling%20stones%20rockbook%204.jpg'),
(5, 'AC/DC', 2, 'Ausztrália', 'Sydney', '1973–napjainkig', 'Angus Young, Malcolm Young, Bon Scott, Brian Johnson', 'Back in Black', 'https://www.rockbook.hu/sites/default/files/ac_dc-4-band-photo.jpg'),
(6, 'KISS', 2, 'Egyesült Államok', 'New York', '1973–2023', 'Paul Stanley, Gene Simmons, Ace Frehley, Peter Criss', 'Destroyer', 'https://www.rockbook.hu/sites/default/files/kiss1.jpg'),
(14, 'Scorpions', 1, 'Németország', 'Hannover', '1965-napjainkig', 'Matthias Jab	Rudolf Schenker	Paweł Mąciwoda	Mikkey Dee', 'Lovedrive', 'https://upload.wikimedia.org/wikipedia/commons/d/d5/Scorpions_-_01.jpg');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `stilusok`
--
ALTER TABLE `stilusok`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `zenekarok`
--
ALTER TABLE `zenekarok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stilus_id` (`stilus_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `stilusok`
--
ALTER TABLE `stilusok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT a táblához `zenekarok`
--
ALTER TABLE `zenekarok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `zenekarok`
--
ALTER TABLE `zenekarok`
  ADD CONSTRAINT `zenekarok_ibfk_1` FOREIGN KEY (`stilus_id`) REFERENCES `stilusok` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
