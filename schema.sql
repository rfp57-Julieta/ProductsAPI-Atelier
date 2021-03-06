
DROP TABLE IF EXISTS product, styles, photos, skus, features, related;
-- DROP TABLE IF EXISTS cart;


CREATE TABLE IF NOT EXISTS product(
   product_id serial NOT NULL PRIMARY KEY,
   name VARCHAR NOT NULL,
   slogan VARCHAR NOT NULL,
   description VARCHAR NOT NULL,
   category VARCHAR NOT NULL,
   default_price INT NOT NULL
);

CREATE TABLE IF NOT EXISTS styles(
   styles_id serial NOT NULL PRIMARY KEY,
   productId INT NOT NULL,
   name VARCHAR NOT NULL,
   sale_price VARCHAR,
   original_price VARCHAR,
   default_style INT NOT NULL,
   FOREIGN KEY (productId) REFERENCES product (product_id)
);

CREATE TABLE IF NOT EXISTS photos(
  photos_id serial NOT NULL PRIMARY KEY,
  styleId INT NOT NULL REFERENCES styles (styles_id),
  url VARCHAR,
  thumbnail_url VARCHAR
);

CREATE TABLE IF NOT EXISTS skus(
   skus_id serial NOT NULL PRIMARY KEY,
   styleId INT NOT NULL REFERENCES styles (styles_id),
   size VARCHAR NOT NULL,
   quantity INT NOT NULL
);

CREATE TABLE IF NOT EXISTS features(
   features_id serial NOT NULL PRIMARY KEY,
   product_id INT NOT NULL REFERENCES product (product_id),
   feature VARCHAR NOT NULL,
   value VARCHAR
);

-- CREATE TABLE IF NOT EXISTS cart(
--    cart_id serial NOT NULL PRIMARY KEY,
--    user_session VARCHAR NOT NULL,
--    product_id INT NOT NULL REFERENCES product (product_id),
--    active INT
-- );

CREATE TABLE IF NOT EXISTS related(
  related_id serial NOT NULL PRIMARY KEY,
  current_product_id INT REFERENCES product (product_id),
  related_product_id INT
);

\COPY product FROM '/Users/shuwenliang/Documents/SDC/ProductsAPI/productDATA.csv' DELIMITER ',' CSV HEADER;
\COPY styles FROM '/Users/shuwenliang/Documents/SDC/ProductsAPI/stylesDATA.csv' DELIMITER ',' CSV HEADER;
\COPY photos FROM '/Users/shuwenliang/Documents/SDC/ProductsAPI/photosDATA.csv' DELIMITER ',' CSV HEADER;
\COPY skus FROM '/Users/shuwenliang/Documents/SDC/ProductsAPI/skusDATA.csv' DELIMITER ',' CSV HEADER;
\COPY features FROM '/Users/shuwenliang/Documents/SDC/ProductsAPI/featuresDATA.csv' DELIMITER ',' CSV HEADER;
-- \COPY cart FROM '/Users/shuwenliang/Documents/SDC/ProductsAPI/cartDATA.csv' DELIMITER ',' CSV HEADER;
\COPY related FROM '/Users/shuwenliang/Documents/SDC/ProductsAPI/relatedDATA.csv' DELIMITER ',' CSV HEADER;

DROP INDEX IF EXISTS product_idx;
DROP INDEX IF EXISTS style_idx;
DROP INDEX IF EXISTS skus_style_idx;
DROP INDEX IF EXISTS features_product_idx;
DROP INDEX IF EXISTS related_product_idx;
CREATE INDEX product_idx ON styles (productId);
CREATE INDEX style_idx ON photos (styleId);

CREATE INDEX skus_style_idx ON skus(styleId);
CREATE INDEX features_product_idx ON features(product_id);

-- CREATE INDEX cart_product_idx ON cart(product_id);
CREATE INDEX related_product_idx ON related(product_id);


