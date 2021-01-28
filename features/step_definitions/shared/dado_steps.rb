# encoding: UTF-8
# frozen_string_literal: true

# HOME

Dado('um usuario que acessa a pagina inicial') do
  # home_page.load
  visit '/'
end

# SO IDA
Dado('um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino nacional') do
  home_page.motor do |motor_busca|
    motor_busca.escolher_tipo_aereo('oneway')
    motor_busca.escolher_origem_nacional
    motor_busca.escolher_destino_nacional
    motor_busca.escolher_data('oneway')
    @total_passageiros = 1
    motor_busca.adicionar_passageiros(1, 0, 0)
    motor_busca.confirmar_pesquisa
  end
end

Dado('um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino internacional') do
  home_page.motor do |motor_busca|
    motor_busca.escolher_tipo_aereo('oneway')
    motor_busca.escolher_origem_internacional
    motor_busca.escolher_destino_internacional
    motor_busca.escolher_data('oneway')
    @total_passageiros = 1
    motor_busca.adicionar_passageiros(1, 0, 0)
    motor_busca.confirmar_pesquisa
  end
end

Dado('um usuario que faz uma pesquisa de aereo só ida para o destino {string}') do |destino|
  @home_page.motor do |motor_busca|
    motor_busca.escolher_tipo_aereo('oneway')
    motor_busca.escolher_destino(destino)
    motor_busca.escolher_data('oneway')
    @total_passageiros = 1
    motor_busca.confirmar_pesquisa
  end
end

# IDA E VOLTA
Dado('um usuario que faz uma pesquisa de passagens aereas ida e volta para qualquer destino internacional') do
  home_page.motor do |motor_busca|
    motor_busca.escolher_tipo_aereo('roundtrip')
    motor_busca.escolher_origem_internacional
    motor_busca.escolher_destino_internacional
    motor_busca.escolher_data('roundtrip')
    @total_passageiros = 1
    motor_busca.adicionar_passageiros(1, 0, 0)
    motor_busca.confirmar_pesquisa
  end
end

Dado('um usuario que faz uma pesquisa de passagens aereas ida e volta para qualquer destino nacional') do
  home_page.motor do |motor_busca|
    motor_busca.escolher_tipo_aereo('roundtrip')
    motor_busca.escolher_origem_nacional
    motor_busca.escolher_destino_nacional
    motor_busca.escolher_data('roundtrip')
    @total_passageiros = 1
    motor_busca.adicionar_passageiros(1, 0, 0)
    motor_busca.confirmar_pesquisa
  end
end

Dado('um usuario que faz uma pesquisa de aereo ida e volta com a origem {string} e destino {string}') do |origem, destino|
  home_page.motor do |motor_busca|
    @trecho = 'roundtrip'
    motor_busca.escolher_tipo_aereo(@trecho)
    @origem = motor_busca.escolher_origem(origem)
    @destino = motor_busca.escolher_destino(destino)
    @dt_ida = motor_busca.escolher_data_ida
    @dt_volta = motor_busca.escolher_data_volta
    @total_passageiros = 1
    motor_busca.adicionar_passageiros(1, 0, 0)
    motor_busca.confirmar_pesquisa
  end
end

# PACOTES
Dado('que quero fazer uma reserva de pacote para qualquer destino') do
  home_page.motor.escolher_pacotes
  home_page.motor.escolher_origem_internacional
  home_page.motor.escolher_destino_internacional
  home_page.motor.escolher_data_ida
  home_page.motor.escolher_data_volta_pacotes('10')
  home_page.motor.input_quartos_passageiros_classe.click
  @total_passageiros = 2
  home_page.motor.adicionar_passageiros_quarto(1, 2, 0, 0)
  home_page.motor.btn_aplicar.click
  click_on 'Pesquisar'
end

# MINHA CONTA
Dado('um usuario esta na pagina de Meus dados do Minha conta') do
  steps %(
    Dado um usuario que esta na pagina de login do minha conta
    Quando realiza o login preenchendo e-mail e senha corretos
    Entao a autenticacao é realizada com sucesso
  )
  home_page.nome_usuario.click
  click_on 'Meus dados'
  expect(page).to have_content('MEUS DADOS')
end

Dado('um usuario que esta na pagina de login do minha conta') do
  home_page.load
  meus_dados_page.logout if meus_dados_page.has_nome_usuario?(wait: 1.5)
  expect(page).to have_link 'Entrar'
  click_link 'Entrar'
end
