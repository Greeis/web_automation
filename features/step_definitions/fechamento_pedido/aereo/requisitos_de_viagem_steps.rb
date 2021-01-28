# encoding: UTF-8
# frozen_string_literal: true

Quando('escolhe visualizar detalhes da opcao de voo') do
  expect(recommendation_page).to have_no_result_error
  expect(recommendation_page).to have_titulo_voos
  recommendation_page.colapse_option[0].click
end

Entao('é exibido o aviso de uso obrigatorio de mascara na pagina de resultados') do
  expect(recommendation_page.info_covid.text).to have_content INFO_SITE['codiv_uso_mascara']
end

Entao('é exibido o aviso de uso obrigatorio de mascara na pagina de checkout') do
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso de uso obrigatorio de mascara na pagina de resultados
    )
  end
end

Entao('é exibido o aviso de uso obrigatorio de mascara na pagina de confirmacao da reserva') do
  steps %(
      Entao é exibido a pagina de confirmação com as informações da reserva
  )
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso de uso obrigatorio de mascara na pagina de resultados
    )
  end
end

Entao('é exibido o aviso ter o visto em maos no embarque na pagina de resultados') do
  expect(recommendation_page.info_visto.text).to have_content INFO_SITE['visto_embarque']
end

Entao('é exibido o aviso ter o visto em maos no embarque na pagina de checkout') do
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso ter o visto em maos no embarque na pagina de resultados
    )
  end
end

Entao('é exibido o aviso ter o visto em maos no embarque na pagina de confirmacao da reserva') do
  steps %(
    Entao é exibido a pagina de confirmação com as informações da reserva
  )
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso ter o visto em maos no embarque na pagina de resultados
    )
  end
end

Entao('é exibido o aviso de Certificado Internacional de Vacinação ou Profilaxia \(CIVP) na pagina de resultados') do
  expect(recommendation_page.info_vacina.text).to have_content INFO_SITE['vacina']
end

Entao('é exibido o aviso de Certificado Internacional de Vacinação ou Profilaxia \(CIVP) na pagina de checkout') do
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso de Certificado Internacional de Vacinação ou Profilaxia (CIVP) na pagina de resultados
    )
  end
end

Entao('é exibido o aviso de Certificado Internacional de Vacinação ou Profilaxia \(CIVP) na pagina de confirmacao da reserva') do
  steps %(
    Entao é exibido a pagina de confirmação com as informações da reserva
  )
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso de Certificado Internacional de Vacinação ou Profilaxia (CIVP) na pagina de resultados
    )
  end
end

Entao('é exibido o aviso de contratação do Seguro Governamental OSHC na pagina de resultados') do
  expect(recommendation_page.info_seguro.text).to have_content INFO_SITE['contratacao_seguro']['australia']
end

Entao('é exibido o aviso de contratação do Seguro Governamental OSHC na pagina de checkout') do
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso de contratação do Seguro Governamental OSHC na pagina de resultados
    )
  end
end

Entao('é exibido o aviso de contratação do Seguro Governamental OSHC na pagina de confirmacao da reserva') do
  steps %(
    Entao é exibido a pagina de confirmação com as informações da reserva
  )
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso de contratação do Seguro Governamental OSHC na pagina de resultados
    )
  end
end

Entao('é exibido todos os requisitos de viagem na pagina de resultados') do
  steps %(
    Entao é exibido o aviso de uso obrigatorio de mascara na pagina de resultados
    Entao é exibido o aviso de Certificado Internacional de Vacinação ou Profilaxia (CIVP) na pagina de resultados
    Entao é exibido o aviso de contratação do Seguro Governamental OSHC na pagina de resultados
    Entao é exibido o aviso ter o visto em maos no embarque na pagina de resultados
  )
end

Entao('é exibido todos os requisitos de viagem na pagina de checkout') do
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso de uso obrigatorio de mascara na pagina de checkout
      Entao é exibido o aviso de Certificado Internacional de Vacinação ou Profilaxia (CIVP) na pagina de checkout
      Entao é exibido o aviso de contratação do Seguro Governamental OSHC na pagina de checkout
      Entao é exibido o aviso ter o visto em maos no embarque na pagina de checkout
    )
  end
end

