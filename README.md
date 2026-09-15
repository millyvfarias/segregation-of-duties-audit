# segregation-of-duties-audit
Auditoria automatizada de Segregação de Funções (SoD) utilizando SQL e SQLite para mitigação de riscos de fraude

**Objetivo:** Demonstrar a aplicação prática de SQL na identificação de falhas de Segregação de funções (SoD) em um banco de dados relacional, visando mitigar riscos de fraudes financeiras.

**Cenário:** Em instituições financeiras e grandes empresas corporativas, uma pessoa que é responsável pelo cadastro de um fornecedor no sistema não pode ser a mesma pessoa responsável pela aprovação do pagamento para ele. Esse acúmulo de privilégio cria uma vulnerabilidade grave. Esse projeto visa simular a base de dados de uma empresa onde precisamos auditar os acessos dos departamentos Financeiro e Suprimentos para verificar se essa regra está sendo respeitada.

**Tecnologia Utilizada:**
- SQL (Sistema de consultas)
- SQLite (Linguagem de gerenciamento)

**Processo investigativo:** 
- **Modelagem de dados:** Criação das tabelas "usuários" e "permissoes_usuarios" simulando um ambiente real.
- **Alimentação da base:** Inserção de dados fictícios representando o RH e a matriz de acessos sistêmicos.
- **Execução do teste (Query):** Criação de um script que utiliza JOIN para cruzar a base de dados de usuários com seus privilégios, filtrando especificamente as funções de CADASTRAR_FORNECEDOR e APROVAR_PAGAMENTO.
- **Identificação da exceção:** Uso das funções GROUP_CONCAT  e HAVING_COUNT > 1 para isolar e apontar apenas os perfis que possuem ambos os acessos conflitantes.

**Achado (evidência):**
- **Evidência e condição:** Foi identificado que duas colaboradoras possuem cadastro ativo para cadastrar fornecedores e aprovar pagamentos simultaneamente.
- **Causa:** Ausência de um controle preventivo no sistema que bloqueie a concessão de perfis conflitantes para a mesma pessoa, ou falha na matriz de acessos durante a aprovação do perfil.
- **Risco:** Alto. A falha expõe a empresa a fraudes internas, perdas financeiras (pagamentos para fornecedores fantasmas) e risco na imagem durante auditorias externas.

**Plano de Ação (recomendado):** 
1. **Ação imediata:** Verificar o acesso que de fato corresponde a cada uma e revogar o excedente.
2. **Ação definitiva:** Implementar uma trava sistêmica (controle preventivo) no banco de dados para impedir que a combinação das funções CADASTRAR_FORNECEDOR e APROVAR_PAAGAMENTO seja atribuída ao mesmo ID de usuário no futuro.

