# encoding: UTF-8
# frozen_string_literal: true

Dado('que eu quero reservar um pacote para o destino {string}') do |destino|
  home_page.motor.escolher_pacotes
  home_page.motor.escolher_destino(destino)
end

Dado('com periodo de {string} dias') do |periodo|
  home_page.motor.escolher_data_ida
  home_page.motor.escolher_data_volta_pacotes(periodo)
end

Dado('com os passageiros para cada quarto:') do |quartos_passageiros|
  home_page.motor.input_quartos_passageiros_classe.click
  @total_passageiros = 0
  quartos_passageiros.hashes.each do |quarto|
    num_quarto = quarto['quarto'].gsub(/[^\d]/, '').to_i
    qtd_adulto = quarto['adulto'].to_i
    qtd_crianca = quarto['crianca'].to_i
    qtd_bebe = quarto['bebe'].to_i
    @total_passageiros = @total_passageiros + qtd_adulto + qtd_crianca + qtd_bebe
    home_page.motor.adicionar_passageiros_quarto(num_quarto, qtd_adulto, qtd_crianca, qtd_bebe)
  end
  home_page.motor.btn_aplicar.click
  click_on 'Pesquisar'
end

Quando('escolhe visualizar a primeira recomendacao de pacote') do
  recommendation_page.btn_ver_pacote[0].click
end
