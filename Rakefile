begin
  require 'bundler/gem_tasks'
rescue LoadError
  puts 'Cannot load bundler/gem_tasks'
end

begin
  require 'ffi'
rescue LoadError
  puts 'Cannot load ffi'
end

require 'lemon_docs'

namespace :lemon_docs do
  task default: :compile
  desc 'Compile extension'
  task :compile do
    prefix = FFI::Platform.mac? ? '' : 'lib.target/'
    # Path to compiled drafter library
    path = File.expand_path("ext/drafter/build/out/Release/#{prefix}libdrafter.#{FFI::Platform::LIBSUFFIX}", File.dirname(__FILE__))
    puts "Path to library #{path}"

    if !File.exist?(path) || ENV['RECOMPILE']
      unless File.directory?(File.expand_path('ext/drafter/src'))
        puts 'Initializing submodules (if required)...'
        `git submodule update --init --recursive 2>/dev/null`
      end

      puts 'Compiling extension...'
      `cd #{File.expand_path('ext/drafter/')} && ./configure --shared && make`
      status = $CHILD_STATUS.to_i

      if status == 0
        puts 'Compiling done.'
      else
        puts 'Compiling error, exiting.'
        next
      end
    else
      puts 'Extension already compiled. To recompile set env variable RECOMPILE=true.'
    end
  end

  desc 'Generate JSON'
  task :generate_json, [:path] do |t, args|
    path = args[:path] || '/blueprints'
    path << '/*.md'

    Dir.glob(path) do |file|
      LemonDocs.generate_json_from_file(file)
    end
  end
end

