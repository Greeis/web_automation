#language: pt

@markup_fee_aereo
Funcionalidade: Fechamento de aereo Fee e Markup
    Como Viajanet
    Quero seja cobrado as despesas Fee e Markup dos meus clientes
    Para aumentar minha comissão
    # Essa funcionalidade precisa verificar manualmente no siga se o destino e cia possuem markup e fee cadastrados

    Contexto: Pagina Inicial
        Dado um usuario que acessa a pagina inicial

        @smoke_emissao @pag_parcelado @markup_fee_parcelado @markup_fee
        Cenario: Compra de aereo com markup e fee com pagamento parcelado
            Dado um usuario que faz uma pesquisa de aereo ida e volta com a origem 'Guarulhos Internacional' e destino 'Internacional de Frankfurt'
            Quando escolhe comprar pela companhia 'Lufthansa'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento parcelado 'sem juros'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva
            # E é exibido no Siga as taxas 'Fee' e 'Markup'

        @pag_avista @markup_fee_avista
        Esquema do Cenario: Compra de aereo com markup e fee com pagamento á vista
            Dado um usuario que faz uma pesquisa de aereo ida e volta com a origem 'Guarulhos Internacional' e destino 'Internacional de Frankfurt'
            Quando escolhe comprar pela companhia 'Lufthansa'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento a vista pelo '<pagamento>' e banco '<banco>'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva
            # E tenho que ver no Siga as taxas 'Markup' e 'Fee'

            Exemplos: 
                | pagamento              | banco    | 
                | Transferência Bancária | Itaú     |
                | Pagamento em Dinheiro  | Loterica |