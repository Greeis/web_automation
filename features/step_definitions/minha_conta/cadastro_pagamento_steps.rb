# encoding: UTF-8
# frozen_string_literal: true

require './features/support/generators/generator_pagamento'
require './features/support/generators/generator_endereco'
require './features/support/generators/entity/pagamento'
require './features/support/generators/entity/endereco'

Dado('um usuario que não tenha nenhum cartão cadastrado') do
  meus_dados_page.form_cartoes.excluir_todos_cartoes
end

Dado('um usuario que tenha um cartao de credito cadastrado') do
  @pagamento = GeneratorPagamento.new.generator_pagamento_credito('Mastercard')
  @endereco = GeneratorEndereco.new.generator_endereco

  meus_dados_page.form_cartoes.excluir_todos_cartoes
  meus_dados_page.form_cartoes.incluir_cartao(@pagamento)
  meus_dados_page.form_cartoes.incluir_endereco_pagamento(@endereco)
end

Dado('que tenho cartoes de creditos cadastrados na minha conta') do
  meus_dados_page.form_cartoes.excluir_todos_cartoes
  @pagamentos = []
  generator_pagamento = GeneratorPagamento.new
  @pagamentos.push(generator_pagamento.generator_pagamento_credito('Mastercard'))
  @pagamentos.push(generator_pagamento.generator_pagamento_credito('Visa'))
  @endereco = GeneratorEndereco.new.generator_endereco
  @pagamentos.each do |cartao|
    meus_dados_page.form_cartoes.incluir_cartao(cartao)
    meus_dados_page.form_cartoes.incluir_endereco_pagamento(@endereco)
  end
end

Quando('adiciona um novo cartao de credito da bandeira {string}') do |bandeira|
  @pagamento = GeneratorPagamento.new.generator_pagamento_credito(bandeira)
  @endereco = GeneratorEndereco.new.generator_endereco
  meus_dados_page.form_cartoes.incluir_cartao(@pagamento)
  meus_dados_page.form_cartoes.incluir_endereco_pagamento(@endereco)
end

Quando('escolhe {string}') do |txt_link|
  click_link txt_link
end

Quando('adiciona os cartoes:') do |dados|
  @cartoes = dados.hashes
  @cartoes.each do |cartao|
    bandeira = cartao['bandeira']
    @pagamento = GeneratorPagamento.new.generator_pagamento_credito(bandeira)
    @endereco = GeneratorEndereco.new.generator_endereco
    meus_dados_page.form_cartoes.incluir_cartao(@pagamento)
    meus_dados_page.form_cartoes.incluir_endereco_pagamento(@endereco)
  end
end

Quando('adiciona o cartao de credito com os dados:') do |dados|
  @pagamento = PagamentoCredito.new
  @pagamento.bandeira = dados.rows_hash['bandeira']
  @pagamento.numero_cartao = dados.rows_hash['num_cartao']
  @pagamento.mes_vencimento = dados.rows_hash['mes']
  @pagamento.ano_vencimento = dados.rows_hash['ano']
  @pagamento.cpf = dados.rows_hash['cpf']
  @pagamento.nome = dados.rows_hash['nome']
  @endereco = GeneratorEndereco.new.generator_endereco
  meus_dados_page.form_cartoes.incluir_cartao(@pagamento)
  meus_dados_page.form_cartoes.incluir_endereco_pagamento(@endereco)
end

Quando('adiciona o cartao de credito') do
  @pagamento = GeneratorPagamento.new.generator_pagamento_credito('Mastercard')
  meus_dados_page.form_cartoes.incluir_cartao(@pagamento)
end

Quando('adiciona o endereco com os dados:') do |dados|
  @endereco = Endereco.new
  @endereco.cep = dados.rows_hash['cep']
  @endereco.nome_endereco = dados.rows_hash['endereco']
  @endereco.numero_endereco = dados.rows_hash['numero']
  @endereco.bairro = dados.rows_hash['bairro']
  @endereco.cidade = dados.rows_hash['cidade']
  @endereco.estado = dados.rows_hash['estado']
  meus_dados_page.form_cartoes.tentativa_endereco_pagamento(@endereco)
end

Quando('adiciona um novo cartao de credito com nome do titular com mais de {int} caracteres') do |caracteres|
  @pagamento = GeneratorPagamento.new.generator_pagamento_credito('Mastercard')
  caracteres += 1
  string = (0...caracteres).map { ('a'..'z').to_a[rand(26)] }.join
  @pagamento.nome = string
  @endereco = GeneratorEndereco.new.generator_endereco
  meus_dados_page.form_cartoes.incluir_cartao(@pagamento)
  meus_dados_page.form_cartoes.incluir_endereco_pagamento(@endereco)
