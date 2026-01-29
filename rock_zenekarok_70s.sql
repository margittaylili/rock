-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:8889
-- Létrehozás ideje: 2026. Jan 22. 18:15
-- Kiszolgáló verziója: 8.0.40
-- PHP verzió: 8.3.14

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

DROP TABLE IF EXISTS `stilusok`;
CREATE TABLE `stilusok` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stilus_neve` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `stilusok`
--

INSERT INTO `stilusok` (`id`, `stilus_neve`) VALUES
(1, 'Rock'),
(2, 'Hard rock'),
(3, 'Progresszív rock'),
(4, 'Pszichedelikus rock'),
(5, 'Alternatív rock'),
(6, 'Punk rock'),
(7, 'Dzsesszrock'),
(8, 'Heavy metal');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `zenekarok`
--

DROP TABLE IF EXISTS `zenekarok`;
CREATE TABLE `zenekarok` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nev` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `stilus_id` int DEFAULT NULL,
  `orszag` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `varos` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `aktiv_evek` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `tagok` text CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `legsikeresebb_album` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `kep_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  PRIMARY KEY (`id`),
  KEY `stilus_id` (`stilus_id`)
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
(6, 'KISS', 2, 'Egyesült Államok', 'New York', '1973–2023', 'Paul Stanley, Gene Simmons, Ace Frehley, Peter Criss', 'Destroyer', 'https://www.rockbook.hu/sites/default/files/kiss1.jpg');

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT a táblához `zenekarok`
--
ALTER TABLE `zenekarok`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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



/*
Elírás a stilusok táblában:

Hiba: Az Altarnatív rock helytelenül volt írva.
Javítás: Javítva Alternatív rock-ra.
Hibás sor a zenekarok táblában:

Hiba: A zenekarok táblában a 7. sor hibás adatokat tartalmazott ('w', 'w', 'w', 'w', 'w').
Javítás: A hibás sort eltávolítottam.
NOT NULL és AUTO_INCREMENT pontosítása:

Hiba: Az id oszlopoknál nem volt explicit AUTO_INCREMENT és NOT NULL megadva.
Javítás: Az id oszlopoknál explicit módon megadtam a NOT NULL AUTO_INCREMENT attribútumot.
*/