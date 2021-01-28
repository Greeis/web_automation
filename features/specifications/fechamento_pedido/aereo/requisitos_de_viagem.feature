#language: pt
@requisitos_viagem
Funcionalidade: Requisitos de Viagem
    Como viajante
    Quero saber quais sao os requisitos de viagem
    Para assim, me preparar para o embarque sem transtornos

    Contexto: Pagina Inicial
        Dado um usuario que acessa a pagina inicial

        @requisitos
        Cenario: Mostrar os requisitos de viagem no destino Australia
            Dado um usuario que faz uma pesquisa de aereo só ida para o destino 'Sydney, Kingsford Smith'
            Quando escolhe visualizar detalhes da opcao de voo
            Entao é exibido todos os requisitos de viagem na pagina de resultados

            Quando escolhe a primeira sugestao de aereo
            Entao é exibido todos os requisitos de viagem na pagina de checkout
            
            Quando preenche os dados na pagina checkout
            E finaliza o pedido
            Entao é exibido todos os requisitos de viagem na pagina de confirmacao da reserva

        @mascara @codiv
        Cenario: Mostrar o aviso de uso obrigatorio de mascara
            Dado um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino internacional
            Quando escolhe visualizar detalhes da opcao de voo
            Entao é exibido o aviso de uso obrigatorio de mascara na pagina de resultados

            Quando escolhe a primeira sugestao de aereo
            Entao é exibido o aviso de uso obrigatorio de mascara na pagina de checkout

            Quando preenche os dados na pagina checkout
            E finaliza o pedido
            Entao é exibido o aviso de uso obrigatorio de mascara na pagina de confirmacao da reserva
        
        @visto
        Cenario: Mostrar o aviso ter o visto em maos no embarque
            Dado um usuario que faz uma pesquisa de aereo só ida para o destino 'Sydney, Kingsford Smith'
            Quando escolhe visualizar detalhes da opcao de voo
            Entao é exibido o aviso ter o visto em maos no embarque na pagina de resultados

            Quando escolhe a primeira sugestao de aereo
            Entao é exibido o aviso ter o visto em maos no embarque na pagina de checkout

            Quando preenche os dados na pagina checkout
            E finaliza o pedido
            Entao é exibido o aviso ter o visto em maos no embarque na pagina de confirmacao da reserva
     
        @vacina
        Cenario: Mostrar o aviso de Certificado Internacional de Vacinação ou Profilaxia (CIVP)
            Dado um usuario que faz uma pesquisa de aereo só ida para o destino 'Luqa, Malta'
            Quando escolhe visualizar detalhes da opcao de voo
            Entao é exibido o aviso de Certificado Internacional de Vacinação ou Profilaxia (CIVP) na pagina de resultados

            Quando escolhe a primeira sugestao de aereo
            Entao é exibido o aviso de Certificado Internacional de Vacinação ou Profilaxia (CIVP) na pagina de checkout

            Quando preenche os dados na pagina checkout
            E finaliza o pedido
            Entao é exibido o aviso de Certificado Internacional de Vacinação ou Profilaxia (CIVP) na pagina de confirmacao da reserva

        @seguro_australia @seguro
        Cenario: Mostrar o aviso de contratação do Seguro Governamental OSHC
            Dado um usuario que faz uma pesquisa de aereo só ida para o destino 'Sydney, Kingsford Smith'
            Quando escolhe visualizar detalhes da opcao de voo
            Entao é exibido o aviso de contratação do Seguro Governamental OSHC na pagina de resultados

            Quando escolhe a primeira sugestao de aereo
            Entao é exibido o aviso de contratação do Seguro Governamental OSHC na pagina de checkout

            Quando preenche os dados na pagina checkout
            E finaliza o pedido
            Entao é exibido o aviso de contratação do Seguro Governamental OSHC na pagina de confirmacao da reserva

        @seguro_europa @seguro
        Cenario: Mostrar o aviso de contratação do seguro viagem obrigatorio - Tratado de Schengen
            Dado um usuario que faz uma pesquisa de aereo só ida para o destino 'Lisboa, Portugal'
            Quando escolhe visualizar detalhes da opcao de voo
            Entao é exibido o aviso que na Europa a contratação do seguro viagem obrigatorio na pagina de resultados

            Quando escolhe a primeira sugestao de aereo
            Entao é exibido o aviso que na Europa a contratação do seguro viagem obrigatorio na pagina de checkout

            Quando preenche os dados na pagina checkout
            E finaliza o pedido
            Entao é exibido o aviso que na Europa a contratação do seguro viagem obrigatorio na pagina de confirmacao da reserva

        @seguro_chipre @seguro
        Cenario: Mostrar o aviso que seguro viagem deve cobrir o tempo de permanência em Chipre
            Dado um usuario que faz uma pesquisa de aereo só ida para o destino 'Larnaca, Chipre'
            Quando escolhe visualizar detalhes da opcao de voo
            Entao é exibido o aviso que seguro viagem deve cobrir o tempo de permanência em Chipre na pagina de resultados

            Quando escolhe a primeira sugestao de aereo
            Entao é exibido o aviso que seguro viagem deve cobrir o tempo de permanência em Chipre na pagina de checkout

            Quando preenche os dados na pagina checkout
            E finaliza o pedido
            Entao é exibido o aviso que seguro viagem deve cobrir o tempo de permanência em Chipre na pagina de confirmacao da reserva

        @seguro_venezuela @seguro
        Cenario: Mostrar o aviso que a Venezuela exige cobertura mínima de USD 25 mil de seguro
            Dado um usuario que faz uma pesquisa de aereo só ida para o destino 'Caracas, Venezuela'
            Quando escolhe visualizar detalhes da opcao de voo
            Entao é exibido o aviso que a Venezuela exige cobertura mínima de seguro na pagina de resultados

            Quando escolhe a primeira sugestao de aereo
            Entao é exibido o aviso que o Venezuela exige cobertura mínima de seguro na pagina de checkout

            Quando preenche os dados na pagina checkout
            E finaliza o pedido
            Entao é exibido o aviso que o Venezuela exige cobertura mínima de seguro na pagina de confirmacao da reserva

        @seguro_cuba @seguro
        Cenario: Mostrar o aviso que Cuba exige uma cobertura de USD25 mil
            Dado um usuario que faz uma pesquisa de aereo só ida para o destino 'Havana, Cuba'
            Quando escolhe visualizar detalhes da opcao de voo
            Entao é exibido o aviso que Cuba exige uma cobertura de seguro na pagina de resultados

            Quando escolhe a primeira sugestao de aereo
            Entao é exibido o aviso que Cuba exige uma cobertura de seguro na pagina de checkout

            Quando preenche os dados na pagina checkout
            E finaliza o pedido
            Entao é exibido o aviso que Cuba exige uma cobertura de seguro na pagina de confirmacao da reserva

        @teste_covid @covid
        Cenario: Mostrar o aviso de obrigatoriedade do teste para o COVID-19 para destinos internacionais
            Dado um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino internacional
            Quando escolhe visualizar detalhes da opcao de voo
            Entao é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de resultados

            Quando escolhe a primeira sugestao de aereo
            Entao é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de checkout

            Quando preenche os dados na pagina checkout
            E finaliza o pedido
            Entao é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de confirmacao da reserva

        @nao_teste_covid @covid
        Cenario: Não mostrar o aviso de obrigatoriedade do teste para o COVID-19 para destinos nacionais
            Dado um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino nacional
            Quando escolhe visualizar detalhes da opcao de voo
            Entao não é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de resultados

            Quando escolhe a primeira sugestao de aereo
            Entao não é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de checkout

            Quando preenche os dados na pagina checkout
            E finaliza o pedido
            Entao não é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de confirmacao da reserva

