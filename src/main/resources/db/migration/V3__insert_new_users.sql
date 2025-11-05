-- Inserir ou atualizar usuário kgonascimento
INSERT INTO USUARIO (username, password, role)
VALUES ('kgonascimento', '$2a$10$9j7OWhYxUJS3lzehf9tbyuBCTsPJmZYIXRuH.z0.a8Iw5wDvtJkPC', 'ROLE_FUNCIONARIO')
ON CONFLICT (username)
DO UPDATE SET
    password = EXCLUDED.password,
    role = EXCLUDED.role;

-- Inserir ou atualizar usuário admin
INSERT INTO USUARIO (username, password, role)
VALUES ('admin', '$2a$10$GDnclieRR2G76y06Em4PoexO4xm.08cRMB0TJe1jIFgXLIS3xiO8.', 'ROLE_GERENTE')
ON CONFLICT (username)
DO UPDATE SET
    password = EXCLUDED.password,
    role = EXCLUDED.role;
