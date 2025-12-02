-- Create Database (if Docker didn't auto-create)
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Drop tables to reset if restarted
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- =============================
-- CUSTOMERS TABLE
-- =============================
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(30),
    street_address VARCHAR(150),
    city VARCHAR(80),
    country VARCHAR(80),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =============================
-- PRODUCTS TABLE
-- =============================
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(150) NOT NULL,
    base_category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_qty INT NOT NULL DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =============================
-- ORDERS TABLE
-- =============================
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PENDING','PAID','SHIPPED','CANCELLED') NOT NULL DEFAULT 'PAID',
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- =============================
-- ORDER ITEMS TABLE
-- =============================
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_orderitems_order FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_orderitems_product FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE RESTRICT
);

-- =============================
-- PAYMENTS TABLE
-- =============================
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    method ENUM('CARD','CASH','TRANSFER','WALLET') NOT NULL,
    status ENUM('PENDING','SUCCESS','FAILED','REFUNDED') NOT NULL,
    paid_at DATETIME,
    CONSTRAINT fk_payments_order FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE RESTRICT
);

-- Improve performance w/ indexes
CREATE INDEX idx_orders_customer ON orders(customer_id, order_date);
CREATE INDEX idx_order_items_product ON order_items(product_id);


-- =============================
-- SEED CUSTOMERS (200 Records)
-- =============================

