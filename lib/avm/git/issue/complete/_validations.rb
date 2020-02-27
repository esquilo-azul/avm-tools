# frozen_string_literal: true

require 'avm/result'
require 'ostruct'

module Avm
  module Git
    module Issue
      class Complete
        VALIDATIONS = {
          branch_name: 'Branch name',
          branch_hash: 'Branch hash',
          follow_master: 'Follow master?',
          commits: 'Commits?',
          bifurcations: 'Bifurcations?',
          dry_push: 'Dry push?'
        }.with_indifferent_access.freeze

        def valid?
          validations.map(&:result).none?(&:error?)
        end

        def validations_banner
          validations.each do |v|
            infov "[#{v.key}] #{v.label}", v.result.label
          end
        end

        def validations
          VALIDATIONS.map do |key, label|
            ::OpenStruct.new(key: key, label: label, result: validation_result(key))
          end
        end

        def validation_result(key)
          if skip_validations.include?(key)
            ::Avm::Result.neutral('skipped')
          else
            send("#{key}_result")
          end
        end

        def validate_skip_validations
          skip_validations.each do |validation|
            next if VALIDATIONS.keys.include?(validation)

            raise "\"#{validation}\" is not a registered validation"
          end
        end
      end
    end
  end
end
