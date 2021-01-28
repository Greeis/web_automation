# encoding: UTF-8
#language: pt

@pagamentos @cartao_credito
Funcionalidade: Fluxo de compra com pagamento cartao de credito
    Como viajante
    Quero efetuar uma compra de aereo com cartao de credito
    Para que eu possa efetivar minha compra e realizar minha viagem

    Contexto: Pagina Inicial
        Dado um usuario que acessa a pagina inicial

        @cartao_visa @pag
        Cenário: Compra de aereo com pagamento por cartao credito com juros bandeira Visa
            Dado um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino internacional
            Quando escolhe a primeira sugestao de aereo
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento credito '3x' com cartao 'Visa'
            E finaliza o pedido
            Entao é exibido a pagina de confirmação com as informações da reserva
            E é exibido as informaçoes de pagamento com cartao de credito
            E é exibido o valor cobrado de acordo com o valor apresentado na pagina checkout
        
        @cartoes_credito
        Esquema do Cenário: Compra de aereo com pagamento por cartao credito 
            Dado um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino nacional
            Quando escolhe a primeira sugestao de aereo
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento credito '<parcela>' com cartao '<cartao>'
            E finaliza o pedido
            Entao é exibido a pagina de confirmação com as informações da reserva
            E é exibido as informaçoes de pagamento com cartao de credito
            E é exibido o valor cobrado de acordo com o valor apresentado na pagina checkout

            Exemplos:
                | parcela   | cartao           |
                | sem juros | Mastercard       |
                | sem juros | Hipercard        |
                | sem juros | Elo              | 
                | sem juros | Diners           |
                | sem juros | American Express |
