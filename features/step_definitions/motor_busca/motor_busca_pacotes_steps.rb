# encoding: UTF-8
# frozen_string_literal: true

Dado('um usuario que ja realizou uma busca de pacotes qualquer') do
  steps %(
    Quando realiza uma busca pacotes para qualquer destino
  )
end

Dado('um usuario acessa a landing page de pacotes em uma nova aba') do
  @checkout_window = window_opened_by do
    home_page.acessar_menu_pacotes
  end
end

Quando('realiza uma busca pacotes para qualquer destino') do
  home_page.motor do |motor_busca|
    motor_busca.escolher_pacotes
    @destino = motor_busca.escolher_destino_internacional
    @data_ida = motor_busca.escolher_data_ida
    @data_volta = motor_busca.escolher_data_volta
    @motor_home_pacotes = motor_busca.informacoes_motor_pacotes
    motor_busca.confirmar_pesquisa
  end
end

Quando('escolhe alterar voo') do
  recommendation_page.alterar_voo
  expect(@recommendation_page).to have_no_loader_voos
end

Quando('realiza uma busca pacotes para qualquer destino na nova aba') do
  within_window @checkout_window do
    home_page.motor do |motor_busca|
      @destino = motor_busca.escolher_destino_internacional
      @data_ida = motor_busca.escolher_data_ida
      @data_volta = motor_busca.escolher_data_volta
      @motor_home_pacotes = motor_busca.informacoes_motor_pacotes
      motor_busca.confirmar_pesquisa
    end
  end
end

Entao('exibe as recomendacoes de pacotes de acordo com a busca') do
  url = URI.parse(current_url).to_s
  expect(recommendation_page).to have_no_loader_voos
  expect(recommendation_page).to have_no_loader_pacotes
  periodo = recommendation_page.gerar_link(@data_ida, @data_volta)
  expect(url).to have_content periodo

  expect(recommendation_page.txt_data_partida[0].text).to have_text(DateFormat.new.date_parse(@data_ida, 1))
  expect(recommendation_page.txt_data_partida[1].text).to have_text(DateFormat.new.date_parse(@data_volta, 1))
  expect(recommendation_page.txt_iata[1].text).to have_text(@destino.iata)
  expect(recommendation_page.txt_destino[1].text).to have_text(@destino.cidade)
  expect(recommendation_page.txt_iata[2].text).to have_text(@destino.iata)
  expect(recommendation_page.txt_destino[2].text).to have_text(@destino.cidade)
end

Entao('o motor de busca de pacotes deve estar igual a busca') do
  motor_resultados_pacotes = home_page.motor.informacoes_motor_pacotes
  expect(motor_home_pacotes[:origem]).to have_text(motor_resultados_pacotes[:origem])
  expect(motor_home_pacotes[:destino]).to have_text(motor_resultados_pacotes[:destino])
  expect(motor_home_pacotes[:data_ida]).to have_text(motor_resultados_pacotes[:data_ida])
  expect(motor_home_pacotes[:data_volta]).to have_text(motor_resultados_pacotes[:data_volta])
  expect(motor_home_pacotes[:quartos_passageiros_classe]).to have_text(
    motor_resultados_pacotes[:quartos_passageiros_classe]
  )
end

Entao('exibe recomendacoes de pacotes de acordo com a busca na nova aba') do
  within_window @checkout_window do
    steps %(
        Entao exibe as recomendacoes de pacotes de acordo com a busca
      )
  end
end

Entao('o motor de busca de pacotes deve estar igual a busca na nova aba') do
  within_window @checkout_window do
    steps %(
        Entao o motor de busca de pacotes deve estar igual a busca
      )
  end
end
