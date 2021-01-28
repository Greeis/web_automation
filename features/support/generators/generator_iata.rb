# frozen_string_literal: true

require './features/support/generators/entity/iata'
# Classe geradora de destinos
class GeneratorIata
  attr_accessor :lista_iatas

  def initialize
    @lista_iatas = []
    @iatas = YAML.load_file(File.join(Dir.pwd, 'features/support/generators/fixtures/iatas.yml'))
  end

  def generator_nacional_origem
    iata_nacional = Iata.new
    quantidade = @iatas['Nacional']['Origem'].count - 1
    posicao = rand(0..quantidade)
    iata_nacional.nome_iata = @iatas['Nacional']['Origem'][posicao]['destino']
    iata_nacional.descricao_completa = @iatas['Nacional']['Origem'][posicao]['descricao_completa']
    iata_nacional.iata = @iatas['Nacional']['Origem'][posicao]['iata']
    iata_nacional.cidade = @iatas['Nacional']['Origem'][posicao]['cidade']
    iata_nacional.aeroporto = @iatas['Nacional']['Origem'][posicao]['aeroporto']
    iata_nacional
  end

  def generator_nacional_destino
    iata_nacional = Iata.new
    quantidade = @iatas['Nacional']['Destino'].count - 1
    posicao = rand(0..quantidade)
    iata_nacional.nome_iata = @iatas['Nacional']['Destino'][posicao]['destino']
    iata_nacional.descricao_completa = @iatas['Nacional']['Destino'][posicao]['descricao_completa']
    iata_nacional.iata = @iatas['Nacional']['Destino'][posicao]['iata']
    iata_nacional.cidade = @iatas['Nacional']['Destino'][posicao]['cidade']
    iata_nacional.aeroporto = @iatas['Nacional']['Destino'][posicao]['aeroporto']
    iata_nacional
  end

  def generator_internacional_origem
    iata_internacional = Iata.new
    quantidade = @iatas['Internacional']['Origem'].count - 1
    @posicao = rand(0..quantidade)
    iata_internacional.nome_iata = @iatas['Internacional']['Origem'][@posicao]['destino']
    iata_internacional.descricao_completa = @iatas['Internacional']['Origem'][@posicao]['descricao_completa']
    iata_internacional.iata = @iatas['Internacional']['Origem'][@posicao]['iata']
    iata_internacional.cidade = @iatas['Internacional']['Origem'][@posicao]['cidade']
    iata_internacional.aeroporto = @iatas['Internacional']['Origem'][@posicao]['aeroporto']
    iata_internacional
  end

  def generator_internacional_destino
    iata_internacional = Iata.new
    @posicao = rand(0..@iatas['Internacional']['Destino'].count - 1) if @posicao.eql? nil
    iata_internacional.nome_iata = @iatas['Internacional']['Destino'][@posicao]['destino']
    iata_internacional.descricao_completa = @iatas['Internacional']['Destino'][@posicao]['descricao_completa']
    iata_internacional.iata = @iatas['Internacional']['Destino'][@posicao]['iata']
    iata_internacional.cidade = @iatas['Internacional']['Destino'][@posicao]['cidade']
    iata_internacional.aeroporto = @iatas['Internacional']['Destino'][@posicao]['aeroporto']
    iata_internacional
  end

  def generator_mt_internacional
    quantidade = @iatas['Internacional']['Destino'].count - 1
    posicao = rand(0..quantidade)
    iata = @iatas['Internacional']['Destino'][posicao]['iata']
    iata = @iatas['Internacional'['Destino']][posicao = rand(0..quantidade)]['iata'] while @lista_iatas.include?(iata)
    @lista_iatas.push(iata)

    destino = Iata.new
    destino.nome_iata = @iatas['Internacional']['Destino'][posicao]['destino']
    destino.descricao_completa = @iatas['Internacional']['Destino'][posicao]['descricao_completa']
    destino.iata = iata
    destino.cidade = @iatas['Internacional']['Destino'][posicao]['cidade']
    destino.aeroporto = @iatas['Internacional']['Destino'][posicao]['aeroporto']
    destino
  end

  def generator_mt_nacional
    quantidade = @iatas['Nacional']['Destino'].count - 1
    posicao = rand(0..quantidade)
    iata = @iatas['Nacional']['Destino'][posicao]['iata']
    iata = @iatas['Nacional']['Destino'][posicao = rand(0..quantidade)]['iata'] while @lista_iatas.include?(iata)
    @lista_iatas.push(iata)

    destino = Iata.new
    destino.nome_iata = @iatas['Nacional']['Destino'][posicao]['destino']
    destino.descricao_completa = @iatas['Nacional']['Destino'][posicao]['descricao_completa']
    destino.iata = iata
    destino.cidade = @iatas['Nacional']['Destino'][posicao]['cidade']
    destino.aeroporto = @iatas['Nacional']['Destino'][posicao]['aeroporto']
    destino
  end
end
