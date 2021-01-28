#language: pt

@motor @motor_pacotes @pacotes
Funcionalidade: Motor de Busca - Pacotes 
    Como viajante
    Quero realizar busca de pacotes
    Para que eu possa encontrar as melhores recomendacoes de viagens

    Contexto: Pagina Inicial
        Dado um usuario que acessa a pagina inicial

        @home_pacotes
        Cenário: Motor de busca de pacotes - Home
            Quando realiza uma busca pacotes para qualquer destino
            Entao exibe as recomendacoes de pacotes de acordo com a busca
            E o motor de busca de pacotes deve estar igual a busca

        @ver_pacotes
        Cenário: Motor de busca de pacotes - Ver pacotes
            Dado um usuario que ja realizou uma busca de pacotes qualquer
            Quando escolhe visualizar a primeira recomendacao de pacote
            Entao exibe as recomendacoes de pacotes de acordo com a busca
            E o motor de busca de pacotes deve estar igual a busca

        @alterar_voo
        Cenário: Motor de busca de pacotes - Alteracao de voo
            Dado um usuario que ja realizou uma busca de pacotes qualquer
            E escolhe visualizar a primeira recomendacao de pacote
            Quando escolhe alterar voo
            Entao exibe as recomendacoes de pacotes de acordo com a busca
            E o motor de busca de pacotes deve estar igual a busca

        @lp_pacotes
        Cenário: Motor de busca de pacotes - Landing Page Pacotes de Viagem
            Dado um usuario acessa a landing page de pacotes em uma nova aba
            Quando realiza uma busca pacotes para qualquer destino na nova aba
            Entao exibe recomendacoes de pacotes de acordo com a busca na nova aba
            E o motor de busca de pacotes deve estar igual a busca na nova aba