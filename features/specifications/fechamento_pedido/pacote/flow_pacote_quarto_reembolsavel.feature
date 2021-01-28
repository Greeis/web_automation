#language: pt

Funcionalidade: Fechamento de pacote com quartos reembolsaveis
    Como usuário
    Quero realizar uma compra de um pacote com quarto reembolsavel
    Para caso eu nao consiga viajar posso solicitar o reembolso

    Contexto: Pagina Inicial
        Dado um usuario que acessa a pagina inicial

        @pacotes @pacotes_internacionais @um_quarto @quarto_reembolsavel @smoke_emissao
        Cenário: Fechamento de pacote com 1 quarto reembolsavel com pagamento parcelado
            Dado que eu quero reservar um pacote para o destino 'Buenos Aires'
            E com periodo de '10' dias
            E com os passageiros para cada quarto:
                | quarto   | adulto | crianca | bebe | 
                | Quarto 1 | 2      | 1       | 0    |
            Quando escolhe visualizar a primeira recomendacao de pacote
            E escolhe comprar o pacote com um quarto com 'Tarifa reembolsável *'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento parcelado '3x'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva

        @pacotes @pacotes_internacionais @dois_quartos @quarto_reembolsavel
        Cenário: Fechamento de pacote com 2 quartos reembolsaveis com pagamento parcelado
            Dado que eu quero reservar um pacote para o destino 'Lisboa'
            E com periodo de '10' dias
            E com os passageiros para cada quarto:
                | quarto    | adulto   | crianca   | bebe |
                | Quarto 1  | 2        | 0         | 1    |
                | Quarto 2  | 1        | 1         | 1    |
            Quando escolhe visualizar a primeira recomendacao de pacote
            E escolhe comprar o pacote com um quarto com 'Tarifa reembolsável *'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento parcelado '1x'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva

        @pacotes @pacotes_internacionais @tres_quartos @quarto_reembolsavel
        Cenário: Fechamento de pacote com 3 quartos reembolsaveis com pagamento parcelado
            Dado que eu quero reservar um pacote para o destino 'Santiago'
            E com periodo de '10' dias
            E com os passageiros para cada quarto:
                | quarto    | adulto   | crianca   | bebe |
                | Quarto 1  | 2        | 0         | 1    |
                | Quarto 2  | 1        | 1         | 1    |
                | Quarto 3  | 1        | 1         | 1    |
            Quando escolhe visualizar a primeira recomendacao de pacote
            E escolhe comprar o pacote com um quarto com 'Tarifa reembolsável *'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento parcelado '3x'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva

        @pacotes @pacotes_internacionais @quatro_quartos @quarto_reembolsavel
        Cenário: Fechamento de pacote com 4 quartos reembolsaveis com pagamento parcelado
            Dado que eu quero reservar um pacote para o destino 'Orlando'
            E com periodo de '10' dias
            E com os passageiros para cada quarto:
                | quarto    | adulto   | crianca   | bebe |
                | Quarto 1  | 2        | 0         | 1    |
                | Quarto 2  | 1        | 1         | 1    |
                | Quarto 3  | 1        | 1         | 1    |
                | Quarto 4  | 1        | 0         | 0    |
            Quando escolhe visualizar a primeira recomendacao de pacote
            E escolhe comprar o pacote com um quarto com 'Tarifa reembolsável *'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento parcelado '10x'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva

        @pacotes @pacotes_internacionais @um_quarto @quarto_reembolsavel
        Esquema do Cenário: Fechamento de pacote com 1 quarto reembolsavel com pagamento parcelado
            Dado que eu quero reservar um pacote para o destino '<destino>'
            E com periodo de '10' dias
            E com os passageiros para cada quarto:
                | quarto   | adulto   | crianca   | bebe   | 
                | Quarto 1 | <adulto> | <crianca> | <bebe> |
            Quando escolhe visualizar a primeira recomendacao de pacote
            E escolhe comprar o pacote com um quarto com 'Tarifa reembolsável *'
            E preenche a checkout com os dados pessoais
            E escolhe a opcao de pagamento parcelado '<parcela>'
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva

            Exemplos:
                | destino       | adulto | crianca | bebe | parcela  |
                | Buenos Aires  | 1      | 0       | 0    | 1x       |
                | Miami         | 1      | 1       | 0    | 3x       | 
                | Madri         | 1      | 1       | 1    | 10x      |