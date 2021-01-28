# encoding: UTF-8
# frozen_string_literal: true

require_relative 'meus_dados_pagamento_section'
require_relative 'meus_dados_passageiros_section'

# Classe com o mapeamento e acoes dos elementos da pagina dos meus dados da minha conta
class MinhaContaDadosPage < SitePrism::Page
  section  :form_cartoes,       FormPagamentoSection,      '.credit-cards'
  section  :form_passageiros,   FormPassageirosSection,    '#inLinepassengersadd'

  element  :btn_editar,            'a[name=edit]'
  element  :foto_usuario,          '.social-media__foto-user'
  element  :form_troca_senha,      '#formPassword'
  element  :form_dados_basicos,    '#frmDadosBasicos'
  element  :input_senha_atual,     '#superpass'
  element  :input_nova_senha,      '#newpass'
  element  :input_confirmar_senha, '#confirmpass'
  element  :input_name,            '#name'
  element  :input_sobrenome,       '#namelast'
  element  :input_nascimento,      '#birth-data'
  element  :input_genero,          '#gender-data'
  element  :input_telefone,        '#phone'
  element  :input_celular,         '#cellphone'
  element  :link_sair,             '#perfil-link-sair'
  element  :link_reservas,         '#perfil-link-reservas'
  element  :link_meus_dados,       '#perfil-link-dados'
  element  :nome_completo,         '.name'
  element  :nascimento,            '.birth-date-data'
  element  :nome_usuario,          'span[class*=name-user]'
  element  :sexo,                  '.gender-data'
  element  :text_modal_aviso,      '#modal-aviso p'
  elements :telefone,              '.phone-data'

  include Capybara::DSL

  def acessar_minhas_reservas
    nome_usuario.click
    link_reservas.click
  end

  def logout
    nome_usuario.click
    link_sair.click
  end

  def atualizar_senha(atual, nova, confirmacao)
    within(form_troca_senha) do
      btn_editar.click
      input_senha_atual.set atual
      input_nova_senha.set nova
      input_confirmar_senha.set confirmacao
      click_button 'Salvar alterações'
    end
  end

  def atualizar_dados(dados_pessoais)
    within(form_dados_basicos) do
      btn_editar.click
      input_name.set dados_pessoais.nome
      input_sobrenome.set dados_pessoais.sobrenome
      input_nascimento.send_keys(:delete)
      input_nascimento.set dados_pessoais.nascimento
      input_genero.select dados_pessoais.genero
      input_telefone.set '1140071510'
      input_celular.set '11988776655'
      click_button 'Salvar alterações'
    end
  end

  def recuperar_dados_basicos
    {
      nome_completo: nome_completo.text,
      nascimento: nascimento.text,
      sexo: sexo.text,
      telefone: telefone[0].text,
      celular: telefone[1].text
    }
  end
end
