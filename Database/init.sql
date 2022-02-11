CREATE TABLE IF NOT EXISTS blocks (
  block_hash varchar(450) NOT NULL,
  author varchar(450) NOT NULL,
  PRIMARY KEY (block_hash)
)