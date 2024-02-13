# frozen_string_literal: true

class Errors < Hash
  def add(key, value, _opts = {})
    # Verifica se a chave já existe no hash. Se não existir, cria um array vazio
    self[key] ||= []
    # Adiciona a mensagem de erro ao array para esta chave
    self[key] << value
    self[key].uniq!
  end

  def add_multiple_errors(errors_hash)
    errors_hash.each do |key, values|
      values.each { |value| add key, value }
    end
  end

  # Itera sobre cada chave do hash de erros
  def each
    each_key do |field|
      self[field].each { |message| yield field, message }
    end
  end
end

# errors = Errors.new
#
# errors.add("username", "Este nome de usuário já está em uso")
# errors.add("email", "Formato de email inválido")
# errors.add_multiple_errors({"password": ["Senha muito curta", "Senha não contém um número"]})
#
# errors.each do |field, message|
#   puts "#{field}: #{message}"
# end
#
# # Output
# username: Este nome de usuário já está em uso
# email: Formato de email inválido
# password: Senha muito curta
# password: Senha não contém um número
