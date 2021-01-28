#language: pt

@analise_risco
Funcionalidade: Fluxo de analise de risco
    Como operador do siga
    Quero realizar uma passagem aerea
    Para entre no fluxo de analise de risco

    Contexto: Pagina Inicial
        Dado um usuario que acessa a pagina inicial
        # Ter o Robot RiskAnalysisService ligado

        @accertify_aereo    
        Esquema do Cenário: Reserva de aereo com analise de risco - Accertify
            Dado um usuário que realiza uma pesquisa de aereo nacional só ida com data de partida 'menor' que '90' dias
            Quando escolhe a primeira sugestao de aereo
            E finaliza a reserva com o email '<email>'
            Entao é exibido a pagina de confirmação com as informações da reserva
            E é exibido no Siga a analise de risco da reserva em '<status_analise>' pela Accertify
            # # Validar no Siga
    
	        Exemplos:
	    	    | email                           | status_analise |
	    	    | janethy.oriundi@viajanet.com.br | ACCEPT         |
                | jorge.adelbras@viajanet.com.br  | REVIEW         |
                | testeoriundi@gmail.com          | REJECT         |

        @cybersource_aereo
        Esquema do Cenário: Reserva de aereo com analise de risco - CyberSource
            Dado um usuário que realiza uma pesquisa de aereo nacional só ida com data de partida 'maior' que '90' dias
            Quando escolhe a primeira sugestao de aereo
            E finaliza a reserva com o email '<email>'
            Entao é exibido a pagina de confirmação com as informações da reserva
            E é exibido no Siga a analise de risco da reserva em '<status_analise>' pela CyberSource
            # Validar no Siga
    
	        Exemplos:
	    	    | email                  | status_analise |
	    	    | accept@viajanet.com.br | ACCEPT         |
                | review@viajanet.com.br | REVIEW         |
                | reject@viajanet.com.br | REJECT         |