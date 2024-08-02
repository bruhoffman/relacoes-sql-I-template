-- Active: 1722531236736@@127.0.0.1@3306

CREATE TABLE users (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL
)

CREATE TABLE phones (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    phone_number TEXT UNIQUE NOT NULL,
    user_id TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) -- 1:m pq esse campo é unique
);

DROP TABLE users;

SELECT * FROM users;

SELECT * FROM phones;

INSERT INTO
    users (id, name, email, password)
VALUES (
        'u001',
        'Antonio',
        'ant@email.com',
        '1234'
    ),
    (
        'u002',
        'Beatriz',
        'bea@email.com',
        'benben123'
    );

INSERT INTO
    phones (id, phone_number, user_id)
VALUES ('p001', '123-654-789', 'u001'),
    ('p002', '654-978-123', 'u002'),
    ('p003', '765-489-321', 'u001');

SELECT * FROM phones INNER JOIN users ON users.id == phones.user_id;

SELECT * FROM phones INNER JOIN users ON users.id == phones.user_id;

-- PRÁTICA 3 - RELAÇÃO 1:1

CREATE TABLE licenses (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    register_number TEXT UNIQUE NOT NULL,
    category TEXT NOT NULL
);

CREATE TABLE drivers (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    license_id TEXT UNIQUE NOT NULL,
    FOREIGN KEY (license_id) REFERENCES licenses (id)
);

INSERT INTO
    licenses (id, register_number, category)
VALUES ('l001', '123456789', 'AB'),
    ('l002', '321654987', 'C'),
    ('l003', '456987123', 'A');

INSERT INTO
    drivers (
        id,
        name,
        email,
        password,
        license_id
    )
VALUES (
        'd001',
        'Antonio',
        'ant@email.com',
        '654321',
        'l003'
    ),
    (
        'd002',
        'Beatriz',
        'bea@email.com',
        '987321',
        'l002'
    ),
    (
        'd003',
        'Carlos',
        'caca@email.com',
        '432985',
        'l001'
    );

SELECT * FROM drivers;

SELECT * FROM licenses;

SELECT *
FROM licenses
    INNER JOIN drivers ON drivers.license_id = licenses.id;

-- Exrc. 1 - Me mostre o nome e o número do telefone do Antonio, pesquisando pelo início do nome (Ant..)
SELECT users.name, phones.phone_number
FROM users
    INNER JOIN phones ON users.id = phones.user_id
WHERE
    users.name LIKE 'Ant%';

-- Exrc. 2 - Me mostre o nome do usuário e o número de telefone dele, agrupe pelo nome e ordene de forme crescente o número de telefone

SELECT users.name, phones.phone_number
FROM users
    INNER JOIN phones ON users.id = phones.user_id
GROUP BY
    users.name
ORDER BY phones.phone_number ASC