INSERT INTO customers (full_name, email, phone, street_address, city, country)
VALUES
('Tanya-Lee Brown', 'tanya.brown@yahoo.com', '876-555-1001', '6 Hope Boulevard', 'Kingston', 'Jamaica'),
('Jevaughn Campbell', 'jevcampbell@yahoo.com', '876-555-1002', '12 Constant Spring Rd', 'Kingston', 'Jamaica'),
('Akeem Wilson', 'akeem.wilson@yahoo.com', '876-555-1003', '45 Spanish Town Rd', 'St. Andrew', 'Jamaica'),
('Kimone Richards', 'kimrichards@yahoo.com', '876-555-1004', '3 Harbour St', 'Port Royal', 'Jamaica'),
('Sasha-Gay Clarke', 'sashaclarke@yahoo.com', '876-555-1005', '10 Market Circle', 'Montego Bay', 'Jamaica'),
('Christopher Rowe', 'chrisrowe@yahoo.com', '876-555-1006', '21 St. James Street', 'Montego Bay', 'Jamaica'),
('Andre Ellis', 'andre.ellis@yahoo.com', '876-555-1007', '7 Orange Street', 'Kingston', 'Jamaica'),
('Kadijah Foster', 'kadijahf@yahoo.com', '876-555-1008', '18 King Street', 'Spanish Town', 'Jamaica'),
('Romaine Bryan', 'romaine.b@yahoo.com', '876-555-1009', '4 Mannings Hill Rd', 'Kingston', 'Jamaica'),
('Briana Walters', 'bwalters@outlook.com', '876-555-1010', '9 Howard Cooke Blvd', 'Montego Bay', 'Jamaica'),
('Dane Nelson', 'd.nelson@outlook.com', '876-555-1011', '33 Cross Roads', 'Kingston', 'Jamaica'),
('Shanice Gordon', 'shaniceg@outlook.com', '876-555-1012', '15 Duke Street', 'Kingston', 'Jamaica'),
('Ricardo Matthews', 'ricardo.m@outlook.com', '876-555-1013', '8 Main Street', 'Ocho Rios', 'Jamaica'),
('Nakeisha Palmer', 'npalmer@outlook.com', '876-555-1014', '2 Negril Blvd', 'Negril', 'Jamaica'),
('Jodian Blake', 'jblake@outlook.com', '876-555-1015', '11 Brunswick Ave', 'Spanish Town', 'Jamaica'),
('Shaquille Henry', 'shaquille.h@outlook.com', '876-555-1016', '14 Ocean Blvd', 'Kingston', 'Jamaica'),
('Kemar Grant', 'kgrant@outlook.com', '876-555-1017', '22 Barnett Street', 'Montego Bay', 'Jamaica'),
('Amoy Francis', 'amoyf@outlook.com', '876-555-1018', '6 Oxford Road', 'Kingston', 'Jamaica'),
('Trevon Edwards', 'trevone@outlook.com', '876-555-1019', '5 East Street', 'Mandeville', 'Jamaica'),
('Shantel Barrett', 'shantel.b@outlook.com', '876-555-1020', '3 Ward Avenue', 'Mandeville', 'Jamaica'),
('Khalil Beckford', 'kbeckford@outlook.com', '876-555-1021', '17 Main Street', 'May Pen', 'Jamaica'),
('Jada Morgan', 'jada.m@outlook.com', '876-555-1022', '4 Independence Drive', 'May Pen', 'Jamaica'),
('Delroy Hinds', 'dhinds@outlook.com', '876-555-1023', '8 West Avenue', 'Santa Cruz', 'Jamaica'),
('Carissa McKenzie', 'cmckenzie@outlook.com', '876-555-1024', '2 Station Road', 'Black River', 'Jamaica'),
('Kevon Bailey', 'kevonb@hotmail.com', '876-555-1025', '39 Melrose Road', 'Mandeville', 'Jamaica'),
('Latoya Sinclair', 'latoyas@hotmail.com', '876-555-1026', '13 Harbour Street', 'Ocho Rios', 'Jamaica'),
('Odean Mills', 'omills@hotmail.com', '876-555-1027', '1 One Love Drive', 'Negril', 'Jamaica'),
('Aaliyah Johnson', 'aaliyahj@hotmail.com', '876-555-1028', '16 Molynes Road', 'Kingston', 'Jamaica'),
('Roshane McDonald', 'rmcdonald@hotmail.com', '876-555-1029', '55 Hagley Park Rd', 'Kingston', 'Jamaica'),
('Tamara Stewart', 'tamstewart@hotmail.com', '876-555-1030', '20 Queen Street', 'Port Antonio', 'Jamaica'),
('Jermaine Thomas', 'jthomas@hotmail.com', '876-555-1031', '27 Oxford Street', 'Kingston', 'Jamaica'),
('Shereece James', 'shjames@hotmail.com', '876-555-1032', '5 Wharf Road', 'Falmouth', 'Jamaica'),
('Rasheed Malcolm', 'rmalcolm@hotmail.com', '876-555-1033', '14 Great George Street', 'Sav-la-Mar', 'Jamaica'),
('Tashay Dennis', 'tdennis@hotmail.com', '876-555-1034', '3 Cornwall Road', 'Runaway Bay', 'Jamaica'),
('Leonardo Brown', 'leon.b@hotmail.com', '876-555-1035', '18 Market Street', 'Mandeville', 'Jamaica'),
('Dijon Walker', 'dwalker@hotmail.com', '876-555-1036', '6 High Street', 'Linstead', 'Jamaica'),
('Ashanti Dixon', 'ashantid@hotmail.com', '876-555-1037', '12 Harbour View', 'Kingston', 'Jamaica'),
('Christopher Blake', 'cblake@hotmail.com', '876-555-1038', '21 East Street', 'Port Maria', 'Jamaica'),
('Jayda Grant', 'jaydag@hotmail.com', '876-555-1039', '2 Bamboo Avenue', 'St. Elizabeth', 'Jamaica'),
('Wayne Parchment', 'wparchment@hotmail.com', '876-555-1040', '19 Main Road', 'Old Harbour', 'Jamaica'),
('Nickesha Duncan', 'nduncan@hotmail.com', '876-555-1041', '1 Nightingale Street', 'Black River', 'Jamaica'),
('Shaqwayne Harvey', 'sharvey@hotmail.com', '876-555-1042', '3 Cornwall Gardens', 'Montego Bay', 'Jamaica'),
('Keneisha Dyer', 'kdyer@hotmail.com', '876-555-1043', '10 Bay Road', 'Morant Bay', 'Jamaica'),
('Orane Morris', 'omorris@hotmail.com', '876-555-1044', '7 Orange Bay', 'Hanover', 'Jamaica'),
('Abigail McFarlane', 'amcfarlane@hotmail.com', '876-555-1045', '11 Long Bay', 'Portland', 'Jamaica'),
('Renaldo Simmonds', 'rsimmonds@hotmail.com', '876-555-1046', '14 Belvedere Road', 'Kingston', 'Jamaica'),
('Chanice Anderson', 'canderson@outlook.com', '876-555-1047', '9 St. Nettie Lane', 'Spanish Town', 'Jamaica'),
('Damien Allen', 'dallen@outlook.com', '876-555-1048', '33 South Street', 'Linstead', 'Jamaica'),
('Monique Saunders', 'msaunders@outlook.com', '876-555-1049', '6 Mountain View Ave', 'Kingston', 'Jamaica'),
('Dillon Bennett', 'dbennett@outlook.com', '876-555-1050', '19 Duke Street', 'Kingston', 'Jamaica'),
('Jahmiel Forbes', 'jforbes@outlook.com', '876-555-1051', '44 Windward Road', 'Kingston', 'Jamaica'),
('Kayla Harris', 'kharris@outlook.com', '876-555-1052', '3 Hope Road', 'Kingston', 'Jamaica'),
('Jamar McKnight', 'jmcknight@outlook.com', '876-555-1053', '8 Seaboard Street', 'Port Antonio', 'Jamaica'),
('Natoya Brown', 'natoyab@outlook.com', '876-555-1054', '21 St. James Place', 'Montego Bay', 'Jamaica'),
('Dwayne Johnson', 'djohnson@outlook.com', '876-555-1055', '5 Carter Street', 'Black River', 'Jamaica'),
('Zaria Stewart', 'zstewart@outlook.com', '876-555-1056', '10 Church Street', 'Spanish Town', 'Jamaica'),
('Romario Clarke', 'rclarke@outlook.com', '876-555-1057', '17 Belmont Road', 'Kingston', 'Jamaica'),
('Shanoya Campbell', 'shanoya.c@outlook.com', '876-555-1058', '15 Paul Bogle Street', 'Morant Bay', 'Jamaica'),
('Xavier Francis', 'xfrancis@outlook.com', '876-555-1059', '11 Main Street', 'Lucea', 'Jamaica'),
('Olivia Meredith', 'oliviam@outlook.com', '876-555-1060', '6 Mosley Drive', 'May Pen', 'Jamaica'),
('Romel Barrett', 'rbarrett@outlook.com', '876-555-1061', '4 Ward Avenue', 'Mandeville', 'Jamaica'),
('Jeneva Walters', 'jenevaw@outlook.com', '876-555-1062', '18 Catherine Hall', 'Montego Bay', 'Jamaica'),
('Adrian Powell', 'apowell@outlook.com', '876-555-1063', '25 Upper Waterloo Rd', 'Kingston', 'Jamaica'),
('Sashoy Davis', 'sdavis@outlook.com', '876-555-1064', '12 Baker Street', 'Mandeville', 'Jamaica'),
('Michael Edwards', 'michaele@hotmail.com', '876-555-1065', '9 Seaview Drive', 'Negril', 'Jamaica'),
('Tiana Chambers', 'tianac@hotmail.com', '876-555-1066', '42 Palm Avenue', 'Port Maria', 'Jamaica'),
('Denzel Foster', 'dforster@hotmail.com', '876-555-1067', '33 King Street', 'Kingston', 'Jamaica'),
('Kerry-Ann Price', 'kprice@hotmail.com', '876-555-1068', '2 Civic Centre', 'Sav-la-Mar', 'Jamaica'),
('Noah Burke', 'nburke@hotmail.com', '876-555-1069', '8 Layton Pen', 'St. Catherine', 'Jamaica'),
('Althea Riley', 'ariley@hotmail.com', '876-555-1070', '1 Beverly Hills', 'Kingston', 'Jamaica'),
('Rashawn Hyatt', 'rhyatt@hotmail.com', '876-555-1071', '6 Market District', 'Linstead', 'Jamaica'),
('Jody-Ann Clarke', 'jodyann.c@hotmail.com', '876-555-1072', '19 Bamboo Street', 'Black River', 'Jamaica'),
('Tyrone Bailey', 'tybailey@hotmail.com', '876-555-1073', '27 Knutsford Blvd', 'Kingston', 'Jamaica'),
('Melissa Blake', 'mblake@hotmail.com', '876-555-1074', '14 Garden Street', 'Ocho Rios', 'Jamaica'),
('Travis Taylor', 'ttaylor@hotmail.com', '876-555-1075', '10 Mountain View Road', 'Kingston', 'Jamaica'),
('Kadene King', 'kadenek@hotmail.com', '876-555-1076', '3 Chapel Street', 'Port Antonio', 'Jamaica'),
('Oshane Kelly', 'okelly@hotmail.com', '876-555-1077', '22 Old Road', 'Santa Cruz', 'Jamaica'),
('Roxanne Reid', 'rreid@hotmail.com', '876-555-1078', '7 West Ave', 'May Pen', 'Jamaica'),
('Devante Williams', 'devwill@hotmail.com', '876-555-1079', '44 Barnett St', 'Montego Bay', 'Jamaica'),
('Nadine Clarke', 'nadine.c@hotmail.com', '876-555-1080', '3 Seaside Blvd', 'Negril', 'Jamaica'),
('Orlando Dixon', 'odixon@hotmail.com', '876-555-1081', '8 Gordon Town Rd', 'Kingston', 'Jamaica'),
('Chantel Alvaranga', 'calvar@hotmail.com', '876-555-1082', '10 North Street', 'Spanish Town', 'Jamaica'),
('Rohan Mills', 'rmills@hotmail.com', '876-555-1083', '19 Market Square', 'Ocho Rios', 'Jamaica'),
('Kimora Johnson', 'kimoraj@hotmail.com', '876-555-1084', '5 Top Road', 'Mandeville', 'Jamaica'),
('Shawnette Bryan', 'sbryan@hotmail.com', '876-555-1085', '21 Grove Road', 'Old Harbour', 'Jamaica'),
('Devin Malcolm', 'dmalcolm@hotmail.com', '876-555-1086', '15 Wharf Street', 'Falmouth', 'Jamaica'),
('Kayode Foster', 'kayfoster@hotmail.com', '876-555-1087', '10 Marcus Garvey Drive', 'Kingston', 'Jamaica'),
('Nyesha Thomas', 'nythomas@hotmail.com', '876-555-1088', '6 Rose Hall', 'Montego Bay', 'Jamaica'),
('Trevon Barrett', 'trevb@hotmail.com', '876-555-1089', '3 Bellmount District', 'St. Andrew', 'Jamaica'),
('Sade-Marine Grant', 'sadegrant@hotmail.com', '876-555-1090', '4 High Street', 'Linstead', 'Jamaica'),
('Malik Scott', 'malik.scott@hotmail.com', '876-555-1091', '5 Hendon District', 'Sav-la-Mar', 'Jamaica'),
('Jeneil Douglas', 'jeneild@hotmail.com', '876-555-1092', '16 Marlin Way', 'Portmore', 'Jamaica'),
('Amari Walters', 'awalt@hotmail.com', '876-555-1093', '33 Manning Hills', 'Kingston', 'Jamaica'),
('Shakira Sterling', 'shakster@hotmail.com', '876-555-1094', '11 Harbour View', 'Kingston', 'Jamaica'),
('Jordan Bartley', 'jbartley@hotmail.com', '876-555-1095', '2 Lighthouse Road', 'Negril', 'Jamaica'),
('Alexis Morgan', 'alexism@hotmail.com', '876-555-1096', '9 Sunshine District', 'Santa Cruz', 'Jamaica'),
('Tevin Francis', 'tevin.f@hotmail.com', '876-555-1097', '14 Main Street', 'Manchester', 'Jamaica'),
('Shacoya Reid', 'shacoyar@hotmail.com', '876-555-1098', '7 Orchard Road', 'Falmouth', 'Jamaica'),
('Jahlil Williams', 'jwilliams@hotmail.com', '876-555-1099', '4 Cornwall Courts', 'Montego Bay', 'Jamaica'),
('Kaheim Stephenson', 'kstephenson@hotmail.com', '876-555-1100', '25 Grants Pen Rd', 'Kingston', 'Jamaica'),
('Tyesha Palmer', 'tpalmer@hotmail.com', '876-555-1101', '9 Gordon Boulevard', 'Spanish Town', 'Jamaica'),
('Rashida Dixon', 'rdixon@hotmail.com', '876-555-1102', '33 St. Johns Road', 'Spanish Town', 'Jamaica'),
('Owayne Richards', 'orichards@hotmail.com', '876-555-1103', '16 Orange Bay Main', 'Hanover', 'Jamaica'),
('Sherika Sterling', 'ssterling@hotmail.com', '876-555-1104', '42 Maxfield Avenue', 'Kingston', 'Jamaica'),
('Damar Taylor', 'dtaylor@hotmail.com', '876-555-1105', '7 Seaforth Street', 'Saint Thomas', 'Jamaica'),
('Jevon Green', 'jgreen@hotmail.com', '876-555-1106', '12 Belmont Road', 'Kingston', 'Jamaica'),
('Yolanda Blake', 'yblake@hotmail.com', '876-555-1107', '29 Union Street', 'Montego Bay', 'Jamaica'),
('Chadwick Grant', 'cgrant@hotmail.com', '876-555-1108', '18 High Street', 'Linstead', 'Jamaica'),
('Anika Chambers', 'achambers@hotmail.com', '876-555-1109', '4 Manning’s Road', 'Kingston', 'Jamaica'),
('Donovan Williams', 'dwilliams@hotmail.com', '876-555-1110', '3 Rosemount Avenue', 'Montego Bay', 'Jamaica'),
('Taurean Kelly', 'tkelly@hotmail.com', '876-555-1111', '21 Red Hills Rd', 'Kingston', 'Jamaica'),
('Danishka Bryan', 'dbryan@hotmail.com', '876-555-1112', '10 Great Pond', 'Ocho Rios', 'Jamaica'),
('Omar Thompson', 'othompson@hotmail.com', '876-555-1113', '5 Chapelton Road', 'May Pen', 'Jamaica'),
('Tavia McCalla', 'tmccalla@hotmail.com', '876-555-1114', '8 New Forest', 'Mandeville', 'Jamaica'),
('Marvin Marshall', 'mmarshall@hotmail.com', '876-555-1115', '11 West Green', 'Montego Bay', 'Jamaica'),
('Jahzae Johnson', 'jjohnson@hotmail.com', '876-555-1116', '3 Harbour Village', 'Portmore', 'Jamaica'),
('Janice Gordon', 'jgordon@hotmail.com', '876-555-1117', '7 Windward Path', 'Port Antonio', 'Jamaica'),
('Khalia Whitney', 'kwhitney@hotmail.com', '876-555-1118', '2 Burnt Savannah', 'St. Elizabeth', 'Jamaica'),
('Andre Palmer', 'apalmers@hotmail.com', '876-555-1119', '9 Rousseau Road', 'Kingston', 'Jamaica'),
('Shellian Dennis', 'sdennis@hotmail.com', '876-555-1120', '20 New Green Road', 'Mandeville', 'Jamaica'),
('Miguel Martin', 'mmartin@hotmail.com', '876-555-1121', '5 Chapel Lane', 'Montego Bay', 'Jamaica'),
('Tatianna Reid', 'treid@hotmail.com', '876-555-1122', '8 Great House Lane', 'Ocho Rios', 'Jamaica'),
('Trevor Hall', 'thall@hotmail.com', '876-555-1123', '3 Rio Bueno Dr', 'Discovery Bay', 'Jamaica'),
('Avion McKenzie', 'avionm@hotmail.com', '876-555-1124', '4 Chantilly Road', 'Mandeville', 'Jamaica'),
('Jodian Campbell', 'jcamps@hotmail.com', '876-555-1125', '14 Vineyard Town', 'Kingston', 'Jamaica'),
('Kareem Clarke', 'kclarke@hotmail.com', '876-555-1126', '10 Spring Mount', 'Montego Bay', 'Jamaica'),
('Tyesha Gordon', 'tygordon@hotmail.com', '876-555-1127', '17 Queen Street', 'Morant Bay', 'Jamaica'),
('Adriano Lewis', 'alewis@hotmail.com', '876-555-1128', '6 Market Lane', 'Sav-la-Mar', 'Jamaica'),
('Aliyah Martin', 'aliyahm@hotmail.com', '876-555-1129', '3 Burke Road', 'Spanish Town', 'Jamaica'),
('Nickoy Walters', 'nwalters@hotmail.com', '876-555-1130', '22 Mountain View', 'Kingston', 'Jamaica'),
('Arianne Clarke', 'aclarke@hotmail.com', '876-555-1131', '5 Brumalia Rd', 'Mandeville', 'Jamaica'),
('Omarian Scott', 'oscott@hotmail.com', '876-555-1132', '7 Church Lane', 'Port Maria', 'Jamaica'),
('Deandrea Beckford', 'dbeckford@hotmail.com', '876-555-1133', '18 Belmont District', 'St. Andrew', 'Jamaica'),
('Demar Jones', 'djones@hotmail.com', '876-555-1134', '2 Manning’s Park', 'Port Antonio', 'Jamaica'),
('Sherwin Morgan', 'smorgan@hotmail.com', '876-555-1135', '3 Alice Eldemire Dr', 'Montego Bay', 'Jamaica'),
('Keisha-Ann Taylor', 'keisha.t@hotmail.com', '876-555-1136', '11 Oxford Terrace', 'Kingston', 'Jamaica'),
('Dwayne White', 'dwhite@hotmail.com', '876-555-1137', '33 Spanish Town Road', 'Kingston', 'Jamaica'),
('Kaylee Morgan', 'kaymorgan@hotmail.com', '876-555-1138', '6 Harbour Drive', 'Portmore', 'Jamaica'),
('Ricardo Silvera', 'rsilvera@hotmail.com', '876-555-1139', '4 Content Gardens', 'Ocho Rios', 'Jamaica'),
('Shanoya Roberts', 'sroberts@hotmail.com', '876-555-1140', '9 Hillside Crescent', 'Mandeville', 'Jamaica'),
('Kemar Hayles', 'khayles@hotmail.com', '876-555-1141', '10 Cambridge Street', 'Falmouth', 'Jamaica'),
('Toni-Ann Gayle', 'tgayle@hotmail.com', '876-555-1142', '3 Belmont Road', 'Kingston', 'Jamaica'),
('Jerome Beckett', 'jbeck@hotmail.com', '876-555-1143', '12 Barnett View', 'Montego Bay', 'Jamaica'),
('Oriana Brooks', 'obrooks@gmail.com', '876-555-1144', '7 Orchid Way', 'Sav-la-Mar', 'Jamaica'),
('Dacres Ricketts', 'dricketts@gmail.com', '876-555-1145', '17 Main Road', 'Linstead', 'Jamaica'),
('Ravaughn Miller', 'rmiller@gmail.com', '876-555-1146', '19 Seaforth Gardens', 'Saint Thomas', 'Jamaica'),
('Kristal Henry', 'khenry@gmail.com', '876-555-1147', '4 Crystal Avenue', 'Spanish Town', 'Jamaica'),
('Dwight Grant', 'dwgrant@gmail.com', '876-555-1148', '28 Orange Street', 'Kingston', 'Jamaica'),
('Jada Knight', 'jadak@gmail.com', '876-555-1149', '12 Constant Spring Terrace', 'Kingston', 'Jamaica'),
('Maurice Brown', 'maubrown@gmail.com', '876-555-1150', '8 Market Circle', 'Montego Bay', 'Jamaica'),
('Brittany Rose', 'britrose@gmail.com', '876-555-1151', '3 Great House Street', 'Falmouth', 'Jamaica'),
('Christopher Dixon', 'cdixon@gmail.com', '876-555-1152', '21 Hillside Drive', 'Ocho Rios', 'Jamaica'),
('Teesha Allen', 'tallen@gmail.com', '876-555-1153', '4 Begonia Drive', 'Portmore', 'Jamaica'),
('Jermaine Graham', 'jgraham@gmail.com', '876-555-1154', '19 New Green', 'Mandeville', 'Jamaica'),
('Roshelle Douglas', 'rdouglas@gmail.com', '876-555-1155', '6 Lower Parade', 'Spanish Town', 'Jamaica'),
('Leon Walters', 'lwalters@gmail.com', '876-555-1156', '25 Heroes Circle', 'Kingston', 'Jamaica'),
('Nariah Smith', 'nsmith@gmail.com', '876-555-1157', '3 Sea Breeze Avenue', 'Negril', 'Jamaica'),
('Ricardo Evans', 'revans@gmail.com', '876-555-1158', '14 Union Street', 'Montego Bay', 'Jamaica'),
('Candice Brown', 'cbrown@gmail.com', '876-555-1159', '5 Princess Street', 'Port Antonio', 'Jamaica'),
('Oshane Bailey', 'obailey@gmail.com', '876-555-1160', '11 Bamboo Avenue', 'St. Catherine', 'Jamaica'),
('Marsha Bryan', 'marshab@gmail.com', '876-555-1161', '2 Top Hill Road', 'St. Elizabeth', 'Jamaica'),
('Akeelah Samuels', 'asamuels@gmail.com', '876-555-1162', '10 Molynes Road', 'Kingston', 'Jamaica'),
('Chadwick Thomas', 'cthomas@gmail.com', '876-555-1163', '8 Hope Boulevard', 'Kingston', 'Jamaica'),
('Deneille Edwards', 'dedwards@gmail.com', '876-555-1164', '2 Catherine Hall', 'Montego Bay', 'Jamaica'),
('Romaine Green', 'rgreen@gmail.com', '876-555-1165', '16 Ocean Blvd', 'Kingston', 'Jamaica'),
('Taija Lewis', 'tlewis@gmail.com', '876-555-1166', '9 Howard Cooke Blvd', 'Montego Bay', 'Jamaica'),
('Oshane Bryan', 'oshbryan@gmail.com', '876-555-1167', '5 Barnett Street', 'Montego Bay', 'Jamaica'),
('Tyesha Walker', 'twalker@gmail.com', '876-555-1168', '7 Duke Street', 'Kingston', 'Jamaica'),
('Rashida Burke', 'rburke@gmail.com', '876-555-1169', '14 Oxford Road', 'Kingston', 'Jamaica'),
('Kemar Morrison', 'kmorrison@gmail.com', '876-555-1170', '6 Main Street', 'Linstead', 'Jamaica'),
('Jhanielle Clarke', 'jclarke@yahoo.com', '876-555-1171', '3 Market Square', 'Sav-la-Mar', 'Jamaica'),
('Dwayne Saunders', 'dsaunders@yahoo.com', '876-555-1172', '21 Great George Street', 'Falmouth', 'Jamaica'),
('Shawna Dean', 'sdean@yahoo.com', '876-555-1173', '8 Bamboo Street', 'Black River', 'Jamaica'),
('Zayvion Miller', 'zmiller@yahoo.com', '876-555-1174', '4 Harbour View', 'Kingston', 'Jamaica'),
('Alicia Walters', 'awalters@yahoo.com', '876-555-1175', '29 East Street', 'Kingston', 'Jamaica'),
('Jevaun Henry', 'jhenry@yahoo.com', '876-555-1176', '1 High Street', 'Ocho Rios', 'Jamaica'),
('Nakia Jones', 'njones@yahoo.com', '876-555-1177', '13 Great Bay District', 'St. Elizabeth', 'Jamaica'),
('Tyriek Johnson', 'tyjohnson@gmail.com', '876-555-1178', '7 Heywood Street', 'Kingston', 'Jamaica'),
('Kadeem Bailey', 'kadeemb@gmail.com', '876-555-1179', '12 Ocean Drive', 'Negril', 'Jamaica'),
('Yannique Clarke', 'yclarke@gmail.com', '876-555-1180', '8 Grove Road', 'Old Harbour', 'Jamaica'),
('Michael Allen', 'mallen@gmail.com', '876-555-1181', '10 Market Street', 'Mandeville', 'Jamaica'),
('Shemika Barrett', 'sbarrett@gmail.com', '876-555-1182', '9 Fustic Grove', 'Portmore', 'Jamaica'),
('Lithonia Grant', 'lgrant@gmail.com', '876-555-1183', '2 Angels Grove', 'Spanish Town', 'Jamaica'),
('Delano Bryan', 'delano.b@gmail.com', '876-555-1184', '22 Queens Drive', 'Montego Bay', 'Jamaica'),
('Tashana White', 'twhite@gmail.com', '876-555-1185', '6 Great House Close', 'Montego Bay', 'Jamaica'),
('Romaine Scott', 'rscott@gmail.com', '876-555-1186', '16 Runaway Bay', 'St. Ann', 'Jamaica'),
('Shaniel Wilson', 'swilson@gmail.com', '876-555-1187', '11 Constant Spring Rd', 'Kingston', 'Jamaica'),
('Javante Dixon', 'javdixon@yahoo.com', '876-555-1188', '5 Portland Road', 'Port Antonio', 'Jamaica'),
('Jada Levy', 'jadalevy@yahoo.com', '876-555-1189', '19 Monk Street', 'Spanish Town', 'Jamaica'),
('Kimar Brown', 'kimarb@yahoo.com', '876-555-1190', '10 Great River', 'Hanover', 'Jamaica'),
('Jovaughn Dennis', 'jovdennis@yahoo.com', '876-555-1191', '2 Church Street', 'Falmouth', 'Jamaica'),
('Crystal Anderson', 'canderson@yahoo.com', '876-555-1192', '4 Reform Avenue', 'Sav-la-Mar', 'Jamaica'),
('Jovan Miller', 'jovmiller@yahoo.com', '876-555-1193', '6 Pine Valley', 'Portmore', 'Jamaica'),
('Jordane Lawson', 'jlawson@yahoo.com', '876-555-1194', '8 Lewis Street', 'Black River', 'Jamaica'),
('Shanique James', 'sjames@yahoo.com', '876-555-1195', '27 Trafalgar Rd', 'Kingston', 'Jamaica'),
('Rayan Douglas', 'rdouglasx@yahoo.com', '876-555-1196', '14 Ward Heights', 'Mandeville', 'Jamaica'),
('Khadijah Williams', 'kwilliams@yahoo.com', '876-555-1197', '42 Barnett Lane', 'Montego Bay', 'Jamaica'),
('Oniel Thomas', 'onielt@yahoo.com', '876-555-1198', '15 Orange Street', 'Kingston', 'Jamaica'),
('Samantha Green', 'sgreen@yahoo.com', '876-555-1199', '3 Fairview Drive', 'Montego Bay', 'Jamaica');




