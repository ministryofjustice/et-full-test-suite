require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class WhatDoYouWantSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(claim:)
            outcome_types = outcome_types_for(claim.preferred_outcome)
            expected_values = {
                prefer_re_instatement: yes_no_for(outcome_types.include?(:prefer_re_instatement), yes: 'yes', no: 'Off'),
                prefer_re_engagement: yes_no_for(outcome_types.include?(:prefer_re_engagement), yes: 'yes', no: 'Off'),
                prefer_compensation: yes_no_for(outcome_types.include?(:prefer_compensation), yes: 'yes', no: 'Off'),
                prefer_recommendation: yes_no_for(outcome_types.include?(:prefer_recommendation), yes: 'yes', no: 'Off'),
                compensation: claim.preferred_outcome_notes
            }
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
