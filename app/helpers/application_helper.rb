module ApplicationHelper
  def format_cpf(cpf)
    cpf.to_s.gsub(/\D/, '')
       .rjust(11, '0')
       .gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/, '\1.\2.\3-\4') # Formata como XXX.XXX.XXX-XX
  end

  def uf
    [
      [ 'Acre', 'AC' ], [ 'Alagoas', 'AL' ], [ 'Amapá', 'AP' ], [ 'Amazonas', 'AM' ], [ 'Bahia', 'BA' ],
      [ 'Ceará', 'CE' ], [ 'Distrito Federal', 'DF' ], [ 'Espírito Santo', 'ES' ], [ 'Goiás', 'GO' ],
      [ 'Maranhão', 'MA' ], [ 'Mato Grosso', 'MT' ], [ 'Mato Grosso do Sul', 'MS' ], [ 'Minas Gerais', 'MG' ],
      [ 'Pará', 'PA' ], [ 'Paraíba', 'PB' ], [ 'Paraná', 'PR' ], [ 'Pernambuco', 'PE' ], [ 'Piauí', 'PI' ],
      [ 'Rio de Janeiro', 'RJ' ], [ 'Rio Grande do Norte', 'RN' ], [ 'Rio Grande do Sul', 'RS' ],
      [ 'Rondônia', 'RO' ], [ 'Roraima', 'RR' ], [ 'Santa Catarina', 'SC' ], [ 'São Paulo', 'SP' ],
      [ 'Sergipe', 'SE' ], [ 'Tocantins', 'TO' ]
    ]
  end
end
