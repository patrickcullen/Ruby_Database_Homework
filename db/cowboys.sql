DROP TABLE cowboys;

CREATE TABLE cowboys (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  species VARCHAR(255),
  favourite_weapon VARCHAR(255),
  last_known_location VARCHAR(255)
);
