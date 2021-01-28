#language: pt
@smoke_aereo
Funcionalidade: Reservar passagens aereas
    Como um viajante
    Quero reservar uma passagem aerea
    Para que eu possa fazer a minha viagem

    Contexto: Pagina Inicial
        Dado um usuario que acessa a pagina inicial

        @oneway 
        Cenario: Reservar aereo - Só ida
            Dado um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino nacional
            Quando escolhe a primeira sugestao de aereo
            E preenche os dados na pagina checkout
            E finaliza o pedido
            Entao é exibido a pagina de confirmação com as informações da reserva
            E é exibido o resumo da reserva corretamente
            E é exibido o valor cobrado de acordo com o valor apresentado na pagina checkout

        @roundtrip 
        Cenario: Reservar aereo - Ida e volta
            Dado um usuario que faz uma pesquisa de passagens aereas ida e volta para qualquer destino internacional
            Quando escolhe a primeira sugestao de aereo
            E preenche os dados na pagina checkout
            E finaliza o pedido
            Entao é exibido a pagina de confirmação com as informações da reserva
            E é exibido o resumo da reserva corretamente
            E é exibido o valor cobrado de acordo com o valor apresentado na pagina checkout
    
        @multidestino
        Cenario: Reservar aereo - Multi Destinos
            Dado um usuario que faz uma pesquisa de passagens aereas para 3 destinos quaisquer
            Quando escolhe a primeira sugestao de aereo
            E preenche os dados na pagina checkout
            E finaliza o pedido
            Entao é exibido a pagina de confirmação com as informações da reserva
            E é exibido o resumo da reserva corretamente
            E é exibido o valor cobrado de acordo com o valor apresentado na pagina checkout
        
        @smoke
        Cenario: Fluxo de fechamento de aereo roundtrip
            Quando faz uma pesquisa de passagens aereas para qualquer destino nacional sendo ida e volta
            Entao é exibido a pagina de resultados com a recomendações de acordo com a pesquisa

            Quando escolhe a primeira sugestao de aereo
            Entao é exibido a pagina checkout com os valores iguais a escolha
            E é exibido as informacoes dos voo iguais a escolha
            E é exibido as informacoes importantes

            Quando preenche os dados dos passageiros
            E adiciona mais um novo passageiro adulto 
            Entao é exibido o valor total recalculado com mais um adulto
            
            Quando escolhe a forma de pagamento com cartao de credito
            E finaliza o pedido
            Entao é exibido a pagina de confirmação com as informações da reserva
            E é exibido o resumo da reserva corretamente
            E é exibido os nomes dos passageiros
            E é exibido o valor cobrado de acordo com o valor apresentado na pagina checkout

        @smoke_cancelamento @stage
        Cenario: Fluxo de fechamento de aereo e cancelamento 
            Quando faz uma pesquisa de passagens aereas para qualquer destino nacional sendo ida e volta
            Entao é exibido a pagina de resultados com a recomendações de acordo com a pesquisa

            Quando escolhe a primeira sugestao de aereo
            Entao é exibido a pagina checkout com os valores iguais a escolha
            E é exibido as informacoes dos voo iguais a escolha
            E é exibido as informacoes importantes

            Quando preenche os dados dos passageiros
            E adiciona mais um novo passageiro adulto 
            Entao é exibido o valor total recalculado com mais um adulto
            
            Quando escolhe a forma de pagamento com cartao de credito
            E finaliza o pedido
            Entao é exibido a pagina de confirmação com as informações da reserva
            E é exibido o resumo da reserva corretamente
            E é exibido os nomes dos passageiros
            E é exibido o valor cobrado de acordo com o valor apresentado na pagina checkout

            Quando loga no minha conta
            E acessa a reserva pelo minha conta
            Entao é exibido o numero da reserva gerada

            Quando escolhe cancelar a reserva
            Entao é exibido as regras de cancelamento gratis
            E o valor reembolsado deve ser R$ 0,00

            Quando aceita o termos de cancelamento
            Entao o status da reserva deve estar em cancelamento
    

