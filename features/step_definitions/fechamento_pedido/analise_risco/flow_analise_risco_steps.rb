# encoding: UTF-8
# frozen_string_literal: true

Dado('um usuário que realiza uma pesquisa de aereo nacional só ida com data de partida {string} que {string} dias') do |periodo, dias|
  home_page.motor do |motor_busca|
    motor_busca.escolher_tipo_aereo('oneway')
    motor_busca.escolher_origem_nacional
    motor_busca.escolher_destino_nacional
    motor_busca.escolher_periodo_dia(periodo, dias)
    @total_passageiros = 1
    motor_busca.adicionar_passageiros(1, 0, 0)
    motor_busca.confirmar_pesquisa
  end
end

Quando('finaliza a reserva com o email {string}') do |email|
  within_window @checkout_window do
    expect(checkout_page).to have_no_modal_aviso
    expect(checkout_page).to have_valor_total_reserva
    checkout_page.incluir_email(email)
    checkout_page.incluir_passageiros(@total_passageiros)
    checkout_page.incluir_pagamento_cartao('Visa', '1x')
    checkout_page.incluir_endereco
    checkout_page.incluir_contato
    @recomendacao_escolhida = checkout_page.atualizar_valores(@recomendacao_escolhida)
    checkout_page.aceitar_checkout
  end
end

Entao('é exibido no Siga a analise de risco da reserva em {string} pela Accertify') do |status|
  within_window @checkout_window do
    siga_login_page.acessar_siga
    siga_login_page.logar_siga
    expect(siga_home_page.painel_workflow.text).to have_content 'WORKFLOW'
    siga_home_page.pesquisar_ordem_servico(@numero_reserva)
    page.driver.browser.switch_to.alert.accept
    siga_ordem_servico_page.acessar_analise_risco
    expect(siga_ordem_servico_page.regristro_analise_risco).to have_content('Accertify')
    expect(siga_ordem_servico_page.regristro_analise_risco).to have_content(status)
  end
end

Entao('é exibido no Siga a analise de risco da reserva em {string} pela CyberSource') do |status|
  within_window @checkout_window do
    siga_login_page.acessar_siga
    siga_login_page.logar_siga
    expect(siga_home_page.painel_workflow.text).to have_content 'WORKFLOW'
    siga_home_page.pesquisar_ordem_servico(@numero_reserva)
    page.driver.browser.switch_to.alert.accept
    siga_ordem_servico_page.acessar_analise_risco
    expect(siga_ordem_servico_page.regristro_analise_risco).to have_content('CyberSource')
    expect(siga_ordem_servico_page.regristro_analise_risco).to have_content(status)
  end
end
