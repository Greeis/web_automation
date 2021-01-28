# encoding: UTF-8
# frozen_string_literal: true

Dado('um usuario que deseja trocar de senha') do
  @senha_antiga = 'TesteVN123!'
  @senha_correta = USUARIOS['qa_1']['senha']
  meus_dados_page.atualizar_senha(@senha_correta, @senha_antiga, @senha_antiga)
  click_button 'Fechar'
end

Quando('realiza a troca de senha') do
  meus_dados_page.atualizar_senha(@senha_antiga, @senha_correta, @senha_correta)
end

Quando('realiza a troca de senha informando uma senha ja existente') do
  @senha_correta = USUARIOS['qa_1']['senha']
  meus_dados_page.atualizar_senha(@senha_correta, @senha_correta, @senha_correta)
end

Quando('realiza a troca de senha para:') do |senhas|
  senha_atual = senhas.rows_hash['senha_atual']
  nova_senha = senhas.rows_hash['nova_senha']
  confirmacao_senha = senhas.rows_hash['confirmacao_senha']
  meus_dados_page.atualizar_senha(senha_atual, nova_senha, confirmacao_senha)
end

Quando('realiza a troca de senha com mais de {int} caracteres') do |caracteres|
  senha_correta = USUARIOS['qa_1']['senha']
  caracteres += 1
  senha = Faker::Lorem.characters(number: caracteres)
  meus_dados_page.atualizar_senha(senha_correta, senha, '')
end

Entao('consegue logar com a nova senha') do
  meus_dados_page.logout
  identity_page.logar(USUARIOS['qa_1']['email'], USUARIOS['qa_1']['senha'])
  expect(home_page.nome_usuario.text).to have_content 'Janethy Oriundi'
end
