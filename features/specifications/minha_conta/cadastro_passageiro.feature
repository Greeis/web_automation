#language: pt

@cadastro_passageiro @minha_conta
Funcionalidade: Cadastro de Passageiros na Minha Conta
	Como viajante cadastrado no site
	Quero adicionar mais passageiros no cadastro da minha conta
    Para facilitar no preenchimento da checkout na inclusao de passageiros

    Contexto: Pagina de Meus dados no Minha conta
        Dado um usuario esta na pagina de Meus dados do Minha conta

        @adicionar_passageiro
        Cenário: Adicionar um passageiro
            Dado um usuario que não tem passageiro adicionado no cadastro
            Quando adiciona um passageiro
            Entao é exibido o passageiro no cadastro de passageiros

        @remover_passageiro
        Cenário: Remover um passageiro
            Dado um usuario que tem um passageiro adicionado no cadastro
            Quando remove o passageiro
            Entao não é exibido mais o passageiro no cadastro de passageiros

        @passageiros_checkout
        Cenario: Utilizar passageiros cadastrados para preenchimento da checkout
            Dado um usuario que tem passageiros adicionados no cadastro
            Quando escolher comprar uma recomendaçao no site
            Entao é exibido os passageiros cadastrados na pagina checkout
            E os dados dos passageiros devem ser iguais ao cadastro

        @passageiros
        Cenario: Adicionar mais de um passageiro
            Dado um usuario que não tem passageiro adicionado no cadastro
            Quando adiciona os passageiros:
                | nome     | sobrenome | nascimento   | genero    |
                | Graziele | Oriundi   | 27/11/2000   | Feminino  |
                | Emerson  | Oriundi   | 01/01/2017   | Masculino |
                | Leonardo | Oriundi   | 20/03/2019   | Masculino |
            Entao é exibido todos os passageiros no cadastro de passageiros

        @tentativa_add_passageiros
        Esquema do Cenario: Tentativa de cadastro de passageiros
            Dado um usuario que não tem passageiro adicionado no cadastro
            Quando adiciona os passageiros:
                | nome     | sobrenome   | nascimento    | genero    |
                | <nome>   | <sobrenome> | <nascimento>  | <genero>  |
            Entao é exibido a mensagem de alerta '<mensagem>'

            Exemplos:
                | nome     | sobrenome   | nascimento | genero    | mensagem           |
                |          | Oriundi     | 20/01/2000 | Feminino  | Campo obrigatório. |
                | Graziele |             | 20/01/2000 | Feminino  | Campo obrigatório. |
                | Graziele | Oriundi     |            | Feminino  | Campo obrigatório. |

        @tentativa_add_passageiros
        Cenário: Tentativa de cadastro com data de nascimento maior que 100 anos
            Quando adiciona um passageiro com a data de nascimento maior que 100 anos
            Entao é exibido a mensagem de alerta 'Data Inválida.'
        
        @tentativa_add_passageiros
        Cenário: Tentativa de cadastro com data de nascimento maior que a data de hoje
            Quando adiciona um passageiro com a data de nascimento igual a data de hoje
            Entao é exibido a mensagem de alerta 'Data Inválida.'
            
        @tentativa_add_passageiros
        Cenário: Tentativa de cadastro com data de nascimento maior que a data de hoje
            Quando adiciona um passageiro com a data de nascimento maior que a data de hoje
            Entao é exibido a mensagem de alerta 'Data Inválida.'
