-- Drop tables if they exist (in reverse order to avoid FK constraints)
DROP TABLE IF EXISTS Order_Item;
DROP TABLE IF EXISTS Order_Header;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Contact_Mech;
DROP TABLE IF EXISTS Customer;

-- Create Customer table
CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- Create Contact_Mech table
CREATE TABLE Contact_Mech (
    contact_mech_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    street_address VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    phone_number VARCHAR(20),
    email VARCHAR(100),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);

-- Create Product table
CREATE TABLE Product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    color VARCHAR(30),
    size VARCHAR(10)
);

-- Create Order_Header table
CREATE TABLE Order_Header (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    shipping_contact_mech_id INT NOT NULL,
    billing_contact_mech_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (shipping_contact_mech_id) REFERENCES Contact_Mech(contact_mech_id),
    FOREIGN KEY (billing_contact_mech_id) REFERENCES Contact_Mech(contact_mech_id)
);

-- Create Order_Item table
CREATE TABLE Order_Item (
    order_item_seq_id SERIAL,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (order_item_seq_id, order_id),
    FOREIGN KEY (order_id) REFERENCES Order_Header(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
