# encoding: UTF-8
# frozen_string_literal: true

Dado('um usuario que faz uma pesquisa de passagens aereas para {int} destinos quaisquer') do |num_dest|
  resultado_ok = nil
  repetindo = 0
  @total_passageiros = 1
  while resultado_ok != true && repetindo <= 4
    home_page.load
    home_page.motor.escolher_tipo_aereo('multi destinos')
    home_page.motor.escolher_multidestinos_nacionais(num_dest)
    home_page.motor.confirmar_pesquisa
    resultado_ok = home_page.retornou_resultado?
    repetindo += 1
  end
end

###################################
#                                 #
#           SmokeTest             #
#                                 #
###################################

Quando('faz uma pesquisa de passagens aereas para qualquer destino nacional sendo ida e volta') do
  home_page.motor do |motor_busca|
    motor_busca.escolher_tipo_aereo('roundtrip')
    @origem = motor_busca.escolher_origem_nacional
    @destino = motor_busca.escolher_destino_nacional
    @dt_ida = motor_busca.escolher_data_ida
    @dt_volta = motor_busca.escolher_data_volta
    @adultos = 1
    @criancas = 0
    @bebes = 0
    @total_passageiros = @adultos + @criancas + @bebes
    motor_busca.adicionar_passageiros(@adultos, @criancas, @bebes)
    motor_busca.confirmar_pesquisa
  end
end

Quando('faz uma pesquisa de passagens aereas para qualquer destino internacional sendo ida e volta') do
  home_page.motor do |motor_busca|
    motor_busca.escolher_tipo_aereo('roundtrip')
    @origem = motor_busca.escolher_origem_internacional
    @destino = motor_busca.escolher_destino_internacional
    @dt_ida = motor_busca.escolher_data_ida
    @dt_volta = motor_busca.escolher_data_volta
    @adultos = 1
    @criancas = 0
    @bebes = 0
    @total_passageiros = @adultos + @criancas + @bebes
    motor_busca.adicionar_passageiros(@adultos, @criancas, @bebes)
    motor_busca.confirmar_pesquisa
  end
end

Entao('é exibido a pagina de resultados com a recomendações de acordo com a pesquisa') do
  steps %(
    Entao exibe a pagina de resultados de acordo com a busca
  )
end

Entao('é exibido a pagina checkout com os valores iguais a escolha') do
  within_window @checkout_window do
    expect(checkout_page).to have_no_modal_aviso
    expect(checkout_page).to have_valor_total_reserva
    expect(checkout_page.validar_qtd_adulto(@adultos)).to be true
    # expect(checkout_page.validar_qtd_crianca(@criancas)).to be true
    # expect(checkout_page.validar_qtd_bebe(@bebes)).to be true
    dif = @recomendacao_escolhida.prices.vl_total - checkout_page.valor_total
    expect(dif).to match a_value <= 2
  end
end

Entao('é exibido as informacoes dos voo iguais a escolha') do
  within_window @checkout_window do
    checkout_page.info_voo.count.times do |i|
      expect(checkout_page.info_voo[i].text).to have_content @recomendacao_escolhida.flights[i].classe
      expect(checkout_page.info_voo[i].text).to have_content @recomendacao_escolhida.flights[i].destino.iata
      expect(checkout_page.info_voo[i].text).to have_content @recomendacao_escolhida.flights[i].origem.iata
    end
  end
end

Entao('é exibido as informacoes importantes') do
  within_window @checkout_window do
    expect(checkout_page.txt_regra_cancelamento[0]).to have_content 'CANCELAMENTO GRÁTIS:'
    expect(checkout_page.info_importantes).to have_content 'POLÍTICA DE ALTERAÇÕES E CANCELAMENTOS DA COMPANHIA AÉREA'
  end
end

Quando('preenche os dados dos passageiros') do
  within_window @checkout_window do
    expect(checkout_page).to have_no_modal_aviso
    expect(checkout_page).to have_valor_total_reserva
    checkout_page.incluir_email
    @passageiros_adicionados = checkout_page.incluir_passageiros(@total_passageiros)
  end
