# encoding: UTF-8
# frozen_string_literal: true

require './features/support/generators/gerenator_date'
require './features/support/generators/generator_iata'

# Classe com o mapeamento e acoes dos elementos da secao do motor de busca
class MotorSection < SitePrism::Section
  element  :aba_pacotes,                      '#aba-packages'
  element  :adicionar_destino,                'a[class*=multidest__btn--new]'
  element  :btn_add_adulto,                   '#add-adult'
  element  :btn_add_crianca,                  '#add-children'
  element  :btn_add_bebe,                     '#add-baby'
  element  :btn_rm_adulto,                    '#rm-adult'
  element  :btn_voltar,                       'a[ng-click*=BeforeMonth]'
  element  :btn_avancar,                      'a[ng-click*=NextMonth]'
  element  :btn_aplicar,                      '#btn-passengers-apply'
  element  :input_destino,                    '#inptdestination'
  element  :input_origin,                     '#inptorigin'
  element  :input_departure,                  '#lblDepartureDate'
  element  :input_arrival,                    '#lblArrivalDate'
  element  :input_arrival_date,               '#arrivalDate'
  element  :input_passageiros_classe,         '.search_passengers-dest'
  element  :input_quartos_passageiros_classe, '#ipt-package-passenger-class'
  element  :link_adicionar_quarto,            '#btn-passengers-add-room'
  elements :link_iata,                        '.ui-corner-all'
  element  :opt_oneway,                       '#iptOneWay'
  element  :opt_roundtrip,                    '#iptRoundTrip'
  element  :opt_multi_dest,                   '#iptRoundTripMT'
  element  :remover_destino,                  'a[class*=multidest__btn--close]', match: :first

  def confirmar_pesquisa
    click_on 'Pesquisar'
  end

  # Trecho

  def escolher_tipo_aereo(tipo)
    case tipo
    when 'oneway'
      opt_oneway.click
    when 'roundtrip'
      opt_roundtrip.click
    when 'multi destinos'
      opt_multi_dest.click
    end
    @generator_data = GeneratorDate.new
    @genenator_iata = GeneratorIata.new
  rescue StandardError
    raise 'Tipo de aereo invalido'
  end

  # Origem

  def escolher_origem_nacional
    origem = @genenator_iata.generator_nacional_origem
    input_origin.click
    sleep 1
    input_origin.set origem.nome_iata
    find('a', text: origem.descricao_completa, wait: 5).click
    origem
  end

  def escolher_origem_internacional
    origem = @genenator_iata.generator_internacional_origem
    input_origin.click
    sleep 1
    input_origin.set origem.nome_iata
    find('a', text: origem.descricao_completa, wait: 5).click
    origem
  end

  def escolher_origem(origem)
    input_origin.click
    input_origin.set origem
    sleep 1
    first('.ui-corner-all').click
    sleep 1
  end

  # Destino

  def escolher_destino_nacional
    destino = @genenator_iata.generator_nacional_destino
    input_destino.click
    sleep 1
    input_destino.set destino.nome_iata
    find('a', text: destino.descricao_completa, wait: 5).click
    sleep 1
    destino
  end

  def escolher_destino_internacional
    destino = @genenator_iata.generator_internacional_destino
    input_destino.click
    sleep 1
    input_destino.set destino.nome_iata
    find('a', text: destino.descricao_completa, wait: 5).click
    destino
  end

  def escolher_destino(destino)
    input_destino.click
    input_destino.set destino
    first('.ui-corner-all').click
  end

  def adiciona_destinos(num_dest)
    count = 2
    remover_destino.click while has_remover_destino?(wait: 1)
    while count < num_dest
      adicionar_destino.click
      count += 1
    end
  end

  def escolher_multidestinos_nacionais(num_dest)
    lista_destinos = []

    adiciona_destinos(num_dest)
    num_dest.times do |i|
      destino = @genenator_iata.generator_mt_nacional
      find("input[id='inptdestination#{i}']").set destino.nome_iata
      find('a', text: destino.descricao_completa, wait: 2, match: :first).click
      data = escolher_data_multidestino(i)
      destinos = { destino: destino, data: data }
      lista_destinos << destinos
    end
    lista_destinos
  end

  def escolher_multidestinos_internacionais(num_dest)
    lista_destinos = []
    adiciona_destinos(num_dest)
    num_dest.times do |i|
      destino = @genenator_iata.generator_mt_internacional
      find("input[id='inptdestination#{i}']").set destino.nome_iata
      find('a', text: destino.descricao_completa, wait: 2).click
      data = escolher_data_multidestino(i)
      destinos = { destino: destino, data: data }
      lista_destinos << destinos
    end
    lista_destinos
  end

  def informacoes_motor_aereo
    {
      origem: input_origin.value,
      destino: input_destino.value,
      data_ida: input_departure.value,
      data_volta: input_arrival.value,
      passageiros_classe: input_passageiros_classe.text
    }
  end

  def informacoes_motor_aereo_md(num_dest)
    destinos = []
    num_dest.times do |i|
      destino = {
        destino: find("input[id='inptdestination#{i}']").value,
        data_ida: find("#lblDepartureDate#{i}").value
      }
      destinos << destino
    end
    destinos
  end

  # Datas

  def escolher_data(trecho)
    case trecho
    when 'oneway'
      escolher_data_ida
    when 'roundtrip'
      escolher_data_ida
      escolher_data_volta
    end
  end

  def escolher_data_ida(data = nil)
    @data_ida = Date.strptime(data, '%d/%m/%Y') unless data.nil?
    @data_ida = @generator_data.generator_data_ida
    input_departure.click
    dia = @data_ida.day
    mes = @data_ida.month
    ano = @data_ida.year
    avancar_mes(mes, ano)
    find("#day-#{dia}#{mes}#{ano}").click
    @data_ida
  end

  def escolher_data_volta(data = nil)
    @data_volta = Date.strptime(data, '%d/%m/%Y') unless data.nil?
    @data_volta = @generator_data.generator_data_volta
    input_arrival_date.click
    dia = @data_volta.day
    mes = @data_volta.month
    ano = @data_volta.year
    find("#day-#{dia}#{mes}#{ano}").click
    sleep 1
    @data_volta
  end

  def escolher_periodo_dia(periodo, dias)
    @data_ida = @generator_data.generator_data_risco(periodo, dias)
    input_departure.click
    dia = @data_ida.day
    mes = @data_ida.month
    ano = @data_ida.year
    avancar_mes(mes, ano)
    find("#day-#{dia}#{mes}#{ano}").click
    @data_ida
  end

  def escolher_data_multidestino(count)
    find("#lblDepartureDate#{count}").click
    if @data.nil?
      @data = @generator_data.generator_data_ida
      dia = @data.day
      mes = @data.month
      ano = @data.year
      avancar_mes(mes, ano)
    else
      @data = @generator_data.generator_data_volta
      dia = @data.day
      mes = @data.month
      ano = @data.year
    end
    find("#day-#{dia}#{mes}#{ano}").click
    @data
  end

  def click_avancar_mes(num_clicks)
    count = 0
    while count < num_clicks
      btn_avancar.click
      count += 1
    end
  end

  def avancar_mes(mes, ano)
    dif_ano = ano - Time.now.year
    if dif_ano.zero?
      total_clicks = if total_clicks.nil?
                       mes - Time.now.month
                     else
                       0
                     end
    elsif dif_ano == 1
      dif_mes_atual = 12 - Time.now.month
      total_clicks = if total_clicks.nil?
                       dif_mes_atual + mes
                     else
                       0
                     end
    end
    click_avancar_mes(total_clicks)
  end

  def voltar_mes_calendario(data_ida)
    input_departure.click
    mes_ida = data_ida.month + 4
    (1..mes_ida).each do
      btn_voltar.click
    end
    data = DateTime.now
    dia = data.day
    mes = data.month
    ano = data.year
    datacompleta = "#day-#{dia}#{mes}#{ano}"
    find(datacompleta).click
  end

  # Passageiros

  def adicionar_passageiros(adulto, crianca, bebe)
    input_passageiros_classe.click
    adicionar_adultos(adulto) if adulto > 1
    adicionar_criancas(crianca) if crianca.positive?
    adicionar_bebes(bebe) if bebe.positive?
    btn_aplicar.click
  end

  def adicionar_adultos(qtd_adulto)
    qtd_adulto -= 1
    (1..qtd_adulto).each do
      btn_add_adulto.click
    end
  end

  def adicionar_criancas(qtd_crianca)
    (1..qtd_crianca).each do
      btn_add_crianca.click
    end
  end

  def adicionar_bebes(qtd_bebe)
    (1..qtd_bebe).each do
      btn_add_bebe.click
    end
  end

  def remover_adulto
    input_quartos_passageiros_classe.click
    btn_rm_adulto.click
  end

  # Pacotes

  def escolher_pacotes
    aba_pacotes.click
  end

  def escolher_data_volta_pacotes(periodo)
    gerar_data = lambda {
      days = rand(7..@periodo)
      @data_volta = @data_ida.next_day(days)
    }
    @periodo = periodo.to_i
    gerar_data.call
    gerar_data.call while emenda_feriado?(@data_volta.strftime('%d/%m/%Y')).eql? true
    input_arrival_date.click
    dia = @data_volta.day
    mes = @data_volta.month
    ano = @data_volta.year
    find("#day-#{dia}#{mes}#{ano}").click
    @data_volta
  end

  def adicionar_passageiros_quarto(quarto = 1, adulto = 2, crianca = 0, bebe = 0)
    informa_passageiros = lambda {
      find("#passengers-room#{quarto}-rm-adult").click if adulto == 1
      adulto -= 2
      adulto.times do
        find("#passengers-room#{quarto}-add-adult").click
      end

      menores = crianca + bebe
      menores.times do
        find("#passengers-room#{quarto}-add-minor").click
      end

      @count_menor = 1
      while crianca.positive?
        idade = rand 2..11
        find("#airdrpChildrenQ#{quarto}Age#{@count_menor}").find("option[value='number:#{idade}']").select_option
        crianca -= 1
        @count_menor += 1
      end

      while bebe.positive?
        idade = 0
        find("#airdrpChildrenQ#{quarto}Age#{@count_menor}").find("option[value='number:#{idade}']").select_option
        bebe -= 1
        @count_menor += 1
      end
    }
    link_adicionar_quarto.click if quarto > 1
    informa_passageiros.call
  end

  def informacoes_motor_pacotes
    {
      origem: input_origin.value,
      destino: input_destino.value,
      data_ida: input_departure.value,
      data_volta: input_arrival.value,
      quartos_passageiros_classe: input_quartos_passageiros_classe.text
    }
  end
end
