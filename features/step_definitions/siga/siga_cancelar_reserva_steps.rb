# encoding: UTF-8
# frozen_string_literal: true

Quando('eu faço login no Siga') do
  siga_login_page.acessar_siga
  siga_login_page.logar_siga
end

Quando('pesquiso pela reserva') do
  siga_home_page.pesquisar_ordem_servico(@num_reserva)
  page.driver.browser.switch_to.alert.accept
end

Quando('confirmo o cancelamento') do
  siga_ordem_servico_page.alterar_status_cancelamento
end

Entao('tenho que ver minha reserva com status de {string}') do |status|
  expect(siga_ordem_servico_page.alerta_alteracao.text).to have_content 'Item de serviço salvo com sucesso'
  expect(siga_ordem_servico_page.pega_status).to have_content(status)
end
