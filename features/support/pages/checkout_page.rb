# encoding: UTF-8
# frozen_string_literal: true

require './features/support/generators/generator_passageiro'
require './features/support/generators/generator_pagamento'
require './features/support/generators/generator_endereco'
require './features/support/generators/entity/recommendation'

# Classe com o mapeamento e acoes dos elementos da pagina de checkout
class CheckoutPage < SitePrism::Page
  element  :detalhes_voo,            '.detail-flight'
  elements :item_extrato,            '.detail-flight_item'
  element  :info_importantes,        '.information__text'
  elements :info_voo,                '.summary_item'
  element  :loader_central,          '.loader-container'
  element  :modal_alerta_tarifas,    '.md-content-alerta-tarifas'
  element  :input_email,             '#my-account_email'
  element  :input_email_contato,     '#contact_email'
  element  :input_email_confirm,     '#contact_email_confirm'
  element  :input_numero_contato,    '#contact_phonenumber_0'
  element  :opt_aceite,              '#accept-checkout'
  element  :regra_cancelamento,      '.cancel-day'
  element  :select_tipo_contato,     'select[name=contact_phone_0]'
  element  :txt_data_ida,            '.summary_text--going'
  element  :txt_data_volta,          '.summary_text--return'
  element  :txt_usr_logado,          '.my-account_logged'
  elements :txt_regra_cancelamento,  '.cancel-day__title'
  element  :valor_total_reserva,     '.detail-flight_title--total.ng-binding.ng-scope', wait: 40
  element  :valor_extrato,           '.detail-flight_value'
  elements :valores_extrato,         '.detail-flight_item .detail-flight_value'
  element  :modal_aviso,             '#modal-aviso', wait: 10

  # Form Pax
  element  :foto_adulto,             'path[id=ico-photo-passenger]'
  element  :foto_crianca,            '#ico-photo-passenger-children'
  element  :foto_bebe,               '#ico-photo-passenger-baby'
  element  :link_novo_passageiro,    '#btn-add-passenger'
  elements :linhas_passageiros,      '.passengers_line'
  element  :input_nome,              '#nome_0'
  element  :input_sobrenome,         '#lastName_0'
  element  :input_nascimento,        '#birth_0'
  element  :input_novo_nome,         '#new_passenger_name'
  element  :input_novo_sobrenome,    '#lastName_'
  element  :input_novo_nascimento,   '#birth_'
  elements :passageiros,             'a[id*=ui-id]'
  element  :select_genero,           'select[name=gender_0]'
  element  :select_novo_genero,      'select[name=gender_]'

  # Form Payment
  elements :cards_cadastrados,       'select[name=flag_card] optgroup'
  element  :input_opcao_pagamento,   'input[name=card]'
  element  :input_cep,               '#zipcode-0'
  element  :input_numero,            'input[name=number_address]'
  element  :input_cvv_card,          '#codesecure_card-0'
  element  :input_nome_card,         '#name_card-0'
  element  :input_cpf_card,          '#cpf_card-0'
  element  :input_cnpj_card,         '#cnpj_card-0'
  element  :input_numero_card,       '#number_card-0'
  element  :input_agencia,           '#bank_agency-0'
  element  :input_conta,             '#bank_account-0'
  element  :opt_pf,                  '#person'
  element  :opt_pj,                  '#corporation'
  elements :opcoes_pagamento,        'label[class*=payment_cards_line]'
  element  :select_flag_card,        'select[name=flag_card]'
  element  :select_mes_card,         'select[name=month-0]'
  element  :select_ano_card,         'select[name=year-0]'
  element  :select_banco,            '#BankCode-0'

  include Capybara::DSL

  def incluir_email(email = nil)
    email = USUARIOS['qa_1']['email'] if email.eql? nil
    @email = email
    input_email.set @email
  end

  def escolher_passageiro_minha_conta(nome)
    find('a[id*=ui-id]', text: nome).click
  end

  def incluir_passageiros(qtd_passageiros)
    qtd_passageiros -= 1
    passageiros = []
    (0..qtd_passageiros).each do |i|
      within all('.passengers_line')[i] do
        if i.zero?
          passageiros.push(incluir_primeiro_adulto)
        else
          passageiros.push(incluir_adulto(i)) if has_foto_adulto?(wait: 2)
          passageiros.push(incluir_crianca(i)) if has_foto_crianca?(wait: 2)
          passageiros.push(incluir_bebe(i)) if has_foto_bebe?(wait: 2)
        end
      end
    end
    passageiros
  end

  def incluir_primeiro_adulto
    @passageiro_generator = GeneratorPassageiro.new
    @passageiro = @passageiro_generator.generator_primeiro_adulto
    input_nome.set @passageiro.nome
    sleep TIMEOUT
    input_sobrenome.set @passageiro.sobrenome
    sleep TIMEOUT
    input_nascimento.set @passageiro.nascimento
    sleep TIMEOUT
    generos = select_genero
    generos.find('option', text: @passageiro.genero).select_option
    @passageiro
  end

  def incluir_adulto(index)
    passageiro = @passageiro_generator.generator_adulto
    find("#nome_#{index}").set passageiro.nome
    sleep TIMEOUT
    find("#lastName_#{index}").set passageiro.sobrenome
    sleep TIMEOUT
    find("#birth_#{index}").set passageiro.nascimento
    sleep TIMEOUT
    generos = find("select[name=gender_#{index}]")
    generos.find('option', text: passageiro.genero).select_option
    passageiro
  end

  def incluir_crianca(index)
    passageiro = @passageiro_generator.generator_crianca
    find("#nome_#{index}").set passageiro.nome
    sleep TIMEOUT
    find("#lastName_#{index}").set passageiro.sobrenome
    sleep TIMEOUT
    find("#birth_#{index}").set passageiro.nascimento
    sleep TIMEOUT
    generos = find("select[name=gender_#{index}]")
    generos.find('option', text: passageiro.genero).select_option
    passageiro
  end

  def incluir_bebe(index)
    passageiro = @passageiro_generator.generator_bebe
    find("#nome_#{index}").set passageiro.nome
    sleep TIMEOUT
    find("#lastName_#{index}").set passageiro.sobrenome
    sleep TIMEOUT
    find("#birth_#{index}").set passageiro.nascimento
    sleep TIMEOUT
    generos = find("select[name=gender_#{index}]")
    generos.find('option', text: passageiro.genero).select_option
    passageiro
  end

  def adicionar_novo_passageiro_adulto
    link_novo_passageiro.click
    passageiro = @passageiro_generator.generator_adulto
    input_novo_nome.set passageiro.nome
    sleep TIMEOUT
    input_novo_sobrenome.set passageiro.sobrenome
    sleep TIMEOUT
    input_novo_nascimento.set passageiro.nascimento
    sleep TIMEOUT
    select_novo_genero.select passageiro.genero
    select_novo_genero.send_keys(:tab)
    passageiro
  end

  def escolher_opcao_pagamento(opcao)
    opcoes_pagamento.each do |pagamento|
      within(pagamento) do
        case opcao
        when 'com juros'
          return input_opcao_pagamento.click if has_text?('juros', wait: 0.05)
        when 'sem juros'
          return input_opcao_pagamento.click if has_text?('Entrada', wait: 0.05)
        when 'À vista'
          return input_opcao_pagamento.click if has_text?('1x', wait: 0.05)
        else
          return input_opcao_pagamento.click if has_text?(opcao, wait: 0.05)
        end
      end
    end
  end

  def incluir_pagamento_cartao_randomico(opcao = 'com juros')
    escolher_opcao_pagamento(opcao)
    pagamento_generator = GeneratorPagamento.new
    bandeira = pagamento_generator.generator_bandeira
    pagamento = pagamento_generator.generator_pagamento_credito(bandeira)
    sleep TIMEOUT
    select_flag_card.find('option', text: pagamento.bandeira).select_option
    input_numero_card.set pagamento.numero_cartao
    sleep TIMEOUT
    select_mes_card.find('option', text: pagamento.mes_vencimento).select_option
    select_ano_card.find('option', text: pagamento.ano_vencimento).select_option
    input_cvv_card.set pagamento.cvv_cartao
    sleep TIMEOUT
    input_nome_card.set "#{@passageiro.nome} #{@passageiro.sobrenome}"
    sleep TIMEOUT
    input_cpf_card.set pagamento.cpf
  end

  def incluir_pagamento_cartao(bandeira, opcao = 'com juros')
    escolher_opcao_pagamento(opcao)
    sleep 1
    pagamento_generator = GeneratorPagamento.new
    pagamento = pagamento_generator.generator_pagamento_credito(bandeira)
    sleep TIMEOUT
    select_flag_card.find('option', text: pagamento.bandeira).select_option
    input_numero_card.set pagamento.numero_cartao
    sleep TIMEOUT
    select_mes_card.find('option', text: pagamento.mes_vencimento).select_option
    select_ano_card.find('option', text: pagamento.ano_vencimento).select_option
    input_cvv_card.set pagamento.cvv_cartao
    sleep TIMEOUT
    input_nome_card.set "#{@passageiro.nome} #{@passageiro.sobrenome}"
    sleep TIMEOUT
    input_cpf_card.set pagamento.cpf
    pagamento
  end

  def incluir_pagamento_safetypay(opcao, tipo_pessoa, banco)
    escolher_opcao_pagamento(opcao)
    sleep 3
    nome = "#{@passageiro.nome} #{@passageiro.sobrenome}"
    case tipo_pessoa
    when 'Fisica'
      opt_pf.click
      input_nome_card.set nome
      input_cpf_card.set Faker::CPF.number
    when 'Juridica'
      opt_pj.click
      input_nome_card.set nome
      input_cnpj_card.set Faker::CNPJ.numeric
    end
    return if opcao == 'Pagamento em Dinheiro'

    select_banco.find('option', text: banco).select_option
    input_agencia.set '12345'
    input_conta.set '123456789012'
  end

  def incluir_endereco
    input_cep.set '09510111'
    input_cep.send_keys(:tab)
    input_numero.click
    sleep 1
    input_numero.set '600'
  end

  def incluir_contato
    input_email_contato.set @email
    sleep TIMEOUT
    input_email_confirm.set @email
    sleep TIMEOUT
    select_tipo_contato.find('option', text: 'Celular').select_option
    sleep TIMEOUT
    input_numero_contato.set '11900000000'
  end

  def valor_total
    valor_total_reserva.text.gsub(/[R$ .]/, '').to_f
  end

  def aceitar_checkout
    opt_aceite.click
    click_on 'Finalizar compra'
  end

  def retorna_data_ida
    txt_data_ida.text.gsub(/\w{3}\n/, '')
  end

  def retorna_data_volta
    txt_data_volta.text.gsub(/\w{5}\n/, '')
  end

  def recuperar_cartoes_cadastrados
    cartoes = cards_cadastrados[0].text
    cartoes.split(/\n/)
  end

  def valor_adulto
    valores_extrato[0].text.gsub(/[R$ .]/, '').to_f
  end

  def atualizar_valores(recomendacao)
    cont = valores_extrato.count - 1
    (0..cont).each do |i|
      within(item_extrato[i]) do
        valor = valor_extrato.text.gsub(/[R$ .]/, '').to_f
        recomendacao.prices.vl_adulto = valor if has_text?('Adultos', wait: 0.05)
        recomendacao.prices.vl_crianca = valor if has_text?('Crianças', wait: 0.05)
        recomendacao.prices.vl_bebe = valor if has_text?('Bebês', wait: 0.05)
        recomendacao.prices.vl_financiamento = valor if has_text?('Custo de financiamento', wait: 0.05)
        recomendacao.prices.vl_taxas = valor if has_text?('Taxas e encargos', wait: 0.05)
      end
    end
    recomendacao.prices.vl_total = valor_total
    recomendacao
  end

  ### Validacoes

  def validar_qtd_adulto(qtd_adulto)
    detalhes = detalhes_voo.text.split(/\n/)
    detalhes[0].eql? "Adultos (#{qtd_adulto})"
  end

  def validar_qtd_crianca(qtd_crianca)
    detalhes = detalhes_voo.text.split(/\n/)
    detalhes[2].eql? "Crianças (#{qtd_crianca})"
  end

  def validar_qtd_bebe(qtd_bebe)
    detalhes = detalhes_voo.text.split(/\n/)
    detalhes[4].eql? "Bebês (#{qtd_bebe})"
  end
end
