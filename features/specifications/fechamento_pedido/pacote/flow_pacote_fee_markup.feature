#language: pt
@markup_fee_pacote
Funcionalidade: Fechamento de pacote Markup e Fee
    Como Viajanet
    Quero seja cobrado as despesas Fee e Markup dos meus clientes
    Para aumentar minha comissão

    Contexto: Pagina Inicial
        Dado um usuario que acessa a pagina inicial
        
        @smoke_emissao @markup_fee_pacote_parcelado
        Cenario: Compra de pacote com markup e fee com pagamento parcelado
            Dado um usuario que faz uma pesquisa de pacote com a origem 'Guarulhos Internacional' e destino 'Joinville, Lauro Carneiro'
            Quando escolhe visualizar a primeira recomendacao de pacote
            E escolhe comprar o pacote com um quarto com 'Tarifa não reembolsável'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento parcelado 'sem juros'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva
            # E tenho que ver no Siga as taxas 'Markup' e 'Fee'