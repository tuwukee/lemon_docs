require_relative 'lemon_docs/binding'
require_relative 'lemon_docs/version'
require 'fileutils'
require 'ffi'
require 'json'

module LemonDocs
  include Binding

  FOLDER_PATH = "doc/lemon_pages".freeze

  def self.parse(raw_blueprint)
    fail(ArgumentError, 'Expected string value') unless raw_blueprint.is_a?(String)

    parse_result = FFI::MemoryPointer.new(:pointer)
    validation_result = FFI::MemoryPointer.new(:pointer)
    serialize_options = LemonDocs::SerializeOption.new
    serialize_options[:sourcemap] = 1
    serialize_options[:drafter_format] = 1

    if LemonDocs::Binding.drafter_check_blueprint(raw_blueprint, validation_result, 0) == 0
      LemonDocs::Binding.drafter_parse_blueprint_to(raw_blueprint, parse_result, 0, serialize_options)
      json_output(parse_result)
    else
      json_output(validation_result)
    end

  ensure
    LemonDocs::Memory.free(parse_result)
    LemonDocs::Memory.free(validation_result)
  end

  def self.parse_file(file_path)
    file = File.new(file_path)
    parse(file.read)
  end

  def self.generate_json_from_file(file_path)
    file_name = File.basename(file_path)
    path = FOLDER_PATH.dup

    json_result = parse_file(file_path)

    dir = File.dirname(path)
    unless File.directory?(dir)
      FileUtils.mkdir_p(dir)
    end

    path << "/#{file_name.split(/\./).first}.json"
    File.write(path, JSON.pretty_generate(json_result))
  end

  private

  def self.json_output(result)
    result = result.get_pointer(0)
    JSON.parse(result.null? ? nil : result.read_string)
  end
end
