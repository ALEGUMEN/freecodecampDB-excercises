CREATE DATABASE salon;
\c salon;

CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  name VARCHAR,
  phone VARCHAR UNIQUE
);

CREATE TABLE services (
  service_id SERIAL PRIMARY KEY,
  name VARCHAR
);

CREATE TABLE appointments (
  appointment_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id),
  service_id INT REFERENCES services(service_id),
  time VARCHAR
);

ALTER TABLE appointments
ADD CONSTRAINT fk_service_id
FOREIGN KEY (service_id)
REFERENCES services (service_id);

TRUNCATE TABLE services RESTART IDENTITY;
INSERT INTO services (service_id, name) VALUES (1, 'cut');
SELECT setval('services_service_id_seq', (SELECT MAX(service_id) FROM services));
INSERT INTO services (name) VALUES ('color');
INSERT INTO services (name) VALUES ('perm');

GRANT SELECT ON services TO freecodecamp;

GRANT ALL ON customers, appointments, services TO freecodecamp;
GRANT USAGE, SELECT ON SEQUENCE customers_customer_id_seq, appointments_appointment_id_seq, services_service_id_seq TO freecodecamp;


