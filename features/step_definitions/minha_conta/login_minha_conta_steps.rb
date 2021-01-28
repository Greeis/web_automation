# encoding: UTF-8
# frozen_string_literal: true

Quando('realiza o login preenchendo e-mail e senha incorretos') do
  email = USUARIOS['qa_1']['email']
  senha = USUARIOS['qa_1']['senha']
  identity_page.logar(email, "!#{senha}")
end

Quando('realiza o login com:') do |dados|
  email = dados.rows_hash['email']
  senha = dados.rows_hash['senha']
  identity_page.logar(email, senha)
end

Quando('realiza o login via Gmail') do
  @tipo_conta = 'gmail'
  sleep 2
  @checkout_window = window_opened_by do
    identity_page.btn_gmail.click
  end
  within_window @checkout_window do
    login_gmail.logar_gmail
  end
end

Quando('realiza o login via Facebook') do
  @tipo_conta = 'facebook'
  @checkout_window = window_opened_by do
    identity_page.btn_facebook.click
  end
  within_window @checkout_window do
    login_facebook.logar_facebook
  end
end
