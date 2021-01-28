#language: pt

@motor @motor_aereo @aereo @stage
Funcionalidade: Motor de Busca de Aereo 
    Como viajante
    Quero realizar busca de aereo 
    Para que eu possa encontrar as melhores recomendacoes de voos

    Contexto: Pagina Inicial
        Dado um usuario que acessa a pagina inicial

        @home_oneway @motor_home @motor_oneway
        Cenario: Motor de busca de aereo oneway - Home
            Quando realiza uma busca de aereo 'oneway' para qualquer destino
            Entao exibe a pagina de resultados de acordo com a busca
            E o motor de busca deve estar igual a busca

        @lp_oneway @lp @motor_oneway
        Cenario: Motor de busca de aereo oneway - Landing Page Passagens Aereas
            Dado um usuario acessa a landing page de passagens aereas
            Quando realiza uma busca de aereo 'oneway' para qualquer destino
            Entao exibe a pagina de resultados de acordo com a busca
            E o motor de busca deve estar igual a busca

        @widget_oneway @motor_widget @motor_oneway
        Cenario: Motor de busca de aereo oneway - Widget
            Dado um usuario acessa a widget do ViajaNet
            Quando realiza uma busca de aereo 'oneway' para qualquer destino no motor da widget
            Entao exibe uma nova pagina de resultados de acordo com a busca
            E o motor de busca deve estar igual a busca na nova pagina

        @home_roundtrip @motor_home @motor_roundtrip
        Cenario: Motor de busca de aereo roundtrip - Home
            Quando realiza uma busca de aereo 'roundtrip' para qualquer destino
            Entao exibe a pagina de resultados de acordo com a busca
            E o motor de busca deve estar igual a busca

        @lp_roundtrip @lp @motor_roundtrip
        Cenario: Motor de busca de aereo roundtrip - Landing Page Passagens Aereas 
            Dado um usuario acessa a landing page de passagens aereas  
            Quando realiza uma busca de aereo 'roundtrip' para qualquer destino
            Entao exibe a pagina de resultados de acordo com a busca
            E o motor de busca deve estar igual a busca
        
        @2_busca @motor_roundtrip
        Cenario: Motor de busca de aereo roundtrip - Alteracao de busca 
            Dado um usuario que ja realizou uma busca de aereo qualquer
            Quando realiza a segunda busca alterando todas as informacoes
            Entao exibe a pagina de resultados de acordo com a busca
            E o motor de busca deve estar igual a busca

        @widget_roundtrip @motor_widget @motor_roundtrip
        Cenario: Motor de busca de aereo roundtrip - Widget
            Dado um usuario acessa a widget do ViajaNet
            Quando realiza uma busca de aereo 'roundtrip' para qualquer destino no motor da widget
            Entao exibe uma nova pagina de resultados de acordo com a busca
            E o motor de busca deve estar igual a busca na nova pagina

        @home_md @motor_home @motor_md
        Cenario: Motor de busca de aereo multidestinos - Home
            Quando realiza uma busca de aereo multidestinos para quaisquer destino
            Entao exibe a pagina de resultados dos destinos de acordo com busca
            E o motor de busca deve estar igual a busca dos trechos

        @lp_md @lp @motor_md
        Cenario: Motor de busca de aereo multidestinos - Landing Page Passagens Aereas 
            Dado um usuario acessa a landing page de passagens aereas  
            Quando realiza uma busca de aereo multidestinos para quaisquer destino
            Entao exibe a pagina de resultados dos destinos de acordo com busca
            E o motor de busca deve estar igual a busca dos trechos

        @widget_md @motor_widget @motor_md
        Cenario: Motor de busca de aereo multidestinos - Widget
            Dado um usuario acessa a widget do ViajaNet
            Quando realiza uma busca de aereo multidestinos para quaisquer destino no motor da widget
            Entao exibe uma nova pagina de resultados dos destinos de acordo com busca
            E o motor de busca deve estar igual a busca dos trechos na nova pagina
