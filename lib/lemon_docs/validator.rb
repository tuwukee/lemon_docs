module LemonDocs
  module Validator
    def self.validate!(json, strict: true, show_output: true)
      errors = find_errors([], json['content'])
      notable_errors = strict ? errors : errors.select {|error| error[:kind] == 'error' }

      if show_output
        notable_errors.each do |error|
          puts "#{error[:kind].upcase}: #{error[:message]}"
        end
      end
      return !notable_errors.any?
    end

    def self.find_errors(errors, node)
      if node.is_a?(Array)
        node.each { |sub_node| find_errors(errors, sub_node) }
      elsif node.is_a?(Hash)
        if node['element'] == 'annotation'
          kind = node['meta']['classes'].first
          message = node['content']
          errors << {
            kind: kind,
            message: message
          }
        end
      end
      errors
    end
  end
end
