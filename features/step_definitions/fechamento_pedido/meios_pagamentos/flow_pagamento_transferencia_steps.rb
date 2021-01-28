# encoding: UTF-8
# frozen_string_literal: true

Entao('é exibido os dados bancários do {string} via {string}') do |banco, fornecedor|
  within_window @checkout_window do
    expect(page).to have_content 'Atenção, siga as instruções e realize uma transferência'
    expect(page).to have_content(banco)
    expect(page).to have_content 'SafetyPay Brasil Serviços Pagamentos Ltda' if fornecedor == 'SafetyPay'
    expect(page).to have_content 'PayMee Brasil Serviços de Pagamentos S.A' if fornecedor == 'Paymee'
    expect(page).to have_content 'DADOS PARA TRANSFERÊNCIA'
    expect(page).to have_content 'Transferência Bancária'
  end
end
