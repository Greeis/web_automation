#language: pt

@atualizar_cadastro @minha_conta
Funcionalidade: Atualizar cadastro no Minha Conta
	Como viajante cadastrado no site
	Quero atualizar meu cadastro
    Para que eu manter minha conta atualizada

    Contexto: Pagina de Meus dados no Minha conta
        Dado um usuario esta na pagina de Meus dados do Minha conta

        @atualizar_dados
        Cenario: Atualizar cadastro
            Quando atualiza o cadastro com novos dados pessoais
            Entao os dados pessoais são atualizados com sucesso

        @tentativa_atualizar_dados
        Esquema do Cenario: Tentativa de atualizacao
            Quando atualiza cadastro com os seguintes dados:
                | nome       | <nome>       |
                | sobrenome  | <sobrenome>  |
            Entao é exibido a mensagem de alerta '<mensagem>'
            
            Exemplos:
                | nome     | sobrenome | mensagem                       |
                |          | Oriundi   | Campo obrigatório.             |
                | Janethy  |           | Campo obrigatório.             |
                | Ja       | Oriundi   | Digite pelo menos 3 caracteres |
                | Janethy  | Or        | Digite pelo menos 3 caracteres |

        @tentativa_atualizar_dados
        Cenario: Tentativa de cadastro com nome com mais de 50 caracteres
            Quando atualiza os dados com o nome com mais de 50 caracteres
            Entao é exibido a mensagem de alerta 'Digite no máximo 50 caracteres'
        
        @tentativa_atualizar_dados
        Cenario: Tentativa de cadastro com sobrenome com mais de 50 caracteres
            Quando atualiza os dados com o sobrenome com mais de 50 caracteres
            Entao é exibido a mensagem de alerta 'Digite no máximo 50 caracteres'

        @tentativa_atualizar_dados
        Cenario: Tentativa de cadastro com data de nascimento maior que 100 anos
            Quando atualiza os dados com a data de nascimento maior que 100 anos
            Entao é exibido a mensagem de alerta 'Data Inválida.'
        
        @tentativa_atualizar_dados
        Cenário: Tentativa de cadastro com data de nascimento maior que a data de hoje
            Quando atualiza os dados com a data de nascimento maior que a data de hoje
            Entao é exibido a mensagem de alerta 'Data Inválida.'
        
        @tentativa_atualizar_dados
        Cenario: Tentativa de cadastro com data de nascimento menor que 18 anos
            Quando atualiza os dados com a data de nascimento menor que 18 anos
            Entao é exibido a mensagem de alerta 'Apenas idade maior que 18.'
        
        @tentativa_atualizar_dados
        Cenario: Tentativa de cadastro com data de nascimento sem preenchimento
            Quando atualiza os dados com a data de nascimento sem preenchimento
            Entao é exibido a mensagem de alerta 'Campo obrigatório.'
