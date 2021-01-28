#language: pt

@login @minha_conta @login_minha_conta
Funcionalidade: Login Minha Conta
    Como viajante cadastrado no site
    Quero acessar o minha conta com email e senha
    Para eu possa visualizar meus dados e minhas reservas

    Contexto: Pagina de login do Minha Conta
        Dado um usuario que esta na pagina de login do minha conta

        @login_email
        Cenario: Realizar login com dados corretos
            Quando realiza o login preenchendo e-mail e senha corretos
            Entao a autenticacao é realizada com sucesso

        @login_facebook @facebook
        Cenario: Realizar login com uma conta do Facebook
            Quando realiza o login via Facebook
            Entao a autenticacao é realizada com sucesso

        @login_gmail @gmail
        Cenario: Realizar login com uma conta do Gmail
            Quando realiza o login via Gmail
            Entao a autenticacao é realizada com sucesso
        
        @login_incorreto
        Cenario: Realizar login com dados incorretos
            Quando realiza o login preenchendo e-mail e senha incorretos
            Entao é apresentado um alerta 'E-mail ou senha não encontrados'

        @tentativa_login
        Esquema do Cenario: Tentativa de login
            Quando realiza o login com:
                | email | <email> |
                | senha | <senha> |
            Entao é exibido a mensagem de alerta '<mensagem>'
            
            Exemplos:
                | email                           | senha   | mensagem           |
                |                                 | xpto123 | Campo obrigatório. |
                | janethy.oriundi@viajanet.com.br |         | Campo obrigatório. |
                | jklkjkljljjkjl@kklklçklçk       | xpto123 | E-mail inválido.   |
