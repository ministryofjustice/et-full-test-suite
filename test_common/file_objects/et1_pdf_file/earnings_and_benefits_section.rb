require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class EarningsAndBenefitsSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(employment:)
            employment.present? ? has_contents_for_employment?(employment) : has_contents_for_no_employment?
          end

          private

          def has_contents_for_employment?(employment)
            expected_values = {
                average_weekly_hours: employment.try(:average_weekly_hours).try(:to_f).try(:to_s),
                pay_before_tax: {
                    'amount': employment.try(:pay_before_tax),
                    'period': employment.try(:pay_before_tax_type).try(:to_s).try(:split, '.').try(:last)
                },
                paid_for_notice_period: tri_state_for(employment.try(:paid_for_notice_period)),
                notice_period: {
                    weeks: weekly_notice_period(employment.try(:notice_period)) || '',
                    months: monthly_notice_period(employment.try(:notice_period)) || ''
                },
                employers_pension_scheme: employers_pension_scheme(employment),
                benefits: employment.try(:benefits)
            }
            expect(mapped_field_values).to include expected_values
          end

          def has_contents_for_no_employment?
            expected_values = {
                average_weekly_hours: nil,
                pay_before_tax: {
                    'amount': nil,
                    'period': nil
                },
                paid_for_notice_period: nil,
                notice_period: {
                    weeks: nil,
                    months: nil
                },
                employers_pension_scheme: nil,
                benefits: nil
            }
            expect(mapped_field_values).to include expected_values
          end

          def employers_pension_scheme(employment)
            return nil if employment.nil?
            true_false = employment.employers_pension_scheme.to_s.split('.').last.downcase
            if true_false == "true"
              'yes'
            elsif true_false == "false"
              'no'
            else
              raise "Unexpected value for employers_pension_scheme - #{employment.employers_pension_scheme}"
            end
          end


          def weekly_notice_period(notice_period)
            return nil if notice_period.nil?
            amount, period = notice_period.split(' ')
            period == 'Weekly' ? amount : nil
          end

          def monthly_notice_period(notice_period)
            return nil if notice_period.nil?
            amount, period = notice_period.split(' ')
            period == 'Monthly' ? amount : nil
          end
        end
      end
    end
  end
end
