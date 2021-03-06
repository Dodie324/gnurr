require 'gnurr/linter'

module Gnurr
  module Linters
    # Class from which Haml and Ruby extend
    module RubyBasedLinters
      private

      def file_path(file)
        file['path']
      end

      def file_messages(file)
        file['offenses']
      end

      def messages
        return @messages = {} if files.empty?
        @messages ||= parse_messages(relevant_messages['files'])
      end

      def standardize_message(message)
        {
          column: message['location']['column'], # nil in haml-lint
          line: message['location']['line'],
          linter: message['cop_name'], # nil in haml-lint
          message: message['message'],
          severity: message['severity'] == 'error' ? :error : :warning
        }
      end
    end
  end
end