-- =============================
-- SEED PRODUCTS (Electronics)
-- =============================

INSERT INTO products (sku, name, base_category, price, stock_qty)
VALUES
('ELEC-001', 'Samsung A14 Smartphone', 'Electronics', 28500.00, 50),
('ELEC-002', 'Apple iPhone SE (2022)', 'Electronics', 75000.00, 30),
('ELEC-003', 'Alcatel 1V', 'Electronics', 17000.00, 40),
('ELEC-004', 'JBL Tune 510BT Headphones', 'Electronics', 9500.00, 70),
('ELEC-005', 'Samsung Galaxy Buds+', 'Electronics', 16500.00, 55),
('ELEC-006', 'Fire TV Stick Streaming Device', 'Electronics', 8200.00, 60),
('ELEC-007', 'Fitbit Inspire 3 Fitness Tracker', 'Electronics', 18500.00, 35),
('ELEC-008', 'Samsung 32” Smart TV', 'Electronics', 45000.00, 25),
('ELEC-009', 'Amazon Echo Dot (5th Gen)', 'Electronics', 11500.00, 45),
('ELEC-010', 'Wireless Bluetooth Speaker', 'Electronics', 6000.00, 80),
('ELEC-011', 'Portable Power Bank 10000mAh', 'Electronics', 4200.00, 90),
('ELEC-012', 'USB-C Fast Charger', 'Electronics', 2500.00, 100),
('ELEC-013', 'Laptop Cooling Pad', 'Electronics', 3500.00, 60),
('ELEC-014', '32GB MicroSD Card', 'Electronics', 1800.00, 200),
('ELEC-015', 'Ring Light with Tripod Stand', 'Electronics', 5000.00, 45),
('ELEC-016', 'Smart Watch – Fitness Display', 'Electronics', 12000.00, 55),
('ELEC-017', 'Noise-Canceling Wired Headset', 'Electronics', 3700.00, 90),
('ELEC-018', 'Computer Keyboard + Mouse Combo', 'Electronics', 3800.00, 70),
('ELEC-019', '8” Tablet Android', 'Electronics', 21500.00, 40),
('ELEC-020', 'Flash Drive 64GB', 'Electronics', 2200.00, 120),
('ELEC-021', 'Desktop UPS Backup 600VA', 'Electronics', 9500.00, 30),
('ELEC-022', 'HP Ink Cartridge – Black', 'Electronics', 4500.00, 85),
('ELEC-023', 'Printer USB Cable', 'Electronics', 900.00, 150),
('ELEC-024', 'WiFi Router Dual-Band', 'Electronics', 9500.00, 40),
('ELEC-025', 'Laptop Bag – Water Resistant', 'Electronics', 4800.00, 50),
('ELEC-026', 'Webcam 1080p HD', 'Electronics', 5600.00, 55),
('ELEC-027', 'LED Desk Lamp – USB Powered', 'Electronics', 2700.00, 60),
('ELEC-028', 'Rechargeable AA Batteries (4pk)', 'Electronics', 1600.00, 75),
('ELEC-029', 'Surge Protector Power Strip', 'Electronics', 3200.00, 100),
('ELEC-030', 'HDMI Cable 2m', 'Electronics', 1200.00, 130),

