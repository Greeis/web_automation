#language: pt

@smoke_pacote
Funcionalidade: Fechamento de pacote
    Como viajante
    Quero realizar uma compra de um pacote
    Para que eu possa fazer a minha viagem

    Contexto: Pagina Inicial
        Dado um usuario que acessa a pagina inicial

        @pacote_um_quarto
        Cenario: Fechamento de pacote com um quarto
            Dado um usuario que deseja realizar uma reserva de pacote para o destino 'Buenos Aires'
            Quando escolhe a primeira sugestao de pacote
            E preenche os dados na pagina checkout
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva

        @pacote_dois_quartos
        Cenario: Fechamento de pacote com dois quartos
            Dado um usuario que deseja realizar uma reserva de pacote com dois quartos para o destino 'Santiago'
            Quando escolhe a primeira sugestao de pacote
            E preenche os dados na pagina checkout
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva

        @pacote_tres_quartos
        Cenario: Fechamento de pacote com tres quartos
            Dado um usuario que deseja realizar uma reserva de pacote com três quartos para o destino 'Montevidéu'
            Quando escolhe a primeira sugestao de pacote
            E preenche os dados na pagina checkout
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva

        @pacote_quatro_quartos
        Cenario: Fechamento de pacote com tres quartos
            Dado um usuario que deseja realizar uma reserva de pacote com quartro quartos para o destino 'Buenos Aires'
            Quando escolhe a primeira sugestao de pacote
            E preenche os dados na pagina checkout
            E finaliza o pedido aceitando os termos de condicoes de compra
            Entao é exibido a pagina de confirmação com as informações da reserva
