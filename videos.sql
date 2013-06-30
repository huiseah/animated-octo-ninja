DROP DATABASE allvideos;
CREATE DATABASE allvideos;
\c allvideos


CREATE TABLE videos (
id serial8 primary key,
name varchar(255),
description varchar(255),
url TEXT,
genre varchar(255)
);
