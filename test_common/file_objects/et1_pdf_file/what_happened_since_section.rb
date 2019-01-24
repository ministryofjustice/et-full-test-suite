require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class WhatHappenedSinceSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(employment:)
            if employment.present?
              expected_values = {
                  have_another_job: tri_state_for(nil),
                  start_date: '',
                  salary: ''
              }
            else
              expected_values = {
                  have_another_job: nil,
                  start_date: nil,
                  salary: nil
              }
            end
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
