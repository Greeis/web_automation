# encoding: UTF-8
# frozen_string_literal: true

Quando('preenche o cadastro dados validos') do
  minha_conta_page.escolher_criar_conta
  email = USUARIOS['qa_1']['email']
  senha = USUARIOS['qa_1']['senha']
  minha_conta_page.criar_conta(email, senha, senha)
  expect(minha_conta_page.modal_aviso.text).to have_content 'Você receberá um e-mail para ativação do seu cadastro.'
  sleep 4
  click_button 'Continuar'
end

Quando('preenche o cadastro com dados ja cadastrados') do
  minha_conta_page.escolher_criar_conta
  email = USUARIOS['qa_1']['email']
  senha = USUARIOS['qa_1']['senha']
  confirmacao_senha = USUARIOS['qa_1']['senha']
  minha_conta_page.criar_conta(email, senha, confirmacao_senha)
end

Quando('preenche o cadastro com os seguintes dados:') do |dados|
  minha_conta_page.escolher_criar_conta
  @email = dados.rows_hash['email']
  @senha = dados.rows_hash['senha']
  @confirmacao_senha = dados.rows_hash['confirmacao_senha']
  minha_conta_page.criar_conta(@email, @senha, @confirmacao_senha)
end

Quando('ativa o cadastro ao acessar a conta de email') do
  @checkout_window = window_opened_by do
    @login_gmail.acessa_gmail
    @login_gmail.logar_gmail
    sleep 10
    @login_gmail.realizar_pesquisa('Vamos ativar sua conta Viajanet?')
    @login_gmail.escolher_resultado
    expect(page).to have_content 'minuto'
    @login_gmail.escolher_ativar_conta
  end
end

Quando('preenche o cadastro com a senha com mais de {int} caracteres') do |caracteres|
  minha_conta_page.escolher_criar_conta
  email = USUARIOS['qa_1']['email']
  caracteres += 1
  senha = Faker::Lorem.characters(number: caracteres)
  minha_conta_page.criar_conta(email, senha, senha)
end

Entao('é cadastrado com sucesso') do
  within_window @checkout_window do
    expect(page).to have_content('ATIVANDO SUA CONTA')
    expect(
      minha_conta_page.txt_modal_aviso.text
    ).to have_content 'Ativação realizada com sucesso! Você será direcionado para sua conta.'
    click_button 'Continuar'
    expect(page).to have_content('MEUS DADOS')
  end
end
