require_relative '../../base_section'
require 'active_support'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class BaseSection < ::EtFullSystem::Test::BaseSection
          include ActiveSupport::NumberHelper

          private

          def with_not_entered(value)
            value.present? ? value : t('review.common.not_entered')
          end

          def with_date_not_entered(value)
            if value.present?
              date = Date.parse(value)
              date.strftime("%d #{t('date.month_names')[date.month]} %Y")
            else
              t('review.common.not_entered')
            end
          end

          def convert_yes_no(val)
            return val if val.nil?
            t "review.common.#{val.to_s.split('.').last}"
          end
        end
      end
    end
  end
end
