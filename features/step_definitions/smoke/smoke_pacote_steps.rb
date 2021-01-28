# encoding: UTF-8
# frozen_string_literal: true

Dado('um usuario que deseja realizar uma reserva de pacote para o destino {string}') do |destino|
  home_page.motor.escolher_pacotes
  home_page.motor.escolher_destino(destino)
  home_page.motor.escolher_data_ida
  home_page.motor.escolher_data_volta_pacotes('10')
  home_page.motor.input_quartos_passageiros_classe.click
  @total_passageiros = 2
  home_page.motor.adicionar_passageiros_quarto(1, 2, 0, 0)
  home_page.motor.btn_aplicar.click
  click_on 'Pesquisar'
end

Dado('um usuario que deseja realizar uma reserva de pacote com dois quartos para o destino {string}') do |destino|
  home_page.motor.escolher_pacotes
  home_page.motor.escolher_destino(destino)
  home_page.motor.escolher_data_ida
  home_page.motor.escolher_data_volta_pacotes('10')
  home_page.motor.input_quartos_passageiros_classe.click
  @total_passageiros = 4
  home_page.motor.adicionar_passageiros_quarto(1, 1, 0, 1)
  home_page.motor.adicionar_passageiros_quarto(2, 1, 1, 0)
  home_page.motor.btn_aplicar.click
  click_on 'Pesquisar'
end

Dado('um usuario que deseja realizar uma reserva de pacote com três quartos para o destino {string}') do |destino|
  home_page.motor.escolher_pacotes
  home_page.motor.escolher_destino(destino)
  home_page.motor.escolher_data_ida
  home_page.motor.escolher_data_volta_pacotes('10')
  home_page.motor.input_quartos_passageiros_classe.click
  @total_passageiros = 8
  home_page.motor.adicionar_passageiros_quarto(1, 2, 0, 0)
  home_page.motor.adicionar_passageiros_quarto(2, 2, 1, 1)
  home_page.motor.adicionar_passageiros_quarto(3, 1, 1, 0)
  home_page.motor.btn_aplicar.click
  click_on 'Pesquisar'
end

Dado('um usuario que deseja realizar uma reserva de pacote com quartro quartos para o destino {string}') do |destino|
  home_page.motor.escolher_pacotes
  home_page.motor.escolher_destino(destino)
  home_page.motor.escolher_data_ida
  home_page.motor.escolher_data_volta_pacotes('10')
  home_page.motor.input_quartos_passageiros_classe.click
  @total_passageiros = 7
  home_page.motor.adicionar_passageiros_quarto(1, 2, 0, 0)
  home_page.motor.adicionar_passageiros_quarto(2, 1, 1, 0)
  home_page.motor.adicionar_passageiros_quarto(3, 1, 0, 1)
  home_page.motor.adicionar_passageiros_quarto(4, 1, 0, 0)
  home_page.motor.btn_aplicar.click
  click_on 'Pesquisar'
end

Quando('escolhe a primeira sugestao de pacote') do
  @checkout_window = window_opened_by do
    recommendation_page.btn_ver_pacote[0].click
    recommendation_page.escolher_recomendacao_pacotes('Tarifa não reembolsável')
  end
end
