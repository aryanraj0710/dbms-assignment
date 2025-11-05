1. Prepare script to create table1 and table2 with primary key
mydb=# -- Create table1 with a primary key
CREATE TABLE table1 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    created_at DATE
);

-- Create table2 with a primary key
CREATE TABLE table2 (
    id INT PRIMARY KEY,
    description TEXT,
    table1_id INT,
    FOREIGN KEY (table1_id) REFERENCES table1(id)
);

2. Prepare script to add foreign key constraint on any one table
mydb=# -- Step 3: Add foreign key constraint to table2 referencing table1
ALTER TABLE table2
ADD CONSTRAINT fk_table1_id
FOREIGN KEY (table1_id)
REFERENCES table1(id);

3. Prepare script to add unique constraint to any one column
-- Add unique constraint to the 'name' column in table1
ALTER TABLE table1
ADD CONSTRAINT unique_name
UNIQUE (name);

4. Prepare script to add index to any column
-- Add index to the 'name' column in table1
CREATE INDEX idx_name ON table1(name);

5. Create insert queries to add around 4 to 8 rows in both the tables
INSERT INTO table1 (id, name, created_at) VALUES
(1, 'Alice', '2025-01-10'),
(2, 'Bob', '2025-02-15'),
(3, 'Charlie', '2025-03-20'),
(4, 'Diana', '2025-04-25'),
(5, 'Ethan', '2025-05-30'),
(6, 'Fiona', '2025-06-05'),
(7, 'George', '2025-07-10'),
(8, 'Hannah', '2025-08-15');

INSERT INTO table2 (id, description, table1_id) VALUES
(101, 'Order for Alice', 1),
(102, 'Order for Bob', 2),
(103, 'Order for Charlie', 3),
(104, 'Order for Diana', 4),
(105, 'Order for Ethan', 5),
(106, 'Order for Fiona', 6),
(107, 'Order for George', 7),
(108, 'Order for Hannah', 8);


6. Prepare a select query using WHERE, 'NOT IN', LIKE and ORDER BY clause
SELECT id, name, created_at
FROM table1
WHERE id NOT IN (2, 4, 6)
  AND name LIKE 'A%'
ORDER BY created_at DESC;

7. Prepare a select query using GROUP BY and HAVING clause, with COUNT, SUM
SELECT table1_id, COUNT(*) AS order_count, SUM(LENGTH(description)) AS total_description_length
FROM table2
GROUP BY table1_id
HAVING COUNT(*) > 1 AND SUM(LENGTH(description)) > 20;

8. Prepare a INNER JOIN query between table1 and table2
SELECT 
    table1.id AS person_id,
    table1.name,
    table1.created_at,
    table2.id AS order_id,
    table2.description
FROM 
    table1
INNER JOIN 
    table2 ON table1.id = table2.table1_id;

9. Prepare LEFT JOIN query between table1 and table2
SELECT 
    table1.id AS person_id,
    table1.name,
    table1.created_at,
    table2.id AS order_id,
    table2.description
FROM 
    table1
LEFT JOIN 
    table2 ON table1.id = table2.table1_id;

10. Prepare 5 insert and update statements on table 1, with COMMIT and ROLLBACK in between queries.
-- Start transaction block
BEGIN;

-- Insert 3 new rows into table1
INSERT INTO table1 (id, name, created_at) VALUES (9, 'Ivy', '2025-09-01');
INSERT INTO table1 (id, name, created_at) VALUES (10, 'Jack', '2025-09-05');
INSERT INTO table1 (id, name, created_at) VALUES (11, 'Kara', '2025-09-10');

-- Commit the above inserts
COMMIT;

-- Start another transaction block
BEGIN;

-- Insert 2 more rows
INSERT INTO table1 (id, name, created_at) VALUES (12, 'Leo', '2025-09-15');
INSERT INTO table1 (id, name, created_at) VALUES (13, 'Mona', '2025-09-20');

-- Update 2 existing rows
UPDATE table1 SET name = 'Alice Updated' WHERE id = 1;
UPDATE table1 SET created_at = '2025-01-15' WHERE id = 1;

-- Rollback this transaction (undo inserts and updates)
ROLLBACK;

-- Final update outside rollback
UPDATE table1 SET name = 'Bob Updated' WHERE id = 2;

-- Commit the final update
COMMIT;
