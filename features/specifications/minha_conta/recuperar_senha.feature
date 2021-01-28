#language: pt

@recuperacao_senha @minha_conta
Funcionalidade: Recuperacao de senha
    Como viajante cadastrado no site
    Quero recuperar minha senha
    Para que consiga acessar a minha conta
    # O robo MessegerConsumer deve estar ligado para o recebimento do email

    Contexto: Pagina de login do Minha Conta
        Dado um usuario que esta na pagina de login do minha conta
   
        @recuperar_senha
        Cenario: Recuperar senha com sucesso
            Dado um usuario que esqueceu a senha
            Quando informa o email que deseja recuperar a senha
            E acessa o email de recuperacao de senha na conta do Gmail
            E cria uma nova senha
            Entao a senha alterada com sucesso
            E é direcionado para a pagina Meus Dados do Minha Conta logado

        @tentativa_recuperacao_senha
        Cenario: Tentativa de recuperacao de senha
            Dado um usuario que esqueceu a senha
            Quando informa o email que deseja recuperar a senha
            E acessa o email de recuperacao de senha na conta do Gmail

            Quando salva sem informar a senha
            Entao é exibida mensagem de erro 'Campo obrigatório.'

            Quando salva sem informar a confirmacao de senha
            Entao é exibida mensagem de erro 'Campo obrigatório.'

            Quando informa uma nova senha '1234567' e a confirmacao '1234567'
            Entao é exibida mensagem de erro 'Senha fraca.'

            Quando informa uma nova senha 'Teste@123!@' e a confirmacao 'Teste@123!'
            Entao é exibida mensagem de erro 'Senha não confirmada.'

            Quando informa uma nova senha '@aB23' e a confirmacao ''
            Entao é exibida mensagem de erro 'Digite pelo menos 6 caracteres'

            Quando informa uma nova senha com mais de 90 caracteres
            Entao é exibida mensagem de erro 'Digite no máximo 90 caracteres'
            

