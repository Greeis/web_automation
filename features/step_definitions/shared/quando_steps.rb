# encoding: UTF-8
# frozen_string_literal: true

# RESULTADOS
Quando('escolhe a primeira sugestao de aereo') do
  @checkout_window = window_opened_by do
    expect(recommendation_page).to have_no_result_error
    expect(recommendation_page).to have_titulo_voos
    @recomendacao_escolhida = recommendation_page.escolher_salvar_recomendacao
    if (@recomendacao_escolhida.bagagem_inclusa.eql? false) && recommendation_page.has_modal_bagagem?(wait: 1)
      recommendation_page.escolher_sem_bagagem
    end
  end
end

Quando('escolher comprar uma recomendaçao no site') do
  home_page.acessar_menu_passagens_aereas
  steps %(
    Dado um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino nacional
    Quando escolhe a primeira sugestao de aereo
  )
end

# CHECKOUT

Quando('preenche os dados na pagina checkout') do
  within_window @checkout_window do
    expect(checkout_page).to have_no_modal_aviso
    expect(checkout_page).to have_valor_total_reserva
    checkout_page.incluir_email
    checkout_page.incluir_passageiros(@total_passageiros)
    checkout_page.incluir_pagamento_cartao_randomico('sem juros')
    checkout_page.incluir_endereco
    checkout_page.incluir_contato
    @recomendacao_escolhida = checkout_page.atualizar_valores(@recomendacao_escolhida)
  end
end

Quando('finaliza o pedido') do
  within_window @checkout_window do
    checkout_page.aceitar_checkout
  end
end

Quando('finaliza o pedido aceitando os termos de condicoes de compra') do
  within_window @checkout_window do
    @recomendacao_escolhida = checkout_page.atualizar_valores(@recomendacao_escolhida)
    checkout_page.aceitar_checkout
  end
end

Quando('preenche a checkout com os dados pessoais') do
  within_window @checkout_window do
    expect(checkout_page).to have_no_modal_aviso
    expect(checkout_page).to have_valor_total_reserva
    checkout_page.incluir_email
    checkout_page.incluir_passageiros(@total_passageiros)
  end
end

Quando('escolhe a opcao de pagamento parcelado {string}') do |parcela|
  within_window @checkout_window do
    checkout_page.incluir_pagamento_cartao_randomico(parcela)
    checkout_page.incluir_endereco
    checkout_page.incluir_contato
  end
end

Quando('escolhe a opcao de pagamento a vista pelo {string} e banco {string}') do |meio_pagamento, banco|
  within_window @checkout_window do
    checkout_page.incluir_pagamento_safetypay(meio_pagamento, 'Fisica', banco)
    checkout_page.incluir_endereco
    checkout_page.incluir_contato
  end
end

Quando('escolhe a opcao de pagamento {string} pelo banco {string} sendo pessoa {string}') do |meio_pagamento, banco, pessoa|
  within_window @checkout_window do
    expect(checkout_page).to have_no_modal_aviso
    expect(checkout_page).to have_valor_total_reserva
    checkout_page.incluir_email
    checkout_page.incluir_primeiro_adulto
    checkout_page.incluir_pagamento_safetypay(meio_pagamento, pessoa, banco)
    checkout_page.incluir_endereco
    checkout_page.incluir_contato
  end
end

# MINHA CONTA
Quando('acessa a reserva pelo minha conta') do
  meus_dados_page.acessar_minhas_reservas
end

Quando('escolhe cancelar a reserva') do
  @checkout_window = window_opened_by do
    minha_reservas_page.cancelar_reserva(@numero_reserva)
  end
end

# IDENTITY

Quando('realiza o login preenchendo e-mail e senha corretos') do
  email = USUARIOS['qa_1']['email']
  senha = USUARIOS['qa_1']['senha']
  identity_page.logar(email, senha)
end
