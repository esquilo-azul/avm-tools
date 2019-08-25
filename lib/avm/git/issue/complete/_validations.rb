# frozen_string_literal: true

require 'avm/result'

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
        }.freeze

        def valid?
          validations.values.none?(&:error?)
        end

        def validations_banner
          validations.each do |label, result|
            infov label, result.label
          end
        end

        def validations
          VALIDATIONS.map do |key, label|
            [label, send("#{key}_result")]
          end.to_h
        end
      end
    end
  end
end
