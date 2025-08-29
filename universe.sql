

CREATE DATABASE universe;


\c universe


DROP TABLE IF EXISTS moon CASCADE;
DROP TABLE IF EXISTS planet CASCADE;
DROP TABLE IF EXISTS star CASCADE;
DROP TABLE IF EXISTS galaxy CASCADE;
DROP TABLE IF EXISTS comet CASCADE;


CREATE TABLE galaxy (
  galaxy_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(150) UNIQUE NOT NULL,
  description TEXT,
  age_million_years NUMERIC NOT NULL,
  has_life BOOLEAN NOT NULL,
  size_kly INT NOT NULL
);


CREATE TABLE star (
  star_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(150) UNIQUE NOT NULL,
  galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
  temperature_k INT NOT NULL,
  is_active BOOLEAN NOT NULL,
  luminosity NUMERIC
);


CREATE TABLE planet (
  planet_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(150) UNIQUE NOT NULL,
  star_id INT NOT NULL REFERENCES star(star_id),
  population INT,
  is_habitable BOOLEAN NOT NULL,
  mass NUMERIC NOT NULL
);


CREATE TABLE moon (
  moon_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(150) UNIQUE NOT NULL,
  planet_id INT NOT NULL REFERENCES planet(planet_id),
  radius_km INT NOT NULL,
  has_water BOOLEAN NOT NULL,
  orbit_period_days NUMERIC
);


CREATE TABLE comet (
  comet_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(150) UNIQUE NOT NULL,
  speed_km_s INT NOT NULL,
  tail_length_km NUMERIC,
  is_visible BOOLEAN NOT NULL,
  composition TEXT
);


INSERT INTO galaxy (name, description, age_million_years, has_life, size_kly) VALUES
('Milky Way', 'Nuestra galaxia', 13600, TRUE, 100000),
('Andromeda', 'Galaxia cercana grande', 10000, FALSE, 120000),
('Triangulum', 'Galaxia del Grupo Local', 8000, FALSE, 60000),
('Whirlpool', 'Galaxia espiral', 7000, FALSE, 80000),
('Sombrero', 'Galaxia con núcleo brillante', 9000, FALSE, 70000),
('Messier 87', 'Elíptica supergigante', 13000, FALSE, 500000);


INSERT INTO star (name, galaxy_id, temperature_k, is_active, luminosity) VALUES
('Sun', 1, 5778, TRUE, 1.0),
('Alpha Centauri', 1, 5790, TRUE, 1.5),
('Betelgeuse', 1, 3500, FALSE, 120000),
('Rigel', 2, 11000, TRUE, 85000),
('Sirius', 2, 9940, TRUE, 25.4),
('Vega', 3, 9602, TRUE, 40.1);


INSERT INTO planet (name, star_id, population, is_habitable, mass) VALUES
('Earth', 1, 8000000000, TRUE, 1.0),
('Mars', 1, 0, FALSE, 0.107),
('Venus', 1, 0, FALSE, 0.815),
('Proxima b', 2, 0, TRUE, 1.3),
('Alpha Centauri Bb', 2, 0, FALSE, 1.1),
('Betelgeuse I', 3, 0, FALSE, 5.0),
('Betelgeuse II', 3, 0, FALSE, 3.2),
('Rigel I', 4, 0, FALSE, 2.1),
('Rigel II', 4, 0, FALSE, 1.7),
('Sirius I', 5, 0, FALSE, 4.5),
('Vega I', 6, 0, FALSE, 2.2),
('Vega II', 6, 0, FALSE, 1.9);


INSERT INTO moon (name, planet_id, radius_km, has_water, orbit_period_days) VALUES
('Moon', 1, 1737, FALSE, 27.3),
('Phobos', 2, 11, FALSE, 0.3),
('Deimos', 2, 6, FALSE, 1.3),
('Venus-1', 3, 100, FALSE, 224.7),
('Proxima_b_I', 4, 900, FALSE, 2.5),
('Proxima_b_II', 4, 500, FALSE, 4.0),
('AlphaBb_I', 5, 300, FALSE, 1.2),
('AlphaBb_II', 5, 450, FALSE, 2.1),
('BetelgeuseI_a', 6, 700, FALSE, 3.2),
('BetelgeuseII_a', 7, 800, FALSE, 4.4),
('RigelI_a', 8, 1000, FALSE, 5.5),
('RigelII_a', 9, 1200, FALSE, 6.7),
('SiriusI_a', 10, 1300, FALSE, 7.0),
('VegaI_a', 11, 600, FALSE, 2.3),
('VegaII_a', 12, 650, FALSE, 3.1),
('VegaII_b', 12, 700, FALSE, 4.0),
('Callisto_like', 1, 2410, TRUE, 16.7),
('Ganymede_like', 1, 2634, TRUE, 7.1),
('Charon_like', 3, 606, FALSE, 6.4),
('Titan_like', 4, 2575, TRUE, 15.9);


INSERT INTO comet (name, speed_km_s, tail_length_km, is_visible, composition) VALUES
('Halley', 70, 24, TRUE, 'Ice and dust'),
('Encke', 69, 10, TRUE, 'Ice and gas'),
('Hale-Bopp', 110, 50, TRUE, 'Ice, dust, gas');