-- =============================
-- SEED PRODUCTS (Clothing & Apparel)
-- =============================

('CLOTH-031', 'Clarks Originals Desert Boot – Brown Suede', 'Clothing', 18500.75, 25),
('CLOTH-032', 'Reggae Festival T-Shirt – “One Love” Print', 'Clothing', 3500.50, 60),
('CLOTH-033', 'School Polo Shirt – White', 'Clothing', 2200.00, 120),
('CLOTH-034', 'Summer Flip Flops – Beach Style', 'Clothing', 950.99, 200),
('CLOTH-035', 'Jamaica Flag Hoodie – Black & Gold', 'Clothing', 6500.95, 35),
('CLOTH-036', 'Women’s Maxi Dress – Tropical Print', 'Clothing', 4800.49, 45),
('CLOTH-037', 'Men’s Button-up Linen Shirt – Coral', 'Clothing', 5200.89, 40),
('CLOTH-038', 'Cargo Shorts – Khaki', 'Clothing', 2800.79, 50),
('CLOTH-039', 'Track Pants – Athletic Black', 'Clothing', 3000.35, 65),
('CLOTH-040', 'Football Jersey – Reggae Boyz Replica', 'Clothing', 7500.99, 28),
('CLOTH-041', 'Women’s Sandals – Cork Sole', 'Clothing', 3650.45, 55),
('CLOTH-042', 'Sun Hat – Wide Brim Outdoor', 'Clothing', 1750.59, 70),
('CLOTH-043', 'Baby Onesie – “Island Girl”', 'Clothing', 1800.35, 90),
('CLOTH-044', 'Slip-On Canvas Shoes', 'Clothing', 3600.95, 50),
('CLOTH-045', 'Rain Jacket – Lightweight Green', 'Clothing', 4100.60, 38),
('CLOTH-046', 'Denim Shorts – Distressed Style', 'Clothing', 3200.50, 62),
('CLOTH-047', 'PE T-Shirt – School Uniform Blue', 'Clothing', 1900.20, 110),
('CLOTH-048', 'Track & Field Running Spikes', 'Clothing', 8900.70, 25),
('CLOTH-049', 'Back-to-School Backpack – Durable', 'Clothing', 4200.15, 47),
('CLOTH-050', 'Sleeveless Top – Tropical Leaves', 'Clothing', 2500.49, 65),
('CLOTH-051', 'Swim Shorts – JamRock Pattern', 'Clothing', 2750.30, 72),
('CLOTH-052', 'Yoga Tights – Active Stretch Fit', 'Clothing', 5200.40, 45),
('CLOTH-053', 'Women’s Crop Top – Summer Pink', 'Clothing', 1850.85, 85),
('CLOTH-054', 'Sports Socks – Cushioned (3 Pack)', 'Clothing', 900.10, 95),
('CLOTH-055', 'Men’s Belt – Leather Brown', 'Clothing', 1500.99, 55),
('CLOTH-056', 'Kids School Shoes – Black Lace', 'Clothing', 5300.25, 35),
('CLOTH-057', 'Wide Strap Sandals – Casual Comfort', 'Clothing', 2450.80, 60),
('CLOTH-058', 'Beach Sarong – Multi Pattern', 'Clothing', 1600.75, 70),
('CLOTH-059', 'Women’s Swimwear – Two Piece', 'Clothing', 3800.45, 48),
('CLOTH-060', 'Compression Sports Shorts – Black', 'Clothing', 3900.65, 52),

