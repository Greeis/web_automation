# encoding: UTF-8
# frozen_string_literal: true

# HOME

Entao('a autenticacao é realizada com sucesso') do
  case @tipo_conta
  when 'gmail'
    expect(home_page).to have_img_usr_google
    expect(home_page.nome_usuario.text).to have_content USUARIOS['gmail']['nome_usuario']
  when 'facebook'
    expect(home_page).to have_img_usr_facebook
    expect(home_page.nome_usuario.text).to have_content USUARIOS['facebook']['nome_usuario']
  else
    binding.pry
    expect(home_page.nome_usuario.text).to have_content 'Oriundi'
  end
end

# RESULTADOS

Entao('exibe a pagina de resultados de acordo com a busca') do
  expect(recommendation_page).to have_no_result_error
  expect(recommendation_page).to have_titulo_voos
  expect(recommendation_page).to have_no_loader

  primeiro_segmento = recommendation_page.retorna_primeiro_segmento
  expect(primeiro_segmento[2]).to eql @origem.iata
  expect(primeiro_segmento[3]).to eql @origem.cidade
  expect(primeiro_segmento[4]).to eql @destino.iata
  expect(primeiro_segmento[5]).to eql @destino.cidade
  expect(primeiro_segmento[1]).to eql DateFormat.new.date_parse(@dt_ida, 1)
  expect(recommendation_page.validar_pax(@total_passageiros)).to be true

  url = URI.parse(current_url).to_s
  expect(url).to have_content @dt_ida.strftime('%d-%m-%Y')
  if @trecho.eql? 'roundtrip'
    expect(url).to have_content @dt_volta.strftime('%d-%m-%Y')
    segundo_segmento = recommendation_page.retorna_segundo_segmento
    expect(segundo_segmento[1]).to eql DateFormat.new.date_parse(@dt_volta, 1)
  end
end

# CHECKOUT

Entao('é exibido o valor cobrado de acordo com o valor apresentado na pagina checkout') do
  within_window @checkout_window do
    expect(confirmation_page.has_info_importantes?).to be true
    valor_total = confirmation_page.valor_total_pagamento
    valor_cobrado = confirmation_page.valor_total_pagamento
    dif = @recomendacao_escolhida.prices.vl_total - valor_cobrado
    expect(dif).to match a_value <= 1
    expect(valor_cobrado).to eql valor_total
  end
end

# CONFIRMATION

Entao('é exibido a pagina de confirmação com as informações da reserva') do
  within_window @checkout_window do
    expect(confirmation_page.titulo_reserva).to have_content('NÚMERO DA RESERVA')
    @numero_reserva = confirmation_page.pegar_numero_reserva
    @loc = confirmation_page.pegar_loc
    url = URI.parse(current_url).to_s
    puts "Numero do Pedido: #{@numero_reserva}"
    puts "Localizador: #{@loc}"
    puts "URL Confirmacao: #{url}"
  end
end

Entao('é exibido o resumo da reserva corretamente') do
  within_window @checkout_window do
    @recomendacao_escolhida.flights.count.times do |i|
      expect(confirmation_page.fly_rows[i]).to have_content @recomendacao_escolhida.flights[i].origem.iata
      expect(confirmation_page.fly_rows[i]).to have_content @recomendacao_escolhida.flights[i].destino.iata
      expect(confirmation_page.fly_rows[i]).to have_content @recomendacao_escolhida.flights[i].parada
      expect(confirmation_page.fly_rows[i]).to have_content DateFormat.new.date_parse(@recomendacao_escolhida.flights[i].dt_partida, 2)
      expect(confirmation_page.fly_rows[i]).to have_content TimeFormat.new.time_parse(@recomendacao_escolhida.flights[i].hr_partida)
      expect(confirmation_page.fly_rows[i]).to have_content DateFormat.new.date_parse(@recomendacao_escolhida.flights[i].dt_chegada, 2)
      expect(confirmation_page.fly_rows[i]).to have_content TimeFormat.new.time_parse(@recomendacao_escolhida.flights[i].hr_chegada)
      expect(confirmation_page.detalhes_reserva).to have_content @recomendacao_escolhida.flights[i].cia[0]
      expect(confirmation_page.detalhes_reserva).to have_content @recomendacao_escolhida.flights[i].classe
      expect(confirmation_page.detalhes_reserva).to have_content @recomendacao_escolhida.flights[i].num_voo.upcase
    end
  end
end

# MINHA CONTA

Entao('é exibido a mensagem de alerta {string}') do |mensagem|
  expect(minha_conta_page.alerta_erro.text).to have_content mensagem
end

Entao('é apresentado um alerta {string}') do |mensagem|
  expect(meus_dados_page.text_modal_aviso.text).to have_content mensagem
  click_button 'Fechar'
end
