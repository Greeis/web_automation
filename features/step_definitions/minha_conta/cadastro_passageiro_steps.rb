# encoding: UTF-8
# frozen_string_literal: true

require './features/support/generators/generator_passageiro'
require './features/support/generators/entity/passageiro'

Dado('um usuario que não tem passageiro adicionado no cadastro') do
  meus_dados_page.form_passageiros.excluir_todos_passageiros
end

Dado('um usuario que tem um passageiro adicionado no cadastro') do
  steps %(
    Dado um usuario que não tem passageiro adicionado no cadastro
    Quando adiciona um passageiro
  )
end

Dado('um usuario que tem passageiros adicionados no cadastro') do
  steps %(
    Dado um usuario que não tem passageiro adicionado no cadastro
  )
  @lista = GeneratorPassageiro.new.generator_list_pax
  @lista.each_with_index do |pax, i|
    meus_dados_page.form_passageiros.adicionar_passageiro(pax, i)
  end
  sleep 0.5
end

Quando('adiciona um passageiro') do
  passageiro_generator = GeneratorPassageiro.new
  @passageiro = passageiro_generator.generator_primeiro_adulto
  meus_dados_page.form_passageiros.adicionar_passageiro(@passageiro, 0)
end

Quando('remove o passageiro') do
  meus_dados_page.form_passageiros.excluir_passageiro
end

Quando('adiciona os passageiros:') do |table|
  @lista_passageiros = table.hashes
  @quantidade = @lista_passageiros.length
  @lista_passageiros.each_with_index do |pax, i|
    @passageiro = Passageiro.new
    @passageiro.nome = pax[:nome]
    @passageiro.sobrenome = pax[:sobrenome]
    @passageiro.nascimento = pax[:nascimento]
    @passageiro.genero = pax[:genero]
    meus_dados_page.form_passageiros.adicionar_passageiro(@passageiro, i)
  end
end

Quando('adiciona um passageiro com a data de nascimento maior que {int} anos') do |idade|
  passageiro_generator = GeneratorPassageiro.new
  @passageiro = passageiro_generator.generator_primeiro_adulto
  idade += 1
  @passageiro.nascimento = Faker::Date.birthday(min_age: idade, max_age: idade).strftime('%d/%m/%Y')
  meus_dados_page.form_passageiros.adicionar_passageiro(@passageiro, 0)
end

Quando('adiciona um passageiro com a data de nascimento igual a data de hoje') do
  passageiro_generator = GeneratorPassageiro.new
  @passageiro = passageiro_generator.generator_primeiro_adulto
  @passageiro.nascimento = DateTime.now.strftime('%d/%m/%Y')
  meus_dados_page.form_passageiros.adicionar_passageiro(@passageiro, 0)
end

Quando('adiciona um passageiro com a data de nascimento maior que a data de hoje') do
  passageiro_generator = GeneratorPassageiro.new
  @passageiro = passageiro_generator.generator_primeiro_adulto
  @passageiro.nascimento = DateTime.now.next_day(1).strftime('%d/%m/%Y')
  meus_dados_page.form_passageiros.adicionar_passageiro(@passageiro, 0)
end

Entao('não é exibido mais o passageiro no cadastro de passageiros') do
  expect(meus_dados_page.form_passageiros.passageiros[0]).to have_no_content @passageiro.nome
end

Entao('é exibido o passageiro no cadastro de passageiros') do
  expect(meus_dados_page.form_passageiros.passageiros[0]).to have_content @passageiro.nome
end

Entao('é exibido todos os passageiros no cadastro de passageiros') do
  expect(meus_dados_page.form_passageiros.passageiros.count).to eql(@quantidade)
end

Entao('é exibido os passageiros cadastrados na pagina checkout') do
  within_window @checkout_window do
    expect(checkout_page).to have_no_modal_aviso
    expect(checkout_page).to have_valor_total_reserva
    sleep 2
    checkout_page.input_nome.click
    expect(checkout_page.passageiros.count).to eq(@lista.count)
    checkout_page.escolher_passageiro_minha_conta(@lista[0].nome)
  end
end

Entao('os dados dos passageiros devem ser iguais ao cadastro') do
  within_window @checkout_window do
    expect(checkout_page.input_nome.value).to eq(@lista[0].nome)
    expect(checkout_page.input_sobrenome.value).to eq(@lista[0].sobrenome)
    expect(checkout_page.input_nascimento.value).to eq(@lista[0].nascimento)
  end
end
