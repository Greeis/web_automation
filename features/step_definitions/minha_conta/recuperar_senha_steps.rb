# encoding: UTF-8
# frozen_string_literal: true

Dado('um usuario que esqueceu a senha') do
  minha_conta_page.esqueci_minha_senha
end

Quando('informa o email que deseja recuperar a senha') do
  email = USUARIOS['gmail']['email']
  minha_conta_page.recuperar_senha(email)
  expect(minha_conta_page.txt_modal_recuperar_senha.text).to have_content 'Recuperação de senha concluída, acesse sua conta de e-mail.'
  click_button 'Fechar'
end

Quando('acessa o email de recuperacao de senha na conta do Gmail') do
  @checkout_window = window_opened_by do
    login_gmail.acessa_gmail
    login_gmail.logar_gmail
    login_gmail.realizar_pesquisa('Solicitação de senha para acesso')
    login_gmail.escolher_resultado
    expect(page).to have_content 'minuto'
    login_gmail.escolher_redefinir_senha
  end
end

Quando('cria uma nova senha') do
  within_window @checkout_window do
    expect(page).to have_content('ALTERANDO PASSWORD')
    senha = USUARIOS['gmail']['senha']
    minha_conta_page.criar_nova_senha(senha, senha)
  end
end

Quando('salva sem informar a senha') do
  within_window @checkout_window do
    minha_conta_page.criar_nova_senha('', '')
  end
end

Quando('salva sem informar a confirmacao de senha') do
  within_window @checkout_window do
    senha = USUARIOS['gmail']['senha']
    minha_conta_page.criar_nova_senha(senha, '')
  end
end

Quando('informa uma nova senha com mais de {int} caracteres') do |caracteres|
  within_window @checkout_window do
    caracteres += 1
    senha = Faker::Lorem.characters(number: caracteres)
    minha_conta_page.criar_nova_senha(senha, senha)
  end
end

Quando('informa uma nova senha {string} e a confirmacao {string}') do |senha, confirmacao|
  within_window @checkout_window do
    minha_conta_page.criar_nova_senha(senha, confirmacao)
  end
end

Entao('a senha alterada com sucesso') do
  within_window @checkout_window do
    expect(
      minha_conta_page.txt_modal_aviso.text
    ).to have_content 'Senha alterada com sucesso! Você será direcionado para sua conta'
    click_button 'Continuar'
  end
  login_gmail.btn_excluir_email.click
end

Entao('é direcionado para a pagina Meus Dados do Minha Conta logado') do
  within_window @checkout_window do
    expect(page).to have_content 'MEUS DADOS'
  end
end

Entao('é exibida mensagem de erro {string}') do |mensagem|
  within_window @checkout_window do
    expect(minha_conta_page.alerta_erro.text).to have_content mensagem
  end
end
