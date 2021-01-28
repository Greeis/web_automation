# encoding: UTF-8
# frozen_string_literal: true

Dado('um usuario que esta deslogado no Minha Conta') do
  home_page.load
  meus_dados_page.logout if meus_dados_page.has_nome_usuario?(wait: 1.5)
  expect(page).to have_link 'Entrar'
end

Quando('realiza o login com e-mail e senha') do
  @tipo_conta = 'email'
  within_window @checkout_window do
    email = USUARIOS['qa_1']['email']
    senha = USUARIOS['qa_1']['senha']
    minha_conta_page.logar(email, senha)
  end
end

Quando('escolhe {string} na pagina checkout') do |texto|
  within_window @checkout_window do
    click_on texto
  end
end

Quando('realiza o login com uma conta Facebook') do
  within_window @checkout_window do
    @checkout_new_window = window_opened_by do
      @tipo_conta = 'facebook'
      minha_conta_page.btn_facebook.click
    end
    within_window @checkout_new_window do
      login_facebook.logar_facebook
    end
  end
end

Quando('realiza o login com uma conta Gmail') do
  within_window @checkout_window do
    @checkout_new_window = window_opened_by do
      @tipo_conta = 'gmail'
      minha_conta_page.btn_gmail.double_click
    end
    within_window @checkout_new_window do
      login_gmail.logar_gmail
    end
  end
end

Quando('realiza o login com os dados:') do |dados|
  within_window @checkout_window do
    email = dados.rows_hash['email']
    senha = dados.rows_hash['senha']
    minha_conta_page.logar(email, senha)
  end
end

Entao('o usuario é autenticado com sucesso') do
  within_window @checkout_window do
    case @tipo_conta
    when 'email'
      expect(checkout_page.txt_usr_logado.text).to have_content 'Logado como'
    when 'facebook'
      expect(checkout_page.txt_usr_logado.text).to have_content "Logado como #{USUARIOS['facebook']['nome_usuario']}"
    when 'gmail'
      expect(checkout_page.txt_usr_logado.text).to have_content "Logado como #{USUARIOS['gmail']['nome_usuario']}"
    end
  end
end
