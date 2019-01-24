require_relative './base'
module EtFullSystem
  module Test
    module FileObjects
      module Et3PdfFileSection
        class EmploymentDetailsSection < ::EtFullSystem::Test::FileObjects::Et3PdfFileSection::Base
          def has_contents_for?(response:)
            expected_values = {
              agree_with_dates: response[:agree_with_employment_dates].to_s.split('.')[-2] == 'yes',
              employment_start: response[:employment_start],
              employment_end: response[:employment_end],
              disagree_with_dates_reason: response[:disagree_employment] || '',
              continuing: response[:agree_with_employment_dates] == 'yes',
              agree_with_job_title: tri_state(response[:agree_with_claimants_description_of_job_or_title]),
              correct_job_title: response[:disagree_claimants_job_or_title]
            }
            expect(mapped_field_values).to include(expected_values)
          end
        end
      end
    end
  end
end
