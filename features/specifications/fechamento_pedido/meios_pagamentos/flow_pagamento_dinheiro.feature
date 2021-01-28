#language: pt

@pagamentos @safetypay @loterica
Funcionalidade: Fluxo de compra com pagamento em dinheiro
    Como viajante
    Quero efetuar uma compra de aereo com pagamento em dinheiro
    Para que eu possa efetivar minha compra e realizar minha viagem

    Contexto: Pagina Inicial
        Dado um usuario que acessa a pagina inicial

        @loterica_pf @pag
        Cenário: Compra de aereo com pagamento em dinheiro - Pessoa Fisica
            Dado um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino nacional
            Quando escolhe a primeira sugestao de aereo
            E escolhe a opcao de pagamento 'Pagamento em Dinheiro' pelo banco 'Loterica' sendo pessoa 'Fisica'
            E finaliza o pedido
            Entao é exibido a pagina de confirmação com as informações da reserva
            E é exibido o número do convenio SafetyPay
            E é exibido o valor cobrado de acordo com o valor apresentado na pagina checkout
            # só aparece na checkout o boleto bancario até as 3pm
        
        @loterica_pj
        Cenário: Compra de aereo com pagamento em dinheiro - Pessoa Juridica
            Dado um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino nacional
            Quando escolhe a primeira sugestao de aereo
            E escolhe a opcao de pagamento 'Pagamento em Dinheiro' pelo banco 'Loterica' sendo pessoa 'Juridica'
            E finaliza o pedido
            Entao é exibido a pagina de confirmação com as informações da reserva
            E é exibido o número do convenio SafetyPay
            E é exibido o valor cobrado de acordo com o valor apresentado na pagina checkout
            # só aparece na checkout o boleto bancario até as 3pm