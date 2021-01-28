#language: pt

@trocar_senha @minha_conta
Funcionalidade: Trocar a senha do Minha Conta
	Como viajante cadastrado no site
	Quero realizar a troca de senha
    Para que eu possa acessar minha conta com uma nova senha

    Contexto: Pagina de Meus dados no Minha conta
        Dado um usuario esta na pagina de Meus dados do Minha conta

        @nova_senha 
        Cenario: Trocar de senha
            Dado um usuario que deseja trocar de senha
            Quando realiza a troca de senha
            Entao é apresentado um alerta 'Senha alterada com sucesso!'
            E consegue logar com a nova senha

        @senha_existente
        Cenario: Trocar de senha ja existente
            Quando realiza a troca de senha informando uma senha ja existente
            Entao é apresentado um alerta 'Não foi possível alterar sua senha. Por favor, solicite uma nova alteração.'
        
        @tentativa_troca_senha
        Esquema do Cenario: Tentativa de troca de senha
            Quando realiza a troca de senha para:
                | senha_atual       | <senha_atual>       |
                | nova_senha        | <nova_senha>        |
                | confirmacao_senha | <confirmacao_senha> |
            Entao é exibido a mensagem de alerta '<mensagem>'

            Exemplos:
                | senha_atual  | nova_senha  | confirmacao_senha  | mensagem                       |
                | ViajaNet123! | @1234       |                    | Digite pelo menos 6 caracteres |
                | ViajaNet123! | 1234567     | 123456             | Senha fraca.                   |
                | ViajaNet123! | Teste@123!@ | Teste@123!         | Senha não confirmada.          |
                |              |             |                    | Campo obrigatório.             |
                | ViajaNet123! |             |                    | Campo obrigatório.             |
                | ViajaNet123! | Teste@123!@ |                    | Campo obrigatório.             |    
    
        @tentativa_troca_senha
        Cenario: Tentativa de troca de senha com mais de 90 caracteres
            Quando realiza a troca de senha com mais de 90 caracteres
            Entao é exibido a mensagem de alerta 'Digite no máximo 90 caracteres'


