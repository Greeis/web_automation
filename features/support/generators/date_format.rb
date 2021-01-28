# encoding: UTF-8
# frozen_string_literal: true

# Classe
class DateFormat
  def initialize
    @datas = YAML.load_file(File.join(Dir.pwd, 'features/support//generators/fixtures/date_pt.yml'))
  end

  def date_parse(date, type)
    case type
    when 1
      # Ter, 14 Jan 2020
      dia_semana = @datas['date-pt']['abbr_day_names_2'][date.wday]
      dia = date.day
      mes = @datas['date-pt']['abbr_month_2'][date.mon]
      ano = date.year
      formatted_date = "#{dia_semana}, #{dia} #{mes} #{ano}"
    when 2
      # Ter, 14/01/2020
      dia_semana = @datas['date-pt']['abbr_day_names_2'][date.wday]
      data = date.strftime('%d/%m/%Y')
      formatted_date = "#{dia_semana}, #{data}"
    when 3
      # Terca, 14 de Janeiro
      dia_semana = @datas['date-pt']['day_names_3'][date.wday]
      dia = date.day
      mes = @datas['date-pt']['month_names_2'][date.mon]
      formatted_date = "#{dia_semana}, #{dia} de #{mes}"
    when 4
      # terca-feira, 14 de janeiro
      dia_semana = @datas['date-pt']['day_names_1'][date.wday]
      dia = date.day
      mes = @datas['date-pt']['month_names_1'][date.mon]
      formatted_date = "#{dia_semana}, #{dia} de #{mes}"
    when 5
      # Ter, 14 jan 2020
      dia_semana = @datas['date-pt']['abbr_day_names_2'][date.wday]
      dia = date.day
      mes = @datas['date-pt']['abbr_month_1'][date.mon]
      ano = date.year
      formatted_date = "#{dia_semana}, #{dia} #{mes} #{ano}"
    end
    formatted_date
  end

  def date_s_parse(date_s)
    # Ter, 14 Jan 2020
    date = date_s.split
    dia = date[1]
    mes = date[2]
    ano = date[3]
    dt = @datas['date-pt']['abbr_month_2']
    dt.each_with_index { |month, i| mes = i if month == mes }
    Date.strptime("#{dia}/#{mes}/#{ano}", '%d/%m/%Y')
  end
end

# Classe format time
class TimeFormat
  def time_parse(time)
    # 14h 10m
    time = time.split(/:/)
    horas = time[0]
    minutos = time[1]
    "#{horas}h #{minutos}m"
  end
end