-- =============================
-- SEED PRODUCTS (Beachwear & Summer Lifestyle)
-- =============================

('BEACH-061', 'Rasta Swim Trunks – Red Gold Green', 'Beachwear', 2700.45, 70),
('BEACH-062', 'Women’s Beach Kimono Cover-Up', 'Beachwear', 3800.90, 48),
('BEACH-063', 'Beach Towel – “Welcome to Jamrock”', 'Beachwear', 2500.25, 85),
('BEACH-064', 'Snorkel Set – Mask + Tube', 'Beachwear', 5500.80, 35),
('BEACH-065', 'Beach Umbrella – Sun Block', 'Beachwear', 7200.00, 20),
('BEACH-066', 'Waterproof Dry Bag – 10L', 'Beachwear', 4500.60, 42),
('BEACH-067', 'Rasta Mesh Marina', 'Beachwear', 2900.50, 55),
('BEACH-068', 'Women’s Beach Sandals – Floral', 'Beachwear', 2800.79, 72),
('BEACH-069', 'Beach Cooler Bag – Portable', 'Beachwear', 4800.95, 30),
('BEACH-070', 'Inflatable Pool Float – Flamingo', 'Beachwear', 3900.40, 50),
('BEACH-071', 'Ladies Board Shorts – Aqua Blue', 'Beachwear', 3100.29, 47),
('BEACH-072', 'Kids Float Vest – Safety Approved', 'Beachwear', 3300.49, 38),
('BEACH-073', 'Sunscreen SPF 50 – Reef Safe', 'Beachwear', 2550.89, 64),
('BEACH-074', 'Water Shoes – Anti Slip', 'Beachwear', 3600.55, 51),
('BEACH-075', 'Carnival Rhinestone Bodysuit', 'Beachwear', 9200.99, 25),
('BEACH-076', 'Neon Whistle – Carnival Essentials', 'Beachwear', 650.49, 90),
('BEACH-077', 'Goggles – Anti Fog Swim Lenses', 'Beachwear', 1800.89, 120),
('BEACH-078', 'Beach Hat – Straw with Jamaica Patch', 'Beachwear', 2300.79, 60),
('BEACH-079', 'Waterproof Cellphone Pouch', 'Beachwear', 1600.55, 75),
('BEACH-080', 'LED Beach Party Glow Bracelets', 'Beachwear', 999.99, 150),
('BEACH-081', 'Women’s One-Piece Swimwear', 'Beachwear', 4100.35, 44),
('BEACH-082', 'Carnival Fishnet Tights – Gold', 'Beachwear', 1800.95, 88),
('BEACH-083', 'Beach Volleyball – Durable Grip', 'Beachwear', 3500.45, 40),
('BEACH-084', 'Rasta Head Wrap – Crochet Style', 'Beachwear', 1600.70, 77),
('BEACH-085', 'Sunburn Relief Aloe Gel', 'Beachwear', 2400.25, 66),

