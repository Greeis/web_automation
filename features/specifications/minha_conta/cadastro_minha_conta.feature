#language: pt

@cadastro_minha_conta @minha_conta
Funcionalidade: Cadastro no Minha Conta
    Como viajante
    Posso fazer meu cadastro com email e senha
    Para que eu possa visualizar minhas reservas

    Contexto: Pagina de login do Minha Conta
        Dado um usuario que esta na pagina de login do minha conta

        @cadastro 
        Cenario: Cadastro com sucesso
            Quando preenche o cadastro dados validos
            E ativa o cadastro ao acessar a conta de email
            Entao é cadastrado com sucesso

        @cadastrado
        Cenario: Cadastro com usuario ja cadastrado
            Quando preenche o cadastro com dados ja cadastrados
            Entao é apresentado um alerta 'Seu email já consta na nossa base de dados.'
        
        @tentativa_cadastro
        Esquema do Cenario: Tentativa de cadastro
            Quando preenche o cadastro com os seguintes dados:
                | email             | <email>             |
                | senha             | <senha>             |
                | confirmacao_senha | <confirmacao_senha> |
            Entao é exibido a mensagem de alerta '<mensagem>'
            
            Exemplos:
                | email                  | senha     | confirmacao_senha | mensagem                       |
                |                        | xpto123   | xpto123           | Campo obrigatório.             |
                | teste@viajanet.com.br  |           | xpto123           | Campo obrigatório.             |
                | teste@viajanet.com.br  | Viaja@987 |                   | Campo obrigatório.             |
                | teste@viajanet.com.br  | Teste@123 | senha-errada      | Senha não confirmada.          |
                | hjhlhjhjhjkhjhljhjkjkl | xpto123   |                   | E-mail inválido.               |
                | teste@viajanet.com.br  | xpto1     | xpto1             | Digite pelo menos 6 caracteres |
                | teste@viajanet.com.br  | 1234567   | 1234567           | Senha fraca.                   |

        @tentativa_cadastro
        Cenario: Tentativa de cadastro com senha com mais de 90 caracteres
            Quando preenche o cadastro com a senha com mais de 90 caracteres
            Entao é exibido a mensagem de alerta 'Digite no máximo 90 caracteres'