end

Quando('adiciona um novo cartao de credito com nome do titular com menos de {int} caracteres') do |caracteres|
  @pagamento = GeneratorPagamento.new.generator_pagamento_credito('Mastercard')
  caracteres -= 1
  string = (0...caracteres).map { ('a'..'z').to_a[rand(26)] }.join
  @pagamento.nome = string
  @endereco = GeneratorEndereco.new.generator_endereco
  meus_dados_page.form_cartoes.incluir_cartao(@pagamento)
  meus_dados_page.form_cartoes.incluir_endereco_pagamento(@endereco)
end

Quando('adiciona um novo cartao de credito com cpf do titular inválido') do
  @pagamento = GeneratorPagamento.new.generator_pagamento_credito('Mastercard')
  @pagamento.cpf = '99988877700'
  @endereco = GeneratorEndereco.new.generator_endereco
  meus_dados_page.form_cartoes.incluir_cartao(@pagamento)
  meus_dados_page.form_cartoes.incluir_endereco_pagamento(@endereco)
end

Quando('adiciona um novo cartao de credito com numero incompleto') do
  @pagamento = GeneratorPagamento.new.generator_pagamento_credito('Visa')
  @pagamento.numero_cartao = '411111111111111'
  @endereco = GeneratorEndereco.new.generator_endereco
  meus_dados_page.form_cartoes.incluir_cartao(@pagamento)
  meus_dados_page.form_cartoes.incluir_endereco_pagamento(@endereco)
end

Quando('adiciona um novo cartao de credito com numero que nao pertence a bandeira') do
  @pagamento = GeneratorPagamento.new.generator_pagamento_credito('Visa')
  @pagamento.numero_cartao = Faker::CreditCard::MasterCard.number
  @endereco = GeneratorEndereco.new.generator_endereco
  meus_dados_page.form_cartoes.incluir_cartao(@pagamento)
  meus_dados_page.form_cartoes.incluir_endereco_pagamento(@endereco)
end

Quando('adiciona um novo cartao de credito com a validade do cartao menor que o mes atual') do
  generator_pagamento = GeneratorPagamento.new
  dt_validade = DateTime.now
  mes = generator_pagamento.ajusta_num(dt_validade.month - 1)
  ano = dt_validade.year
  @pagamento = generator_pagamento.generator_pagamento_credito('Visa')
  @pagamento.mes_vencimento = mes
  @pagamento.ano_vencimento = ano
  @endereco = GeneratorEndereco.new.generator_endereco
  meus_dados_page.form_cartoes.incluir_cartao(@pagamento)
  meus_dados_page.form_cartoes.incluir_endereco_pagamento(@endereco)
end

Entao('é exibido todos os cartoes adicionados no cadastro de pagamentos') do
  expect(meus_dados_page.form_cartoes.cartoes.count).to eq @cartoes.count
end

Entao('é exibido o cartao no cadastro de pagamentos') do
  expect(meus_dados_page.form_cartoes.btn_adicionar_card.text).to have_content 'Adicionar outro cartão'
  expect(meus_dados_page.form_cartoes.has_bandeira_visa?).to eq true
  quatro_digitos = @pagamento.numero_cartao.to_s.gsub(/\d{12}/, '')
  validade = "#{@pagamento.mes_vencimento}/#{@pagamento.ano_vencimento}"
  linha = meus_dados_page.form_cartoes.linhas_cartao
  expect(linha[0].text).to have_content quatro_digitos
  expect(linha[1].text).to have_content validade
  expect(linha[2].text).to have_content @pagamento.nome
  expect(linha[3].text).to have_content @endereco.nome_endereco
end

Entao('não é exibido o cartao no cadastro de pagamentos') do
  sleep 2
  expect(meus_dados_page.form_cartoes.text).to have_content 'Adicione um cartão de crédito'
  expect(meus_dados_page.form_cartoes.btn_adicionar_card.text).to have_content 'Adicionar cartão'
end

Entao('é exibido os cartoes cadastrados na checkout') do
  within_window @checkout_window do
    expect(checkout_page).to have_no_modal_aviso
    expect(checkout_page).to have_valor_total_reserva
    @cartoes = checkout_page.recuperar_cartoes_cadastrados
    final_master = @pagamentos[0].numero_cartao.to_s.gsub(/\d{12}/, '')
    final_visa = @pagamentos[1].numero_cartao.to_s.gsub(/\d{12}/, '')
    visa = "#{@pagamentos[1].bandeira} (final #{final_visa})"
    master = "#{@pagamentos[0].bandeira} (final #{final_master})"
    expect(@cartoes[0]).to have_text visa
    expect(@cartoes[1]).to have_text master
  end
end
