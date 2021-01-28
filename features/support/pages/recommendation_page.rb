# encoding: UTF-8
# frozen_string_literal: true

require './features/support/generators/entity/recommendation'

# Classe com o mapeamento e acoes dos elementos da pagina de resultados
class RecommendationPage < SitePrism::Page
  # RECOMENDACAO
  elements :btn_comprar_aereo,       'a[class*=btn-buy]'
  elements :btn_comprar_pacote,      "input[value='Comprar pacote']"
  elements :btn_ver_pacote,          "input[value='Ver pacote']"
  element  :forma_pagamento,         'p.ng-binding.ng-scope'
  element  :lista_cia,               '.list-cias-air'
  elements :opt_segmento,            'div[id*=option]'
  elements :txt_data_partida,        '.departure-arrival__date'
  elements :txt_iata,                '.origin-destination__iata'
  elements :txt_destino,             '.origin-destination__description'
  elements :titulos_segmentos,       '.flights__headers__info-flight'
  elements :detalhes_options,        '.flights__options__details__columns div'
  element  :radio_option,            'input[type=radio]'
  element  :info_covid,              '.travel-requirements__mask'
  element  :info_visto,              '.travel-requirements__visa'
  element  :info_vacina,             '.travel-requirements__vaccine'
  element  :info_seguro,             '.travel-requirements__insurance'
  element  :info_test_covid,         '.travel-requirements__covid-test'
  element  :parada,                  '.stops'
  element  :outro_dia,               '.other-day'
  element  :duracao,                 '.duration'
  element  :classe,                  '.cabin-type'
  elements :nome_cia,                '.cia__name'
  element  :bagagem,                 '.luggage__text'
  element  :hr_partida,              '.info-hours__hour--align-right'
  element  :hr_chegada,              'strong[class*=info-hours__hour]'
  elements :detalhes_pagamento,      '.content-price-recommendation__detail-price--text'
  elements :prince_recommendation,   '.content-price-recommendation__wrap'
  elements :colapse_option,          'div[id*=option] a'
  elements :segmento_recommendation, 'div[id*=segment-flight]'
  elements :valor_recommendation,    'span[class*=price__total]'

  # PAGINA DE DISPONIBILIDADE
  element  :filtro_cias,             '.cias'
  element  :btn_next,                '.pagination-voo-page.pagination-voo-btns.next'
  element  :link_ver_cias,           '.ver-todas'
  element  :titulo_voos,             'h1[class*=title]', wait: 40
  element  :loader_btn_pesquisar,    '.loader-orbit'
  element  :loader,                  '.search-loader__progressbar'
  element  :loader_pacotes,          '.loader-orbit'
  element  :loader_voos,             '.loader-voos'
  elements :btn_selecionar,          '.btn-edit-super-data'
  element  :link_voltar,             'a[class=btn-back-page]'
  element  :matriz_precos,           '.vn-price-matrix_ctt'
  element  :modal_bagagem,           '.modal-effect-aviso'
  elements :recommendations,         '.tariff-block'
  element  :result_error,            '.resulterror', wait: 10

  include Capybara::DSL

  def wait_recommendation_page
    n = 0
    loop do
      sleep 0.05
      n += 1
      break unless find('.search-loader__progressbar', visible: false).visible? || n == 20
    end
  end

  def confirmar_reserva
    btn_comprar_aereo[0].click
  end

  def ver_primeiro_pacote
    i = 0
    btn_ver_pacote[i].click
    while has_text?('Tarifa não reembolsável')
      link_voltar.click
      i += 1
      btn_ver_pacote[i].click
    end
  end

  def confirmar_primeiro_pacote
    btn_comprar_pacote[0].click
  end

  def alterar_voo
    click_button 'Alterar Voo'
  end

  def escolher_recomendacao_pacotes(tipo_quarto = 'Tarifa não reembolsável')
    escolher_quarto = lambda {
      opcoes_quartos = all('div[ng-repeat*=roomOption]')
      opcoes_quartos.each do |quarto|
        @result = quarto.has_text?(tipo_quarto, wait: 2)
        if @result.equal? true
          quarto.click_button 'Selecionar' if quarto.has_no_button?('Selecionado', wait: 2)
          return click_button 'Comprar pacote'
        end
      end
    }

    @result = false
    i = 0
    escolher_quarto.call
    while @result.equal? false
      link_voltar.click
      i += 1
      btn_ver_pacote[i].click
      escolher_quarto.call
    end
  end

  def escolher_com_bagagem
    click_button 'Adicionar bagagem'
  end

  def escolher_sem_bagagem
    click_button 'Continuar sem bagagem'
  end

  def pegar_primeiro_valor_recommendation
    valor_recommendation[0].text.gsub(/[^\d]/, '')
  end

  def filtrar_cia(companhia)
    within(filtro_cias) do
      link_ver_cias.click if has_link_ver_cias?(wait: 1)
      all('.label-option').each do |cia|
        return cia.click if cia.text == companhia
      end
    end
    raise 'Companhia não encontrada!'
  end

  def contem_cia?(companhia)
    within all('.flights__options')[0] do
      all('.list-cias-air', wait: 5).each do |cia|
        return true if cia.text == companhia
      end
    end
    false
  end

  def blacklist?
    blacklist = COMPANHIAS['BlackList']
    within all('.flights__options')[0] do
      all('.list-cias-air').each do |cia|
        blacklist.each do |black|
          return true if cia.text == black
        end
      end
    end
    false
  end

  def escolher_recomendacao_cia(cia)
    sleep 4
    all('.tariff-block', wait: 3).each do |recommendation|
      within(recommendation) do
        all('div[ng-switch*=segIndex]').each do |segmento|
          within(segmento) do
            @cia = contem_cia?(cia)
          end
          break if @cia == true
        end
        return confirmar_reserva if @cia == true
      end
    end
    return unless has_btn_next?

    btn_next.click
    escolher_recomendacao_cia(cia)
  rescue StandardError
    raise 'Recomendação não encontrada'
  end

  def escolher_recomendacao
    all('.tariff-block').each do |recommendation|
      within(recommendation) do
        all('div[ng-switch*=segIndex]').each do |segmento|
          within(segmento) do
            @black = blacklist?
          end
          break if @black == true
        end
        return confirmar_reserva if @black == false
      end
    end
    return unless has_btn_next?

    btn_next.click
    escolher_recomendacao
  rescue StandardError
    raise 'Recomendação não encontrada'
  end

  def gerar_link(data_ida, data_volta)
    data_ida = data_ida.strftime('%d-%m-%Y')
    data_volta = data_volta.strftime('%d-%m-%Y')
    "#{data_ida}/#{data_volta}"
  end

  def escolher_salvar_recomendacao
    sleep 4
    recommendations.each do |recommendation|
      within(recommendation) do
        @black = blacklist?
        break if @black == true

        recomendacao = salvar_recomendacao(recommendation)
        confirmar_reserva
        return recomendacao
      end
    end
    return unless has_btn_next?

    btn_next.click
    escolher_salvar_recomendacao
  end

  def salvar_recomendacao(recommendation)
    within(recommendation) do
      @recomendacao = Recommendation.new
      segmento_recommendation.count.times do |i|
        voo = salvar_voo(i)

        @recomendacao.add_flight(voo)
      end
      @recomendacao.prices = salvar_prices
      @recomendacao.bagagem_inclusa = inclui_bagagem?
    end
    @recomendacao
  end

  def salvar_voo(index)
    @voo = Flight.new
    within(segmento_recommendation[index]) do
      salvar_segmento
      salvar_opcao
    end
    @voo
  end

  def salvar_segmento
    segmento = titulos_segmentos[0].text.split(/\n/)
    @voo.segmento = segmento[0]
    @voo.origem.iata = segmento[2]
    @voo.origem.cidade = segmento[3]
    @voo.destino.iata = segmento[4]
    @voo.destino.cidade = segmento[5]
    @voo.dt_partida = DateFormat.new.date_s_parse(segmento[1])
  end

  def salvar_opcao
    within(opt_segmento[0]) do
      radio_option.click
      @voo.cia = salvar_cias
      @voo.hr_partida = hr_partida.text.split[0]
      days = if outro_dia.text.empty?
               0
             else
               outro_dia.text.gsub(/[+]/, '').to_i
             end
      @voo.dt_chegada = @voo.dt_partida.next_day(days)
      @voo.hr_chegada = hr_chegada.text
      @voo.parada = parada.text
      @voo.duracao = duracao.text.gsub(/ /, '')
      @voo.classe = classe.text
      salvar_detalhes_voo
    end
  end

  def salvar_detalhes_voo
    find('a').click
    sleep 0.5
    detalhes = detalhes_options[1].text.split(/\n/)
    @voo.num_voo = detalhes[2]
    @voo.num_aeronave = detalhes[3]
    find('a').click
  end

  def salvar_cias
    cias = []
    nome_cia.each { |cia| cias.push(cia.text) }
    cias
  end

  def salvar_prices
    payment = prince_recommendation[0].text.split(/\n/)
    prices = Prices.new
    prices.vl_pessoa = payment[0].gsub(/[R$ .]/, '').to_f
    prices.vl_taxas = payment[5].gsub(/[R$ .]/, '').to_f
    prices.vl_total = payment[7].gsub(/[R$ .]/, '').to_f
    prices
  end

  def inclui_bagagem?
    bagagem.text.eql? 'Inclui bagagem para despachar'
  end

  def retorna_primeiro_segmento
    titulos_segmentos[0].text.split(/\n/)
  end

  def retorna_segundo_segmento
    titulos_segmentos[1].text.split(/\n/)
  end

  def validar_pax(total_pax)
    total_pessoas = detalhes_pagamento[0].text
    if total_pax > 1
      total_pessoas.eql? "#{total_pax} Pessoas"
    else
      total_pessoas.eql? "#{total_pax} Pessoa"
    end
  end

  def validar_calculo_recomendacao
    payment = prince_recommendation[0].text.split(/\n/)
    vl_total_pax = payment[3].gsub(/[R$ .]/, '').to_f
    vl_taxas = payment[5].gsub(/[R$ .]/, '').to_f
    vl_total = payment[7].gsub(/[R$ .]/, '').to_f
    result = vl_total_pax + vl_taxas
    result.equal? vl_total
  end
end
