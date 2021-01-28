# encoding: UTF-8
# frozen_string_literal: true

# Classe com o mapeamento e acoes dos elementos da secao form de dados de pagamento
class FormPagamentoSection < SitePrism::Section
  element  :bandeira_visa,               '.icons-card-VI'
  elements :btn_excluir_card,            '.link-delete-card', wait: 2
  element  :btn_adicionar_card,          'a[ng-click*=showAddCard]'
  elements :cartoes,                     '#card-0'
  element  :input_numero_card,           '#numerocard'
  element  :input_mes_card,              '#month'
  element  :input_ano_card,              '#year'
  element  :input_nome_titular_card,     '#nometitularcard'
  element  :input_cpf_titular_card,      '#cpftitularcard'
  element  :input_cep_titular_card,      '#ceptitularcard'
  element  :input_endereco_card,         '#endetitularcard'
  element  :input_numero_endereco_card,  '#numerotitularcard'
  element  :input_bairro_card,           '#bairrotitularcard'
  element  :input_cidade_card,           '#cidtitularcard'
  element  :input_estado_card,           '#uftitularcard'
  elements :linhas_cartao,               '.form.formularios .ng-binding'
  element  :select_bandeira,             '#bandeira-card'

  def excluir_todos_cartoes
    return unless has_btn_excluir_card?

    btn_excluir_card[0].click while has_btn_excluir_card?
  end

  def incluir_cartao(cartao)
    btn_adicionar_card.click
    select_bandeira.find('option', text: cartao.bandeira).select_option
    input_numero_card.set cartao.numero_cartao
    input_mes_card.set cartao.mes_vencimento
    input_ano_card.set cartao.ano_vencimento
    input_nome_titular_card.set cartao.nome
    input_cpf_titular_card.set cartao.cpf
  end

  def incluir_endereco_pagamento(endereco)
    input_cep_titular_card.set endereco.cep
    input_cep_titular_card.send_keys(:tab)
    input_numero_endereco_card.click
    sleep 1
    input_numero_endereco_card.set endereco.numero_endereco
    sleep 1
    click_button 'Salvar alterações'
    sleep 1
  end

  def tentativa_endereco_pagamento(endereco)
    input_cep_titular_card.set endereco.cep
    input_endereco_card.set endereco.nome_endereco
    input_numero_endereco_card.click
    sleep 1
    input_numero_endereco_card.set endereco.numero_endereco
    sleep 1
    input_bairro_card.set endereco.bairro
    input_cidade_card.set endereco.cidade
    input_estado_card.all('option', text: endereco.estado)[0].select_option
    click_button 'Salvar alterações'
  end
end
