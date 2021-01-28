#language: pt
 
@pagamentos @safetypay @transferencia
Funcionalidade: Fluxo de compra com pagamento por transferencia bancaria
    Como viajante
    Quero efetuar uma compra de aereo com pagamento por transferencia bancaria
    Para que eu possa efetivar minha compra e realizar minha viagem
    # Verificar a configuraçao dos bancos antes de executar os testes

    Contexto: Pagina Inicial
        Dado um usuario que acessa a pagina inicial
        
        @bradesco @pag @b
        Cenário: Compra de aereo via transferencia bancaria pelo banco Bradesco
            Dado um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino nacional
            Quando escolhe a primeira sugestao de aereo
            E escolhe a opcao de pagamento 'Transferência Bancária' pelo banco 'Bradesco' sendo pessoa 'Juridica'
            E finaliza o pedido
            Entao é exibido a pagina de confirmação com as informações da reserva
            E é exibido os dados bancários do 'Bradesco' via 'SafetyPay'
            E é exibido o valor cobrado de acordo com o valor apresentado na pagina checkout
            # só aparece na checkout o boleto bancario até as 22pm
        
        @inter @pag
        Cenário: Compra de aereo via transferencia bancaria pelo banco Inter
            Dado um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino nacional
            Quando escolhe a primeira sugestao de aereo
            E escolhe a opcao de pagamento 'Transferência Bancária' pelo banco 'Inter' sendo pessoa 'Juridica'
            E finaliza o pedido
            Entao é exibido a pagina de confirmação com as informações da reserva
            E é exibido os dados bancários do 'Inter' via 'Paymee'
            E é exibido o valor cobrado de acordo com o valor apresentado na pagina checkout
            # só aparece na checkout o boleto bancario até as 22pm
        
        @safetypay
        Esquema do Cenário: Compra de aereo via transferencia bancaria SafetyPay
            Dado um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino nacional
            Quando escolhe a primeira sugestao de aereo
            E escolhe a opcao de pagamento 'Transferência Bancária' pelo banco '<banco>' sendo pessoa '<pessoa>'
            E finaliza o pedido
            Entao é exibido a pagina de confirmação com as informações da reserva
            E é exibido os dados bancários do '<banco>' via 'SafetyPay'
            E é exibido o valor cobrado de acordo com o valor apresentado na pagina checkout
            # só aparece na checkout o boleto bancario até as 22pm

            Exemplos:
                | banco                    | pessoa   |
                | Itaú                     | Fisica   |
                | Bradesco                 | Juridica |
                | Santander                | Fisica   |
                | Banco do Brasil          | Juridica |
                | Banrisul                 | Fisica   | 
                
        @paymee
        Esquema do Cenário: Compra de aereo via transferencia bancaria PayMee
            Dado um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino nacional
            Quando escolhe a primeira sugestao de aereo
            E escolhe a opcao de pagamento 'Transferência Bancária' pelo banco '<banco>' sendo pessoa '<pessoa>'
            E finaliza o pedido
            Entao é exibido a pagina de confirmação com as informações da reserva
            E é exibido os dados bancários do '<banco>' via 'Paymee'
            E é exibido o valor cobrado de acordo com o valor apresentado na pagina checkout
            # só aparece na checkout o boleto bancario até as 22pm

            Exemplos:
                | banco                    | pessoa   |
                | Caixa Econômica Federal  | Juridica | 
                | Inter                    | Fisica   | 
                | Banco Original           | Juridica | 
                | BS2                      | Fisica   | 

