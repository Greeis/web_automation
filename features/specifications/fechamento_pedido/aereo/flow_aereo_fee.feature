#language: pt
@fee_aereo
Funcionalidade: Fechamento de aereo Fee
    Como Viajanet
    Quero seja cobrado a despesa Fee dos meus clientes
    Para aumentar minha comissão
  
    Contexto: Pagina Inicial
        Dado um usuario que acessa a pagina inicial

        @pag_parcelado @fee_parcelado @fee
        Cenario: Compra de aereo com fee e com pagamento parcelado
            Dado um usuario que faz uma pesquisa de aereo ida e volta com a origem 'Guarulhos Internacional' e destino 'Buenos Aires'
            Quando escolhe comprar pela companhia 'Aerolineas'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento parcelado 'com juros'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva
            # E é exibido no Siga a taxa 'Fee'

        @pag_avista @fee_avista
        Esquema do Cenario: Compra de aereo com fee com pagamento á vista
            Dado um usuario que faz uma pesquisa de aereo ida e volta com a origem 'Guarulhos Internacional' e destino '<destino>'
            Quando escolhe comprar pela companhia '<cia>'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento a vista pelo '<pagamento>' e banco '<banco>'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva
            # E é exibido no Siga a taxa 'Fee'

            Exemplos: 
                | destino        | cia           | pagamento              | banco    | 
                | Buenos Aires   | Aerolineas    | Transferência Bancária | Itaú     |
                | Montevidéu     | Aerolineas    | Pagamento em Dinheiro  | Loterica |
