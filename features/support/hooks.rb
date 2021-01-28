# encoding: UTF-8
# frozen_string_literal: true

require 'date'
require 'base64'

Before do
  page.driver.browser.manage.window.maximize
end

Before do |scenario|
  @nome_feature = scenario.feature.name.gsub(/[^A-Za-z0-9 ]/, '')
  @nome_feature = @nome_feature.tr(' ', '_').downcase!
end

After do |scenario|
  if scenario.failed?
    show_url
    data = Time.now.strftime('%d-%m-%Y_%H-%M')
    screenshot_name = "#{data}_#{@nome_feature}"
    begin
      if @checkout_window.nil?
        take_screenshot(screenshot_name, 'logs/screenshots')
      else
        within_window @checkout_window do
          take_screenshot(screenshot_name, 'logs/screenshots')
        end
      end
    rescue StandardError
      raise 'Erro ao gerar screenshots'
    end
  end
end

After('@tentativa_recuperacao_senha') do
  @login_gmail.btn_excluir_email.click
end

def show_url
  puts URI.parse(current_url).to_s
  within_window(@checkout_window) { puts URI.parse(current_url).to_s } unless @checkout_window.nil?
end

def take_screenshot(name_file, folder = 'logs/screenshots')
  file = "#{folder}/#{name_file}.png"
  FileUtils.mkdir_p(folder) unless File.exist?(folder)
  page.driver.browser.save_screenshot file
  image = File.open(file, 'rb') do |img|
    Base64.strict_encode64(img.read)
  end
  embed(image, 'image/png;base64')
end

def add_browser_logs
  time_now = Time.now
  # Getting current URL
  current_url = Capybara.current_url.to_s
  # Gather browser logs
  logs = page.driver.browser.manage.logs.get(:browser).map { |line| [line.level, line.message] }
  # Remove warnings and info messages
  logs.reject! { |line| %w[WARNING INFO].include?(line.first) }
  embed(
    time_now.strftime("%Y-%m-%d-%H-%M-%S\n") + "Current URL: #{current_url}\n" + logs.join("\n"),
    'text/plain', 'BROWSER ERROR'
  )
end

at_exit do
  ReportBuilder.configure do |config|
    config.json_path = 'logs/json/report.json'
    config.report_path = 'logs/html/automation_report'
    config.report_types = %i[html]
    config.report_tabs = %w[Overview Features Scenarios Errors]
    config.report_title = 'Projeto de Automacao Web - Viajanet'
    config.compress_images = false
    config.additional_info = {
      'Projeto:' => 'Projeto de Automacao Web - Viajanet',
      'Ambiente' => ENV_TYPE.upcase,
      'Data de Geracao' => DateTime.now.strftime('%d/%m/%Y - %H:%M:%S')
    }
    config.color = 'blue'
  end
  ReportBuilder.build_report
end
