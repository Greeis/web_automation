# encoding: UTF-8
# frozen_string_literal: true

Dado('um usuario que tem uma reserva realizada antes das 24 horas e sem confirmação de pagamento via cartao de credito') do
  steps %(
    Dado um usuario que acessa a pagina inicial
    Dado um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino nacional
    Quando escolhe a primeira sugestao de aereo
    E preenche os dados na pagina checkout
    E finaliza o pedido
    Entao é exibido a pagina de confirmação com as informações da reserva
  )
end

Dado('um usuario que tem uma reserva realizada antes das 24 horas e sem confirmação de pagamento via Safetypay') do
  steps %(
    Dado um usuario que acessa a pagina inicial
    Dado um usuario que faz uma pesquisa de passagens aereas só ida para qualquer destino nacional
    Quando escolhe a primeira sugestao de aereo
    E escolhe a opcao de pagamento 'Internet Banking' pelo banco 'Bradesco' sendo pessoa 'Juridica'
    E finaliza o pedido
    Entao é exibido a pagina de confirmação com as informações da reserva
  )
end

Dado('esta logado no minha conta') do
  steps %(
    Dado um usuario que esta na pagina de login do minha conta
    Quando realiza o login preenchendo e-mail e senha corretos
    Entao a autenticacao é realizada com sucesso
  )
end

Quando('aceita os termos de cancelamento antes das 24 horas sem nenhum valor a estornar') do
  within_window @checkout_window do
    expect(confirmation_page.titulo_modal_cancelamento.text).to have_content 'Cancelar Pedido'
    expect(confirmation_page.reserva_modal_cancelamento.text).to have_content @numero_reserva
    expect(confirmation_page.info_importante_cancel.text).to have_content MSG_CONFIRMATION['cancelamento']['cartao']['info_important'][0]
    expect(confirmation_page.info_importante_cancel.text).to have_content MSG_CONFIRMATION['cancelamento']['cartao']['info_important'][1]
    expect(confirmation_page.info_importante_cancel.text).to have_content MSG_CONFIRMATION['cancelamento']['cartao']['info_important'][2]
    expect(confirmation_page.termos_cancelamento.text).to have_content MSG_CONFIRMATION['cancelamento']['cartao']['termos_cancelamento']
    expect(confirmation_page.valores_extrato_cancel[0].text).to have_content 'R$ 0,00'
    expect(confirmation_page.valores_extrato_cancel[1].text).to have_content 'GRÁTIS*'
    expect(confirmation_page.valores_extrato_cancel[2].text).to have_content 'R$ 0,00'
    confirmation_page.check_termo_cancelamento.click
    click_on 'Confirmar Cancelamento'
  end
end

Quando('aceita os termos de cancelamento da solicitaçao de cancelamento antes das 24 horas') do
  within_window @checkout_window do
    within(confirmation_page.modal_solicitar_cancel) do
      expect(page).to have_content 'Solicitar Cancelamento'
      expect(page).to have_content @numero_reserva
      expect(page).to have_content MSG_CONFIRMATION['cancelamento']['safetypay']['info_important']
      expect(page).to have_content MSG_CONFIRMATION['cancelamento']['safetypay']['termos_cancelamento']
      confirmation_page.check_termo_cancelamento.click
      click_on 'Solicitar Cancelamento'
    end
  end
end

Entao('exibe a mensagem {string}') do |mensagem|
  within_window @checkout_window do
    expect(confirmation_page.pegar_msg_modal).to have_content mensagem
  end
end

Entao('exibe a mensagem que o pedido de cancelamento foi recebido e esta sendo processado') do
  within_window @checkout_window do
    expect(confirmation_page.pegar_msg_modal).to have_content MSG_CONFIRMATION['cancelamento']['safetypay']['info_cancelamento']
  end
end
