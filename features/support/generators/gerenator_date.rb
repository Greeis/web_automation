# frozen_string_literal: true

# Date Generating Class
class GeneratorDate
  attr_accessor :data_ida
  attr_accessor :data_volta
  attr_accessor :feriados

  def initialize
    @feriados = YAML.load_file(File.join(Dir.pwd, 'features/support/generators/fixtures/feriados_nacionais.yml'))
    @feriados = @feriados['Feriados']
  end

  def generator_data_ida
    days = rand(120..200)
    @data_ida = DateTime.now.next_day(days)
    @data_ida = DateTime.now.next_day(rand(120..200)) while emenda_feriado?(@data_ida.strftime('%d/%m/%Y')).eql? true
    @data_ida
  end

  def generator_data_volta
    days = rand(3..10)
    @data_volta = @data_ida.next_day(days)
    @data_volta
  end

  def emenda_feriado?(data)
    @feriados.each do |feriado|
      return true if feriado.eql? data
    end
  end

  def generator_data(ano, mes, day = null)
    day = rand(1..28) if day.eql? null
    @data_ida = DateTime.new(ano, mes, day)
    @data_ida = DateTime.new(ano, mes, rand(1..28)) while emenda_feriado?(@data_ida.strftime('%d/%m/%Y')).eql? true
    @data_ida
  end

  def generator_data_risco(periodo, dias)
    dias = dias.to_i
    qtd_dias = periodo == 'maior' ? rand(dias..200) : rand(10..dias)
    @data_ida = DateTime.now.next_day(qtd_dias)
    @data_ida = DateTime.now.next_day(
      periodo == 'maior' ? rand(dias..200) : rand(10..dias)
    ) while emenda_feriado?(@data_ida.strftime('%d/%m/%Y')).eql? true
    @data_ida
  end
end
