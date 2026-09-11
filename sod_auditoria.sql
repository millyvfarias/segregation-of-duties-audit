DROP TABLE IF EXISTS permissoes_usuarios;
DROP TABLE IF EXISTS usuarios;

CREATE TABLE usuarios (
id_usuario INTEGER PRIMARY KEY,
nome TEXT NOT NULL,
departamento TEXT NOT NULL
);

CREATE TABLE permissoes_usuarios (
id_permissao INTEGER PRIMARY KEY,
id_usuario INTEGER,
funcao_sistema TEXT NOT NULL,
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

INSERT INTO usuarios (id_usuario, nome, departamento) VALUES
(1, 'Ana Silva', 'Financeiro'),
(2, 'Carlos Souza', 'Comercial'),
(3, 'Mariana Costa', 'Suprimentos'),
(4, 'Lucas Martins', 'Financeiro'),
(5, 'Beatriz Lima', 'Comercial'),
(6, 'Rafael Souza', 'Suprimentos'),
(7, 'Juliana Alves', 'Financeiro'),
(8, 'Gabriel Rocha', 'Tecnologia'),
(9, 'Camila Ribeiro', 'Financeiro'),
(10, 'Bruno Dias', 'Suprimentos');

INSERT INTO permissoes_usuarios (id_usuario, funcao_sistema) VALUES
(1, 'CADASTRAR_FORNECEDOR'),
(2, 'APROVAR_PAGAMENTO'), 
(3, 'CADASTRAR_FORNECEDOR'),
(3, 'APROVAR_PAGAMENTO'),
(4, 'APROVAR_PAGAMENTO'),
(5, 'CADASTRAR_FORNECEDOR'),
(6, 'CADASTRAR_FORNECEDOR'),
(7, 'CADASTRAR_FORNECEDOR'),
(7, 'APROVAR_PAGAMENTO'),
(8, 'SUPORTE_TI'),
(9, 'APROVAR_PAGAMENTO'),
(10, 'CADASTRAR_FORNECEDOR');


SELECT
u.id_usuario,
u.nome AS colaborador,
u.departamento,
GROUP_CONCAT(p.funcao_sistema, ', ') AS permisao_violada
FROM usuarios u
JOIN permissoes_usuarios p ON u.id_usuario = p.id_usuario
WHERE p.funcao_sistema IN ('CADASTRAR_FORNECEDOR', 'APROVAR_PAGAMENTO')
GROUP BY u.id_usuario, u.nome, u.departamento
HAVING COUNT(DISTINCT p.funcao_sistema) > 1;
