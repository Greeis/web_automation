#language: pt

@cadastro_pagamento @minha_conta
Funcionalidade: Cadastro de dados de pagamento na Minha Conta
    Como viajante cadastrado no site
    Quero adicionar mais cartoes de credito no cadastro da minha conta
    Para facilitar no preenchimento da checkout com os dados de pagamento

    Contexto: Pagina de Meus dados no Minha conta
        Dado um usuario esta na pagina de Meus dados do Minha conta

        @adicionar_cartao 
        Cenario: Adicionar um novo cartão de crédito
            Dado um usuario que não tenha nenhum cartão cadastrado
            Quando adiciona um novo cartao de credito da bandeira 'Visa'
            Entao é exibido o cartao no cadastro de pagamentos

        @remover_cartao
        Cenario: Remover um cartão de crédito
            Dado um usuario que tenha um cartao de credito cadastrado
            Quando escolhe 'Excluir este cartão'
            Entao não é exibido o cartao no cadastro de pagamentos

        @adicionar_cartoes
        Cenario: Adicionar todas as bandeiras de cartao de credito
            Dado um usuario que não tenha nenhum cartão cadastrado
            Quando adiciona os cartoes:
                | bandeira         |
                | Visa             |
                | American Express |
                | Diners           |
                | Mastercard       |
                | Hipercard        |
                | Elo              |
            Entao é exibido todos os cartoes adicionados no cadastro de pagamentos
        
        @cartao_checkout
        Cenario: Utilizar cartoes de creditos cadastrados na minha conta para preenchimento da checkout
            Dado que tenho cartoes de creditos cadastrados na minha conta
            Quando escolher comprar uma recomendaçao no site
            Entao é exibido os cartoes cadastrados na checkout

        @tentativa_cartao 
        Esquema do Cenario: Tentativa de adicionar cartao com campos obrigatorios nao preenchidos
            Quando adiciona o cartao de credito com os dados:
                | bandeira   | <bandeira>    |
                | num_cartao | <num_cartao>  |
                | mes        | <mes>         | 
                | ano        | <ano>         | 
                | nome       | <nome>        | 
                | cpf        | <cpf>         |
            Entao é exibido a mensagem de alerta 'Campo obrigatório.'  

            Exemplos:
                | bandeira | num_cartao       | mes | ano  | nome             | cpf         |
                | Visa     |                  | 01  | 2028 | Graziele Oriundi | 19100000000 |
                | Visa     | 4111111111111111 |     |      | Graziele Oriundi | 19100000000 |
                | Visa     | 4111111111111111 | 01  | 2028 |                  | 19100000000 |
                | Visa     | 4111111111111111 | 01  | 2028 | Graziele Oriundi |             |

        @tentativa_cartao
        Esquema do Cenario: Tentativa de adicionar cartao com campos obrigatorios do endereco nao preenchidos
            Quando adiciona o cartao de credito
            E adiciona o endereco com os dados:
                | cep      | <cep>       |
                | endereco | <endereco>  | 
                | numero   | <numero>    | 
                | bairro   | <bairro>    |
                | cidade   | <cidade>    | 
                | estado   | <estado>    |
            Entao é exibido a mensagem de alerta 'Campo obrigatório.'

            Exemplos:
                | cep       | endereco          | numero  | bairro | cidade             | estado    | 
                |           | Rua Manoel Coelho | 600     | Centro | São Caetano do Sul | São Paulo | 
                | 00000-000 |                   | 600     | Centro | São Caetano do Sul | São Paulo | 
                | 00000-000 | Rua Manoel Coelho |         | Centro | São Caetano do Sul | São Paulo | 
                | 00000-000 | Rua Manoel Coelho | 600     |        | São Caetano do Sul | São Paulo | 
                | 00000-000 | Rua Manoel Coelho | 600     | Centro |                    | São Paulo | 
                | 00000-000 | Rua Manoel Coelho | 600     | Centro | São Caetano do Sul |           |

        @tentativa_cartao 
        Cenario: Tentativa de adicionar cartao com nome do titular com mais de 25 caracteres
            Quando adiciona um novo cartao de credito com nome do titular com mais de 25 caracteres
            Entao é exibido a mensagem de alerta 'Digite no máximo 25 caracteres'
        
        @tentativa_cartao
        Cenario: Tentativa de adicionar cartao com nome do titular com menos de 3 caracteres
            Quando adiciona um novo cartao de credito com nome do titular com menos de 3 caracteres
            Entao é exibido a mensagem de alerta 'Digite pelo menos 3 caracteres'
        
        @tentativa_cartao @cpf_invalido
        Cenario: Tentativa de adicionar cartao com cpf do titular inválido
            Quando adiciona um novo cartao de credito com cpf do titular inválido
            Entao é exibido a mensagem de alerta 'CPF Inválido.'

        @tentativa_cartao @cartao_incompleto
        Cenario: Tentativa de adicionar cartao com numero incompleto
            Quando adiciona um novo cartao de credito com numero incompleto
            Entao é exibido a mensagem de alerta 'Cartão inválido.'
        
        @tentativa_cartao
        Cenario: Tentativa de adicionar cartao com numero que nao pertence a bandeira
            Quando adiciona um novo cartao de credito com numero que nao pertence a bandeira
            Entao é exibido a mensagem de alerta 'Cartão inválido.'

        @tentativa_cartao
        Cenario: Tentativa de adicionar cartao com a validade do cartao menor que o mes atual
            Quando adiciona um novo cartao de credito com a validade do cartao menor que o mes atual
            Entao é exibido a mensagem de alerta 'Mês/ano Inválido.'
