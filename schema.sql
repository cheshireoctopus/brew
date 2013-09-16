CREATE TABLE breweries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    city VARCHAR(30) NOT NULL,
    state VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT now()
);

  CREATE TABLE beers (
      id SERIAL PRIMARY KEY,
      name VARCHAR(30) NOT NULL,
      style VARCHAR(30) NOT NULL,
      abv DECIMAL(4,2) NOT NULL,
      url TEXT  NOT NULL,
      brewery_id SERIAL,
      FOREIGN KEY (brewery_id) REFERENCES breweries(id)
  );

