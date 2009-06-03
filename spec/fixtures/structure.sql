DROP TABLE IF EXISTS orders;

DROP SEQUENCE IF EXISTS orders_id_seq;

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
    
CREATE TABLE orders (
    id integer NOT NULL default nextval('orders_id_seq'),
    ordered_on timestamp,
    fulfilled_on timestamp,
    shipped_on timestamp,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

DROP TABLE IF EXISTS orders;

DROP SEQUENCE IF EXISTS orders_id_seq;

CREATE SEQUENCE customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
    
CREATE TABLE customers (
    id integer NOT NULL default nextval('customers_id_seq'),
    given_name char(255),
    family_name char(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

