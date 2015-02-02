CREATE TABLE tshirts (
  id INTEGER PRIMARY KEY,
  name TEXT,
  price INTEGER,
  quantity INTEGER,
  img_url TEXT
);

CREATE TABLE customers (
  id INTEGER PRIMARY KEY,
  name TEXT,
  email TEXT
);

CREATE TABLE purchases (
  id INTEGER PRIMARY KEY,
  customer_id INTEGER references customers,
  tshirt_id INTEGER references tshirts,
  quantity INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
