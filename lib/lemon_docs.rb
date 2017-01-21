require_relative 'lemon_docs/parser'
require_relative 'lemon_docs/version'

module LemonDocs

  # Parses API Blueprint from a file.
  def self.parse_file(file_path)
    file = File.new(file_path)
    path = File.dirname(file_path)

    LemonDocs::Parser.parse(file.read, path)
  end
end