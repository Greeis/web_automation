# encoding: UTF-8
# frozen_string_literal: true

Quando('atualiza o cadastro com novos dados pessoais') do
  passageiro_generator = GeneratorPassageiro.new
  @passageiro = passageiro_generator.generator_janethy
  meus_dados_page.atualizar_dados(@passageiro)
end

Quando('atualiza cadastro com os seguintes dados:') do |table|
  nome = table.rows_hash['nome']
  sobrenome = table.rows_hash['sobrenome']
  passageiro_generator = GeneratorPassageiro.new
  @passageiro = passageiro_generator.generator_janethy
  @passageiro.nome = nome
  @passageiro.sobrenome = sobrenome
  meus_dados_page.atualizar_dados(@passageiro)
end

Quando('atualiza os dados com o nome com mais de {int} caracteres') do |caracteres|
  caracteres += 1
  string = (0...caracteres).map { ('a'..'z').to_a[rand(26)] }.join
  passageiro_generator = GeneratorPassageiro.new
  @passageiro = passageiro_generator.generator_janethy
  @passageiro.nome = string
  meus_dados_page.atualizar_dados(@passageiro)
end

Quando('atualiza os dados com o sobrenome com mais de {int} caracteres') do |caracteres|
  caracteres += 1
  string = (0...caracteres).map { ('a'..'z').to_a[rand(26)] }.join
  passageiro_generator = GeneratorPassageiro.new
  @passageiro = passageiro_generator.generator_janethy
  @passageiro.sobrenome = string
  meus_dados_page.atualizar_dados(@passageiro)
end

Quando('atualiza os dados com a data de nascimento maior que {int} anos') do |idade|
  idade += 1
  nascimento = Faker::Date.birthday(min_age: idade, max_age: idade).strftime('%d/%m/%Y')
  passageiro_generator = GeneratorPassageiro.new
  @passageiro = passageiro_generator.generator_janethy
  @passageiro.nascimento = nascimento
  meus_dados_page.atualizar_dados(@passageiro)
end

Quando('atualiza os dados com a data de nascimento maior que a data de hoje') do
  nascimento = DateTime.now.next_day(1).strftime('%d/%m/%Y')
  passageiro_generator = GeneratorPassageiro.new
  @passageiro = passageiro_generator.generator_janethy
  @passageiro.nascimento = nascimento
  meus_dados_page.atualizar_dados(@passageiro)
end

Quando('atualiza os dados com a data de nascimento menor que {int} anos') do |idade|
  idade -= 1
  nascimento = Faker::Date.birthday(min_age: idade, max_age: idade).strftime('%d/%m/%Y')
  passageiro_generator = GeneratorPassageiro.new
  @passageiro = passageiro_generator.generator_janethy
  @passageiro.nascimento = nascimento
  meus_dados_page.atualizar_dados(@passageiro)
end

Quando('atualiza os dados com a data de nascimento sem preenchimento') do
  nascimento = ''
  passageiro_generator = GeneratorPassageiro.new
  @passageiro = passageiro_generator.generator_janethy
  @passageiro.nascimento = nascimento
  meus_dados_page.atualizar_dados(@passageiro)
end

Entao('os dados pessoais são atualizados com sucesso') do
  dados_salvos = meus_dados_page.recuperar_dados_basicos
  nome_completo = "#{@passageiro.nome} #{@passageiro.sobrenome}"
  expect(dados_salvos[:nome_completo]).to have_text nome_completo
  expect(dados_salvos[:nascimento]).to have_text @passageiro.nascimento
  expect(dados_salvos[:sexo]).to have_text @passageiro.genero
  expect(dados_salvos[:telefone]).to have_text '(11) 4007 1510'
  expect(dados_salvos[:celular]).to have_text '(11) 98877 6655'
end
