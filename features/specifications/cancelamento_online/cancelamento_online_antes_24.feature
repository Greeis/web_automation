#language: pt

@cancelamento_online @cancel_antes_24_horas
Funcionalidade: Cancelamento Online antes das 24 horas
    Como viajante cadastrado no site
    Quero cancelar uma reserva de aereo online antes das 24 horas pelo Minha Conta
    Para que não gere nenhum custo a mais

    @cancelar_antes_24_sem_pagamento_cartao 
    Cenario: Cancelamento de reserva antes das 24 horas sem confirmação de pagamento - Cartao de Credito
        Dado um usuario que tem uma reserva realizada antes das 24 horas e sem confirmação de pagamento via cartao de credito
        E esta logado no minha conta
        Quando acessa a reserva pelo minha conta
        E escolhe cancelar a reserva
        E aceita os termos de cancelamento antes das 24 horas sem nenhum valor a estornar
        Entao exibe a mensagem 'Reserva cancelada com sucesso'

    @cancelar_antes_24_sem_pagamento_safetypay
    Cenario: Cancelamento de reserva antes das 24 horas sem confirmação de pagamento - Safetypay
        Dado um usuario que tem uma reserva realizada antes das 24 horas e sem confirmação de pagamento via Safetypay
        E esta logado no minha conta
        Quando acessa a reserva pelo minha conta
        E escolhe cancelar a reserva
        E aceita os termos de cancelamento da solicitaçao de cancelamento antes das 24 horas
        Entao exibe a mensagem que o pedido de cancelamento foi recebido e esta sendo processado
        