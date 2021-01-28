# encoding: UTF-8
# frozen_string_literal: true

Dado('um usuario acessa a widget do ViajaNet') do
  visit ENV_FILE[ENV_TYPE]['widget']
end

Dado('um usuario acessa a landing page de passagens aereas') do
  home_page.acessar_menu_passagens_aereas
end

Dado('um usuario que ja realizou uma busca de aereo qualquer') do
  home_page.motor do |motor_busca|
    motor_busca.escolher_tipo_aereo('roundtrip')
    motor_busca.escolher_origem_internacional
    @destino = motor_busca.escolher_destino_internacional
    @dt_ida = motor_busca.escolher_data_ida
    @dt_volta = motor_busca.escolher_data_volta
    @total_passageiros = 2
    motor_busca.adicionar_passageiros(1, 1, 0)
    @motor = motor_busca.informacoes_motor_aereo
    motor_busca.confirmar_pesquisa
  end
end

Quando('realiza a segunda busca alterando todas as informacoes') do
  expect(recommendation_page).to have_no_result_error
  expect(recommendation_page).to have_titulo_voos
  expect(recommendation_page).to have_no_loader
  home_page.motor do |motor_busca|
    motor_busca.voltar_mes_calendario(@dt_ida)
    motor_busca.escolher_tipo_aereo(@trecho)
    @origem = motor_busca.escolher_origem_internacional
    @destino = motor_busca.escolher_destino_internacional
    @dt_ida = motor_busca.escolher_data_ida
    @dt_volta = motor_busca.escolher_data_volta
    @motor_home = motor_busca.informacoes_motor_aereo
    motor_busca.confirmar_pesquisa
  end
end

Quando('realiza uma busca de aereo {string} para qualquer destino') do |trecho|
  home_page.motor do |motor_busca|
    @trecho = trecho
    motor_busca.escolher_tipo_aereo(@trecho)
    @origem = motor_busca.escolher_origem_nacional
    @destino = motor_busca.escolher_destino_nacional
    @dt_ida = motor_busca.escolher_data_ida
    @dt_volta = motor_busca.escolher_data_volta if @trecho.eql? 'roundtrip'
    @total_passageiros = 2
    motor_busca.adicionar_passageiros(1, 1, 0)
    @motor_home = motor_busca.informacoes_motor_aereo
    motor_busca.confirmar_pesquisa
  end
end

Quando('realiza uma busca de aereo {string} para qualquer destino no motor da widget') do |trecho|
  @checkout_window = window_opened_by do
    home_page.motor do |motor_busca|
      @trecho = trecho
      motor_busca.escolher_tipo_aereo(@trecho)
      @origem = motor_busca.escolher_origem_nacional
      @destino = motor_busca.escolher_destino_nacional
      @dt_ida = motor_busca.escolher_data_ida
      @dt_volta = motor_busca.escolher_data_volta if @trecho.eql? 'roundtrip'
      @total_passageiros = 2
      motor_busca.adicionar_passageiros(1, 1, 0)
      @motor_home = motor_busca.informacoes_motor_aereo
      motor_busca.confirmar_pesquisa
    end
  end
end

Quando('realiza uma busca de aereo multidestinos para quaisquer destino') do
  home_page.motor do |motor_busca|
    motor_busca.escolher_tipo_aereo('multi destinos')
    @num_dest = 3
    @destinos_pesq = motor_busca.escolher_multidestinos_nacionais(@num_dest)
    @total_passageiros = 2
    motor_busca.adicionar_passageiros(1, 1, 0)
    @motor_home = motor_busca.informacoes_motor_aereo_md(@num_dest)
    motor_busca.confirmar_pesquisa
  end
end

Quando('realiza uma busca de aereo multidestinos para quaisquer destino no motor da widget') do
  @checkout_window = window_opened_by do
    steps %(
      Quando realiza uma busca de aereo multidestinos para quaisquer destino
    )
  end
end

Entao('o motor de busca deve estar igual a busca') do
  @motor_resultados = home_page.motor.informacoes_motor_aereo
  expect(@motor_home[:origem]).to have_text(@motor_resultados[:origem])
  expect(@motor_home[:destino]).to have_text(@motor_resultados[:destino])
  expect(@motor_home[:data_ida]).to have_text(@motor_resultados[:data_ida])
  expect(@motor_home[:data_volta]).to have_text(@motor_resultados[:data_volta])
  expect(@motor_home[:passageiros_classe]).to have_text(@motor_resultados[:passageiros_classe])
end

Entao('exibe uma nova pagina de resultados de acordo com a busca') do
  within_window @checkout_window do
    steps %(
      Entao exibe a pagina de resultados de acordo com a busca
    )
  end
end

Entao('o motor de busca deve estar igual a busca na nova pagina') do
  within_window @checkout_window do
    steps %(
      Entao o motor de busca deve estar igual a busca
    )
  end
end

Entao('exibe a pagina de resultados dos destinos de acordo com busca') do
  expect(recommendation_page).to have_no_result_error
  expect(recommendation_page).to have_titulo_voos
  expect(recommendation_page).to have_no_loader
  @destinos_pesq.count.times do |i|
    segmento = recommendation_page.titulos_segmentos[i].text.split(/\n/)
    expect(segmento[1]).to eql DateFormat.new.date_parse(@destinos_pesq[i][:data], 1)
    expect(segmento[4]).to eql @destinos_pesq[i][:destino].iata
    expect(segmento[5]).to eql @destinos_pesq[i][:destino].cidade
  end
  expect(recommendation_page.validar_pax(@total_passageiros)).to be true
end

Entao('o motor de busca deve estar igual a busca dos trechos') do
  @motor_resultados = home_page.motor.informacoes_motor_aereo_md(@num_dest)
  url = URI.parse(current_url).to_s
  @destinos_pesq.count.times do |i|
    expect(url).to have_content @destinos_pesq[i][:data].strftime('%d-%m-%Y')
    expect(@motor_home[i][:destino]).to have_text(@motor_resultados[i][:destino])
    expect(@motor_home[i][:data_ida]).to have_text(@motor_resultados[i][:data_ida])
  end
end

Entao('o motor de busca deve estar igual a busca dos trechos na nova pagina') do
  within_window @checkout_window do
    steps %(
      Então o motor de busca deve estar igual a busca dos trechos
    )
  end
end

Entao('exibe uma nova pagina de resultados dos destinos de acordo com busca') do
  within_window @checkout_window do
    steps %(
      Então exibe a pagina de resultados dos destinos de acordo com busca
    )
  end
end
