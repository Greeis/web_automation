# encoding: UTF-8
# frozen_string_literal: true

Entao('é exibido o número do convenio SafetyPay') do
  within_window @checkout_window do
    expect(page).to have_content 'DADOS DE PAGAMENTO'
    expect(page).to have_content 'Convênio SafetyPay:'
    expect(page).to have_content 'SafetyPay Brasil Serviços Pagamentos Ltda'
  end
end
