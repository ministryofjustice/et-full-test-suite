require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class EmploymentDetailsSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(employment:)
            employment.nil? ? has_contents_for_no_employment? : has_contents_for_employment?(employment)
          end

          private

          def has_contents_for_employment?(employment)
            expected_values = {
                job_title: employment.job_title,
                start_date: employment.start_date,
                employment_continuing: yes_no_for(employment.end_date.nil? || date_in_future(employment.end_date).present?).downcase,
                ended_date: date_in_past(employment.try(:end_date), optional: true) || '',
                ending_date: date_in_future(employment.try(:end_date), optional: true) || ''
            }
            expect(mapped_field_values).to include expected_values
          end

          def has_contents_for_no_employment?
            expected_values = {
                job_title: nil,
                start_date: nil,
                employment_continuing: nil,
                ended_date: nil,
                ending_date: nil
            }
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
