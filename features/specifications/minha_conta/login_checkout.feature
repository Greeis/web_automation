#language: pt

@login @minha_conta @login_checkout
Funcionalidade: Login na Checkout
    Como viajante cadastrado no site
    Quero acessar o minha conta com email e senha na checkout
    Para eu possa utilizar meus dados cadastrados para realizar minha compra

    Contexto: Usuario deslogado na pagina Checkout
        Dado um usuario que esta deslogado no Minha Conta
        E escolher comprar uma recomendaçao no site

        @login_checkout_email
        Cenario: Realizar login com email na pagina checkout
            Quando escolhe 'Reserve mais rápido acessando a sua conta' na pagina checkout
            E realiza o login com e-mail e senha
            Entao o usuario é autenticado com sucesso

        @login_checkout_gmail @gmail
        Cenario: Realizar login via Gmail na pagina checkout
            E escolhe 'Reserve mais rápido acessando a sua conta' na pagina checkout
            E realiza o login com uma conta Gmail 
            Entao o usuario é autenticado com sucesso
        
        @login_checkout_fabebook @facebook
        Cenario: Realizar login via Facebook na pagina checkout
            E escolhe 'Reserve mais rápido acessando a sua conta' na pagina checkout
            E realiza o login com uma conta Facebook
            Entao o usuario é autenticado com sucesso

        @tentativa_login_checkout
        Cenario: Tentativa de login na pagina checkout
            Quando escolhe 'Reserve mais rápido acessando a sua conta' na pagina checkout

            Quando realiza o login com os dados:
                | email |         |
                | senha | xpto123 |
            Entao é exibida mensagem de erro 'Campo obrigatório.'

            Quando realiza o login com os dados:
                | email | janethy.oriundi@viajanet.com.br |
                | senha |                                 |
            Entao é exibida mensagem de erro 'Campo obrigatório.'

            Quando realiza o login com os dados:
                | email | jklkjkljljjkjl@kklklçklçk |
                | senha | xpto123                   |
            Entao é exibida mensagem de erro 'E-mail inválido.'