-- =============================
-- SEED PRODUCTS (Food & Grocery)
-- =============================

('FOOD-086', 'Grace Corned Beef 340g', 'Food & Grocery', 590.49, 140),
('FOOD-087', 'Lasco Food Drink – Vanilla 400g', 'Food & Grocery', 480.99, 160),
('FOOD-088', 'National Cheese Tricks Snack 30g (Pack of 6)', 'Food & Grocery', 420.35, 120),
('FOOD-089', 'HTB Spice Bun 12oz', 'Food & Grocery', 650.75, 110),
('FOOD-090', 'Tastee Beef Patties – Frozen Box (12)', 'Food & Grocery', 2950.90, 45),
('FOOD-091', 'Excelsior Water Crackers 300g', 'Food & Grocery', 430.60, 130),
('FOOD-092', 'Devon House Premium Ice Cream 1L – Rum & Raisin', 'Food & Grocery', 1850.45, 40),
('FOOD-093', 'Ting Grapefruit Soda 355ml (6 Pack)', 'Food & Grocery', 1150.25, 90),
('FOOD-094', 'Wata Bottled Water 500ml (12 Pack)', 'Food & Grocery', 720.50, 150),
('FOOD-095', 'Tropical Rhythms Fruit Punch 475ml (6 Pack)', 'Food & Grocery', 1450.35, 85),
('FOOD-096', 'Grace Vienna Sausages 140g (Pack of 3)', 'Food & Grocery', 620.89, 100),
('FOOD-097', 'Bad Dawg Jumbo Hot Dog Sausages – Frozen Pack', 'Food & Grocery', 1350.79, 75),
('FOOD-098', 'Lasco Soy Milk Powder – Chocolate 400g', 'Food & Grocery', 520.55, 120),
('FOOD-099', 'Grace Coconut Milk Powder 50g (6 Pack)', 'Food & Grocery', 580.99, 110),
('FOOD-100', 'Anchor Cheddar Cheese 500g', 'Food & Grocery', 1720.45, 70),
('FOOD-101', 'Jack Mackerel in Brine 425g', 'Food & Grocery', 460.30, 95),
('FOOD-102', 'Grace Baked Beans 300g', 'Food & Grocery', 430.10, 110),
('FOOD-103', 'Counter Flour 2kg', 'Food & Grocery', 920.55, 80),
('FOOD-104', 'Island Spice All Purpose Seasoning 200g', 'Food & Grocery', 580.75, 90),
('FOOD-105', 'Walkerswood Jerk Seasoning 10oz – Hot & Spicy', 'Food & Grocery', 980.99, 65),
('FOOD-106', 'Grace Browning 142ml', 'Food & Grocery', 390.40, 130),
('FOOD-107', 'Betty Condensed Milk 395g', 'Food & Grocery', 410.30, 120),
('FOOD-108', 'Curry Goat Seasoning 200g', 'Food & Grocery', 650.25, 95),
('FOOD-109', 'Grace Callaloo 300g (Tin)', 'Food & Grocery', 430.80, 100),
('FOOD-110', 'Grace Red Peas 300g (Tin)', 'Food & Grocery', 440.35, 100),
('FOOD-111', 'Eve Vegetable Oil 1L', 'Food & Grocery', 750.99, 90),
('FOOD-112', 'Counter White Rice 5kg', 'Food & Grocery', 2450.40, 60),
('FOOD-113', 'Wrigley Big Foot Cheese Snack (Pack of 8)', 'Food & Grocery', 520.15, 85),
('FOOD-114', 'National Shirley Biscuits 112g (Pack of 4)', 'Food & Grocery', 390.49, 105),
('FOOD-115', 'Chippies Banana Chips 30g (Pack of 10)', 'Food & Grocery', 850.70, 115),
('FOOD-116', 'Appleton Estate Signature Blend Rum 750ml', 'Food & Grocery', 3950.95, 40),
('FOOD-117', 'Wray & Nephew White Overproof Rum 750ml', 'Food & Grocery', 4200.99, 35),
('FOOD-118', 'Red Stripe Beer 275ml (6 Pack)', 'Food & Grocery', 1650.45, 50),
('FOOD-119', 'Malta Drink 330ml (6 Pack)', 'Food & Grocery', 1050.35, 75),
('FOOD-120', 'Tropical Sun Sorrel Drink 1L', 'Food & Grocery', 650.25, 65),

