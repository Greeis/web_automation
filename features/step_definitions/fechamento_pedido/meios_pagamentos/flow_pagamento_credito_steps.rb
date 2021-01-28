# encoding: UTF-8
# frozen_string_literal: true

Quando('escolhe a opcao de pagamento credito {string} com cartao {string}') do |parcela, bandeira|
  within_window @checkout_window do
    @bandeira = bandeira
    @pagamento = checkout_page.incluir_pagamento_cartao(bandeira, parcela)
    checkout_page.incluir_endereco
    checkout_page.incluir_contato
  end
end

Entao('é exibido as informaçoes de pagamento com cartao de credito') do
  within_window @checkout_window do
    expect(page).to have_content 'COMO SERÁ NA SUA FATURA'
    expect(page).to have_content "Cartão #1: #{@pagamento.descricao}"
  end
end
