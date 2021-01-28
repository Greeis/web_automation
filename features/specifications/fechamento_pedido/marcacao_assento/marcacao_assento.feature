#language: pt

Funcionalidade: Marcacao de assento
    Como viajante
    Quero realizar a marcacao de assento
    Para que eu possa viajar no melhor assento

    @assento_gratis @to_do
    Cenário: Marcação de assento - Grátis
        Dado um usuario que tem uma reserva de aereo ja confirmada da cia 'Azul' no site
        Quando escolhe marcar um assento gratis
        Entao o assento gratis deve ser confirmado com sucesso
    
    @assento_pago @to_do
    Cenário: Marcação de assento - Pago
        Dado que eu ja tenho um reserva de aereo ja confirmada da cia 'Gol' no site
        Quando escolhe marcar um assento pago
        E preenche os dados de pagamento
        Então o assento pago deve ser confirmado com sucesso
