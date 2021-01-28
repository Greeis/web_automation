#language: pt
@pacotes
Funcionalidade: Fechamento de pacote com quartos não reembolsaveis
    Como usuário
    Quero realizar uma compra de um pacote com quarto não reembolsavel
    Para que eu nao consiga solicitar o reembolso do quarto

    Contexto: Pagina Inicial
        Dado um usuario que acessa a pagina inicial

        @pacotes @pacotes_internacionais @um_quarto @smoke_emissao  @quarto_nao_reembolsavel
        Cenário: Fechamento de pacote com 1 quarto não reembolsavel com pagamento parcelado
            Dado que eu quero reservar um pacote para o destino 'Buenos Aires'
            E com periodo de '10' dias
            E com os passageiros para cada quarto:
                | quarto   | adulto | crianca | bebe | 
                | Quarto 1 | 2      | 1       | 0    |
            Quando escolhe visualizar a primeira recomendacao de pacote
            E escolhe comprar o pacote com um quarto com 'Tarifa não reembolsável'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento parcelado '1x'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva

        @pacotes @pacotes_internacionais @dois_quartos @quarto_nao_reembolsavel
        Cenário: Fechamento de pacote com 2 quartos não reembolsaveis com pagamento parcelado
            Dado que eu quero reservar um pacote para o destino 'Lisboa'
            E com periodo de '10' dias
            E com os passageiros para cada quarto:
                | quarto    | adulto   | crianca   | bebe | 
                | Quarto 1  | 2        | 2         | 1    |
                | Quarto 2  | 1        | 1         | 1    | 
            Quando escolhe visualizar a primeira recomendacao de pacote
            E escolhe comprar o pacote com um quarto com 'Tarifa não reembolsável'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento parcelado '3x'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva
        
        @pacotes @pacotes_internacionais @tres_quartos @quarto_nao_reembolsavel
        Cenário: Fechamento de pacote com 3 quartos não reembolsaveis com pagamento parcelado
            Dado que eu quero reservar um pacote para o destino 'Orlando'
            E com periodo de '10' dias
            E com os passageiros para cada quarto:
                | quarto    | adulto   | crianca   | bebe |
                | Quarto 1  | 2        | 0         | 1    |
                | Quarto 2  | 1        | 1         | 1    | 
                | Quarto 3  | 1        | 1         | 1    |
            Quando escolhe visualizar a primeira recomendacao de pacote
            E escolhe comprar o pacote com um quarto com 'Tarifa não reembolsável'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento parcelado '1x'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva

        @pacotes @pacotes_internacionais @quatro_quartos @quarto_nao_reembolsavel 
        Cenário: Fechamento de pacote com 4 quartos não reembolsaveis com pagamento parcelado
            Dado que eu quero reservar um pacote para o destino 'Orlando'
            E com periodo de '10' dias
            E com os passageiros para cada quarto:
                | quarto    | adulto   | crianca   | bebe |
                | Quarto 1  | 2        | 0         | 1    |
                | Quarto 2  | 1        | 1         | 1    |
                | Quarto 3  | 1        | 1         | 1    |
                | Quarto 4  | 1        | 0         | 0    |
            Quando escolhe visualizar a primeira recomendacao de pacote
            E escolhe comprar o pacote com um quarto com 'Tarifa não reembolsável'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento parcelado '10x'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva

        @pacotes @pacotes_internacionais @um_quarto @quarto_nao_reembolsavel
        Esquema do Cenário: Fechamento de pacote com 1 quarto não reembolsavel com pagamento parcelado
            Dado que eu quero reservar um pacote para o destino '<destino>'
            E com periodo de '10' dias
            E com os passageiros para cada quarto:
                | quarto   | adulto   | crianca   | bebe   | 
                | Quarto 1 | <adulto> | <crianca> | <bebe> |
            Quando escolhe visualizar a primeira recomendacao de pacote
            E escolhe comprar o pacote com um quarto com 'Tarifa não reembolsável'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento parcelado '<parcela>'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva

            Exemplos:
                | destino       | adulto | crianca | bebe | parcela  |
                | Lisboa        | 1      | 0       | 0    | 1x       | 
                | Orlando       | 1      | 1       | 1    | 3x       | 
                | Santiago      | 1      | 0       | 0    | 10x      |