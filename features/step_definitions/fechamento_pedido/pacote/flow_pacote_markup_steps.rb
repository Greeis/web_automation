# encoding: UTF-8
# frozen_string_literal: true

Dado('um usuario que faz uma pesquisa de pacote com a origem {string} e destino {string}') do |origem, destino|
  home_page.motor.escolher_pacotes
  home_page.motor.escolher_origem(origem)
  home_page.motor.escolher_destino(destino)
  home_page.motor.escolher_data_ida
  home_page.motor.escolher_data_volta_pacotes('10')
  home_page.motor.input_quartos_passageiros_classe.click
  @total_passageiros = 2
  home_page.motor.adicionar_passageiros_quarto(1, 2, 0, 0)
  home_page.motor.btn_aplicar.click
  click_on 'Pesquisar'
end
