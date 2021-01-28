# frozen_string_literal: true

# Classe da pagina de login do Gmail
class LoginGmailPage < SitePrism::Page
  element :btn_proximo_email,  '#identifierNext'
  element :btn_proxima_senha,  '#passwordNext'
  element :btn_esqueceu_senha, 'div[class="ZFr60d CeoRYc"]'
  element :btn_excluir_email,  'div[data-tooltip=Excluir]'
  element :email_google,       '#identifierId'
  element :senha_google,       'input[name="password"]'
  element :input_search,       '#aso_search_form_anchor input'
  element :lista_resultados,   '#gs_sbt50'
  element :link_ativar_conta,  'a[href*="utm_content=ativar_conta"]'

  def acessa_gmail
    visit ENV_FILE['conta_gmail']
  end

  def logar_gmail
    return unless page.has_no_text?('Caixa de entrada', wait: 3)

    find('.BHzsHc', text: 'Usar outra conta').click unless has_email_google?(wait: 2)
    @email_logado = USUARIOS['gmail']['email']
    senha = USUARIOS['gmail']['senha']
    email_google.set @email_logado
    btn_proximo_email.click
    senha_google.set senha
    btn_proxima_senha.click
  end

  def realizar_pesquisa(conteudo)
    input_search.set conteudo
    sleep 5
  end

  def escolher_resultado
    sleep 1
    within(lista_resultados) do
      all('tr[role=option]', wait: 4).each do |resultado|
        return resultado.click if resultado.has_text?(':', wait: 0.5)
      end
    end
  end

  def escolher_redefinir_senha
    find('th p b', text: 'Redefinir senha', wait: 3).click
  end

  def escolher_ativar_conta
    link_ativar_conta.click
  end
end