end

Quando('adiciona mais um novo passageiro adulto') do
  within_window @checkout_window do
    @passageiros_adicionados.push(checkout_page.adicionar_novo_passageiro_adulto)
    expect(checkout_page.has_no_loader_central?).to be true
    @adultos += 1
    @total_passageiros += 1
  end
end

Entao('é exibido o valor total recalculado com mais um adulto') do
  within_window @checkout_window do
    expect(checkout_page.validar_qtd_adulto(@adultos)).to be true
    dif = (@recomendacao_escolhida.prices.vl_pessoa * @adultos) - checkout_page.valor_adulto
    expect(dif).to match a_value <= 2
  end
end

Quando('escolhe a forma de pagamento com cartao de credito') do
  within_window @checkout_window do
    checkout_page.incluir_pagamento_cartao('Visa', '1x')
    checkout_page.incluir_endereco
    checkout_page.incluir_contato
  end
end

Entao('é exibido os nomes dos passageiros') do
  within_window @checkout_window do
    @total_passageiros.times do |i|
      expect(confirmation_page.pax_rows[i]).to have_content @passageiros_adicionados[i].nome.upcase
      expect(confirmation_page.pax_rows[i]).to have_content @passageiros_adicionados[i].sobrenome.upcase
      expect(confirmation_page.pax_rows[i]).to have_content @passageiros_adicionados[i].idade
    end
  end
end

Quando('loga no minha conta') do
  steps %(
    Dado um usuario que esta na pagina de login do minha conta
    Quando realiza o login preenchendo e-mail e senha corretos
    Entao a autenticacao é realizada com sucesso
  )
end

Entao('é exibido o numero da reserva gerada') do
  expect(page).to have_content @numero_reserva
end

Entao('é exibido as regras de cancelamento gratis') do
  within_window @checkout_window do
    expect(confirmation_page.titulo_modal_cancelamento.text).to have_content 'Cancelar Pedido'
    expect(confirmation_page.reserva_modal_cancelamento.text).to have_content @numero_reserva
    expect(confirmation_page.info_importante_cancel.text).to have_content MSG_CONFIRMATION['cancelamento']['cartao']['info_important'][0]
    expect(confirmation_page.info_importante_cancel.text).to have_content MSG_CONFIRMATION['cancelamento']['cartao']['info_important'][1]
    expect(confirmation_page.info_importante_cancel.text).to have_content MSG_CONFIRMATION['cancelamento']['cartao']['info_important'][2]
    expect(confirmation_page.termos_cancelamento.text).to have_content MSG_CONFIRMATION['cancelamento']['cartao']['termos_cancelamento']
  end
end

Entao('o valor reembolsado deve ser R$ 0,00') do
  within_window @checkout_window do
    expect(@confirmation_page.valores_extrato_cancel[0].text).to have_content 'R$ 0,00'
    expect(@confirmation_page.valores_extrato_cancel[1].text).to have_content 'GRÁTIS*'
    expect(@confirmation_page.valores_extrato_cancel[2].text).to have_content 'R$ 0,00'
  end
end

Quando('aceita o termos de cancelamento') do
  within_window @checkout_window do
    confirmation_page.check_termo_cancelamento.click
    click_on 'Confirmar Cancelamento'
  end
end

Entao('o status da reserva deve estar em cancelamento') do
  within_window @checkout_window do
    expect(confirmation_page.pegar_msg_modal).to have_content 'Reserva cancelada com sucesso'
    sleep 0.5
    confirmation_page.bnt_cancelar.click
    expect(confirmation_page.msg_reserva).to have_content 'Conforme sua solicitação, seu pedido está cancelado.'
  end
  page.driver.browser.navigate.refresh
  expect(minha_reservas_page).to have_minhas_reservas
  status = minha_reservas_page.status_reserva(@numero_reserva)
  expect(status).to have_content 'CANCELADO'
end