-- =============================
-- SEED PRODUCTS (Beauty & Hair Care)
-- =============================

('BEAUTY-121', 'Black Castor Oil – Original 118ml', 'Beauty & Hair', 850.49, 80),
('BEAUTY-122', 'Cantu Shea Butter Leave-In Conditioner 340g', 'Beauty & Hair', 1750.80, 60),
('BEAUTY-123', 'Eco Styler Olive Oil Styling Gel 16oz', 'Beauty & Hair', 960.35, 90),
('BEAUTY-124', 'Braiding Hair – 3X Pre-Stretched', 'Beauty & Hair', 1150.99, 100),
('BEAUTY-125', 'Satin Bonnet – Sleep Cap', 'Beauty & Hair', 650.15, 110),
('BEAUTY-126', 'Edge Control Wax – Strong Hold', 'Beauty & Hair', 780.75, 85),
('BEAUTY-127', 'Moisturizing Body Wash – Coconut Scent', 'Beauty & Hair', 950.30, 70),
('BEAUTY-128', 'Whitening Toothpaste – Mint 100ml', 'Beauty & Hair', 450.40, 120),
('BEAUTY-129', 'Herbal Deodorant – Aloe & Lime', 'Beauty & Hair', 520.20, 90),
('BEAUTY-130', 'Aloe Vera Face Gel – Hydrating', 'Beauty & Hair', 1050.55, 75),
('BEAUTY-131', 'Wig – Curly Bob Synthetic', 'Beauty & Hair', 6500.99, 30),
('BEAUTY-132', 'Nail Polish Set – Tropical Colours (6 Pack)', 'Beauty & Hair', 1290.65, 65),
('BEAUTY-133', 'Shea Butter Body Lotion 500ml', 'Beauty & Hair', 1450.45, 70),
('BEAUTY-134', 'Exfoliating Body Scrub – Brown Sugar', 'Beauty & Hair', 1300.15, 55),
('BEAUTY-135', 'Relaxer Kit – Regular Strength', 'Beauty & Hair', 980.60, 50),
('BEAUTY-136', 'Lip Gloss – Coconut Shine', 'Beauty & Hair', 450.99, 110),
('BEAUTY-137', 'Tea Tree Oil – Anti Dandruff 60ml', 'Beauty & Hair', 1100.75, 60),
('BEAUTY-138', 'Hair Shears – Professional Cutting Scissors', 'Beauty & Hair', 2100.40, 40),
('BEAUTY-139', 'Makeup Brush Set – 12 Piece', 'Beauty & Hair', 2850.90, 35),
('BEAUTY-140', 'Beard Oil – Jamaican Castor Blend', 'Beauty & Hair', 1250.85, 50),

-- =============================
-- SEED PRODUCTS (Sports & Outdoors)
-- =============================

('SPORT-141', 'Size 5 Football – Reggae Boyz Colours', 'Sports & Outdoors', 3600.55, 40),
('SPORT-142', 'Cricket Bat – Youth Size', 'Sports & Outdoors', 5200.99, 25),
('SPORT-143', 'Cricket Ball – Leather Red', 'Sports & Outdoors', 1200.35, 60),
('SPORT-144', 'Netball – Official Size', 'Sports & Outdoors', 3150.75, 30),
('SPORT-145', 'Adjustable Dumbbell Set – 10kg', 'Sports & Outdoors', 8900.50, 20),
('SPORT-146', 'Jump Rope – Speed Training', 'Sports & Outdoors', 950.20, 100),
('SPORT-147', 'Yoga Mat – Non Slip', 'Sports & Outdoors', 2600.45, 45),
('SPORT-148', 'Camping Lantern – Rechargeable', 'Sports & Outdoors', 4200.99, 30),
('SPORT-149', 'Hiking Backpack – 30L', 'Sports & Outdoors', 5500.80, 25),
('SPORT-150', 'Cricket Helmet – Protective', 'Sports & Outdoors', 8600.60, 15);
