#language: pt

Funcionalidade: Cancelamento de aereo
    Como usuario sistema Siga
    Quero cancelar uma reserva de aereo
    Para que eu possa estornar a reserva para meu cliente

    @cancelamento_siga
    Cenário: Cancelamento de pedido - Siga
        # Dado que eu tenho uma reserva para ser cancelada
        Quando eu faço login no Siga
        E pesquiso pela reserva
        E confirmo o cancelamento
        Entao tenho que ver minha reserva com status de 'Em Cancelamento Automático'
