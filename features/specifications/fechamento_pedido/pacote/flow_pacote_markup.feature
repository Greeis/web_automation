#language: pt
@markup_pacote
Funcionalidade: Fechamento de pacote Markup
    Como Viajanet
    Quero seja cobrado a despesa Markup dos meus clientes
    Para aumentar minha comissão
    
    Contexto: Pagina Inicial
        Dado um usuario que acessa a pagina inicial

        @smoke_emissao @markup
        Cenário: Compra de pacote com markup com pagamento parcelado
            Dado que quero fazer uma reserva de pacote para qualquer destino
            Quando escolhe visualizar a primeira recomendacao de pacote
            E escolhe comprar o pacote com um quarto com 'Tarifa não reembolsável'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento parcelado 'sem juros'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva
            # E tenho que ver no Siga a taxa 'Markup'