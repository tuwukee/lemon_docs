require 'ffi'

module LemonDocs
  # expose function free() to allow release allocated memory
  module Memory
    extend FFI::Library
    ffi_lib FFI::Library::LIBC

    attach_function :free, [:pointer], :void
  end

  class SerializeOption < FFI::Struct
    layout :sourcemap, :bool,
           :drafter_format, :int
  end

  module Binding
    extend FFI::Library

    prefix = FFI::Platform.mac? ? '' : 'lib.target/'

    ffi_lib File.expand_path("../../../ext/drafter/build/out/Release/#{prefix}libdrafter.#{FFI::Platform::LIBSUFFIX}", __FILE__)
    enum :parse_option, [
      :require_blueprint_name
    ]
    enum :drafter_format, [
      :drafter_serialize_yaml,
      :drafter_serialize_json
    ]

    attach_function('drafter_parse_blueprint_to', 'drafter_parse_blueprint_to', [:string, :pointer, :parse_option, SerializeOption.by_value], :int)
    attach_function('drafter_check_blueprint', 'drafter_check_blueprint', [:string, :pointer, :parse_option], :int)
  end
end
