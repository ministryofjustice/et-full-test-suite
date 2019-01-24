require_relative './base'
module EtFullSystem
  module Test
    module FileObjects
      module Et3PdfFileSection
        class EarningsSection < ::EtFullSystem::Test::FileObjects::Et3PdfFileSection::Base
          def has_contents_for?(response:)
            expected_values = {
              agree_with_hours: tri_state(response[:agree_with_claimants_hours]),
              correct_hours: decimal_for(response[:queried_hours]),
              agree_with_earnings: tri_state(response[:agree_with_earnings_details]),
              correct_pay_before_tax: decimal_for(response[:queried_pay_before_tax]),
              correct_pay_before_tax_period: response[:queried_pay_before_tax_period],
              correct_take_home_pay: decimal_for(response[:queried_take_home_pay]),
              correct_take_home_pay_period: response[:queried_take_home_pay_period],
              agree_with_notice_period: tri_state(response[:agree_with_claimant_notice]),
              disagree_notice_period_reason: response[:disagree_claimant_notice_reason] || '',
              agree_with_pension_benefits: tri_state(response[:agree_with_claimant_pension_benefits]),
              disagree_pension_benefits_reason: response[:disagree_claimant_pension_benefits_reason] || ''
            }
            expect(mapped_field_values).to include(expected_values)
          end
        end
      end
    end
  end
end
