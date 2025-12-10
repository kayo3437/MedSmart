MedSmart

O MedSmart é um sistema voltado para gestão de saúde, permitindo que pacientes, médicos e acompanhantes controlem receitas, consultas, medicamentos, lembretes e histórico médico de forma integrada. O projeto utiliza conceitos de banco de dados relacionais, garantindo organização, rastreabilidade e segurança das informações.
----------------------------------------------------------------------
📌 Objetivo do Sistema

O MedSmart tem como foco centralizar e facilitar o gerenciamento de informações de saúde, oferecendo:

Controle de prescrições e medicamentos

Acompanhamento de consultas

Emissão de lembretes de medicação

Armazenamento de histórico médico

Acessos diferentes para pacientes, médicos e acompanhantes
----------------------------------------------------------------------------------
🧩 Principais Funcionalidades
👤 Usuários

O sistema possui três níveis de usuários:

Paciente – gerencia seus dados, consultas, receitas e lembretes

Médico – prescreve receitas, cadastra consultas e acompanha pacientes

Acompanhante – pode auxiliar um paciente, com permissões controladas
--------------------------------------------------------------------------
📝 Receitas Médicas

Registro de receitas vinculadas ao médico e paciente

Detalhamento de medicamentos, posologia, duração e frequência

Controle de validade e status da receita
--------------------------------------------------------------------------------
💊 Medicamentos

Cadastro de medicamentos (nome comercial, princípio ativo, dosagem etc.)

Associação a itens de receita
--------------------------------------------------------------------------------------------------------------------
⏰ Lembretes

Geração automática de lembretes conforme posologia

Configuração de horários, dias da semana, som e vibração

Opção de lembretes para paciente e acompanhante
---------------------------------------------------------------------------------------------------------
📅 Consultas

Agendamento de consultas por pacientes

Registros médicos por profissionais de saúde
---------------------------------------------------------------------------------------------------
📚 Histórico Médico

Registro de eventos, diagnósticos, alergias, observações e gravidade
----------------------------------------------------------------------------------------------------
🔐 Controle e Auditoria

Todas as ações ficam registradas em logs de atividade

Rastreamento completo de mudanças, cadastros e atualizações

Dados sensíveis protegidos
----------------------------------------------------------------------------------------------------
🗂️ Estrutura do Banco de Dados (Resumo das Tabelas)

O sistema utiliza diversas tabelas para organizar suas entidades principais, incluindo:

usuario – dados gerais dos usuários

paciente – informações de saúde e endereço

medico – CRM, especialidade e contatos

consulta – agendamentos e registros médicos

receita – prescrição principal

item_receita – lista de medicamentos da receita

medicamento – catálogo de medicamentos

lembrete – alarmes automáticos de medicação

historico_medico – registros do histórico de saúde

alergia – controle de alergias dos pacientes

acompanhante – permissões e vínculos

log_atividade – rastreamento de ações

documento – arquivos enviados (laudos, exames etc.)

configuracao – parâmetros gerais do sistema
----------------------------------------------------------------------------------------------------
🔗 Relacionamentos Principais

Paciente → Consulta → Médico

Médico → Receita → Medicamentos

Receita → Itens → Lembretes

Usuário → Histórico Médico

Acompanhante → Paciente
----------------------------------------------------------------------------------------------------
🏗️ Tecnologias Envolvidas

Banco de Dados Relacional

Sistema de Notificações (Lembretes)

Possível uso de IA para leitura de receitas

Aplicativo Mobile (iOS/Android como objetivo futuro)
----------------------------------------------------------------------------------------------------
📌 Considerações Técnicas
Requisitos Não-Funcionais

Segurança de dados

Alta disponibilidade

Interface simples e acessível

Conformidade com leis de proteção de dados

Desafios Identificados

Manter banco de medicamentos atualizado

Precisão no reconhecimento de receitas via IA

Escalabilidade do sistema

Integração com sistemas médicos existentes