Entao('é exibido todos os requisitos de viagem na pagina de confirmacao da reserva') do
  steps %(
    Entao é exibido a pagina de confirmação com as informações da reserva
  )
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso de uso obrigatorio de mascara na pagina de confirmacao da reserva
      Entao é exibido o aviso de Certificado Internacional de Vacinação ou Profilaxia (CIVP) na pagina de confirmacao da reserva
      Entao é exibido o aviso de contratação do Seguro Governamental OSHC na pagina de confirmacao da reserva
      Entao é exibido o aviso ter o visto em maos no embarque na pagina de confirmacao da reserva
    )
  end
end

Entao('é exibido o aviso que na Europa a contratação do seguro viagem obrigatorio na pagina de resultados') do
  expect(recommendation_page.info_seguro.text).to have_content INFO_SITE['contratacao_seguro']['tratado_schengen']
end

Entao('é exibido o aviso que na Europa a contratação do seguro viagem obrigatorio na pagina de checkout') do
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso que na Europa a contratação do seguro viagem obrigatorio na pagina de resultados
    )
  end
end

Entao('é exibido o aviso que na Europa a contratação do seguro viagem obrigatorio na pagina de confirmacao da reserva') do
  steps %(
    Entao é exibido a pagina de confirmação com as informações da reserva
  )
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso que na Europa a contratação do seguro viagem obrigatorio na pagina de resultados
    )
  end
end

Entao('é exibido o aviso que seguro viagem deve cobrir o tempo de permanência em Chipre na pagina de resultados') do
  expect(recommendation_page.info_seguro.text).to have_content INFO_SITE['contratacao_seguro']['chipre']
end

Entao('é exibido o aviso que seguro viagem deve cobrir o tempo de permanência em Chipre na pagina de checkout') do
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso que seguro viagem deve cobrir o tempo de permanência em Chipre na pagina de resultados
    )
  end
end

Entao('é exibido o aviso que seguro viagem deve cobrir o tempo de permanência em Chipre na pagina de confirmacao da reserva') do
  steps %(
    Entao é exibido a pagina de confirmação com as informações da reserva
  )
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso que seguro viagem deve cobrir o tempo de permanência em Chipre na pagina de resultados
    )
  end
end

Entao('é exibido o aviso que a Venezuela exige cobertura mínima de seguro na pagina de resultados') do
  expect(recommendation_page.info_seguro.text).to have_content INFO_SITE['contratacao_seguro']['venezuela']
end

Entao('é exibido o aviso que o Venezuela exige cobertura mínima de seguro na pagina de checkout') do
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso que a Venezuela exige cobertura mínima de seguro na pagina de resultados
    )
  end
end

Entao('é exibido o aviso que o Venezuela exige cobertura mínima de seguro na pagina de confirmacao da reserva') do
  steps %(
    Entao é exibido a pagina de confirmação com as informações da reserva
  )
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso que a Venezuela exige cobertura mínima de seguro na pagina de resultados
    )
  end
end

Entao('é exibido o aviso que Cuba exige uma cobertura de seguro na pagina de resultados') do
  expect(recommendation_page.info_seguro.text).to have_content INFO_SITE['contratacao_seguro']['cuba']
end

Entao('é exibido o aviso que Cuba exige uma cobertura de seguro na pagina de checkout') do
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso que Cuba exige uma cobertura de seguro na pagina de resultados
    )
  end
end

Entao('é exibido o aviso que Cuba exige uma cobertura de seguro na pagina de confirmacao da reserva') do
  steps %(
    Entao é exibido a pagina de confirmação com as informações da reserva
  )
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso que Cuba exige uma cobertura de seguro na pagina de resultados
    )
  end
end

Entao('é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de resultados') do
  expect(recommendation_page.info_test_covid.text).to have_content INFO_SITE['teste_covid']
end

Entao('é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de checkout') do
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de resultados
    )
  end
end

Entao('é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de confirmacao da reserva') do
  steps %(
    Entao é exibido a pagina de confirmação com as informações da reserva
  )
  within_window @checkout_window do
    steps %(
      Entao é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de resultados
    )
  end
end

Entao('não é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de resultados') do
  expect(recommendation_page).to have_no_info_test_covid
end

Entao('não é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de checkout') do
  within_window @checkout_window do
    steps %(
      Entao não é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de resultados
    )
  end
end

Entao('não é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de confirmacao da reserva') do
  steps %(
    Entao é exibido a pagina de confirmação com as informações da reserva
  )
  within_window @checkout_window do
    steps %(
      Entao não é exibido o aviso de obrigatoriedade do teste para o COVID-19 na pagina de resultados
    )
  end
end
