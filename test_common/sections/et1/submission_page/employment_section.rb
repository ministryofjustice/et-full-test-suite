require_relative './base_section'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class EmploymentSection < BaseSection
          section :pension_scheme, :et1_review_question_labelled, 'review.employment.questions.pension_scheme' do
            element :answer, :css, 'td'
          end
          section :notice_period, :et1_review_question_labelled, 'review.employment.questions.notice_period.title' do
            element :answer, :css, 'td'
          end
          section :end_date, :et1_review_question_labelled, 'review.employment.questions.end_date' do
            element :answer, :css, 'td'
          end
          section :start_date, :et1_review_question_labelled, 'review.employment.questions.start_date' do
            element :answer, :css, 'td'
          end
          section :pay_before_tax, :et1_review_question_labelled, 'review.employment.questions.pay_before_tax' do
            element :answer, :css, 'td'
          end
          section :pay_after_tax, :et1_review_question_labelled, 'review.employment.questions.pay_after_tax' do
            element :answer, :css, 'td'
          end
          section :average_weekly_hours_worked, :et1_review_question_labelled, 'review.employment.questions.average_weekly_hours_worked' do
            element :answer, :css, 'td'
          end
          section :current_situation, :et1_review_question_labelled, 'review.employment.questions.current_situation' do
            element :answer, :css, 'td'
          end
          section :job, :et1_review_question_labelled, 'review.employment.questions.job' do
            element :answer, :css, 'td'
          end
          section :benefit_details, :et1_review_question_labelled, 'review.employment.questions.benefit_details' do
            element :answer, :css, 'td'
          end
          section :another_job, :et1_review_question_labelled, 'review.employment.questions.another_job' do
            element :answer, :css, 'td'
          end
          section :notice_pay, :et1_review_question_labelled, 'review.employment.questions.notice_pay' do
            element :answer, :css, 'td'
          end
          section :notice_period_end_date, :et1_review_question_labelled, 'review.employment.questions.notice_period_end_date' do
            element :answer, :css, 'td'
          end
          section :pay_before_tax_at_new_job, :et1_review_question_labelled, 'review.employment.questions.pay_before_tax_at_new_job' do
            element :answer, :css, 'td'
          end
          section :employed_by_employer, :et1_review_question_labelled, 'review.employment.questions.employed_by_employer.title' do
            element :answer, :css, 'td'
          end

          def has_correct_translation?(employment:)
            if employment.present?
              aggregate_failures 'validating employment section with employment populated' do
                expect(pension_scheme).to have_answer(text: with_not_entered(convert_true_false employment.employers_pension_scheme))
                expect(start_date).to have_answer(text: with_date_not_entered(employment.start_date))
                expect(pay_before_tax).to have_answer(text: with_money_not_entered(employment.pay_before_tax, employment.pay_before_tax_type))
                expect(pay_after_tax).to have_answer(text: with_money_not_entered(employment.pay_after_tax, employment.pay_after_tax_type))
                expect(average_weekly_hours_worked).to have_answer(text: with_not_entered(employment.average_weekly_hours))
                expect(current_situation).to have_answer(text: with_not_entered(factory_translate employment.current_work_situation))
                expect(job).to have_answer(text: with_not_entered(employment.job_title))
                expect(benefit_details).to have_answer(text: with_not_entered(employment.benefits))
                expect(another_job).to have_answer(text: with_not_entered(factory_translate employment.new_job))
                validate_conditional_fields(employment)
              end
            else
              expect(employed_by_employer).to have_answer(text: t('review.employment.questions.employed_by_employer.options.no'))
            end
            true
          end

          private

          def convert_true_false(val)
            return val if val.nil?
            converted = val.to_s.split('.').last
            converted = "yes" if converted == "true"
            converted = "no" if converted == "false"
            t "review.common.#{converted}"
          end

          def validate_conditional_fields(employment)
            # still_employed = [:still_employed, :notice_period].include?(employment.current_work_situation.to_s.split('.').last.to_sym)
            # in_notice_period = employment.current_work_situation.to_s.split('.').last == "notice_period"
            #
            # if still_employed
            #   expect(self).to have_no_end_date
            #   expect(self).to have_no_notice_period
            #   if employment.notice_period.present?
            #     expect(notice_pay).to have_answer(text: with_money_not_entered(employment.notice_pay, employment.notice_pay_type))
            #   else
            #     expect(self).to have_no_notice_pay
            #   end
            # else
            #   expect(notice_period).to have_answer(text: t('review.employment.questions.notice_period.options.yes'))
            #   expect(end_date).to have_answer(text: with_date_not_entered(employment.end_date))
            # end
            #
            # if in_notice_period
            #   expect(notice_period_end_date).to have_answer(text: with_date_not_entered(employment.notice_period_end_date))
            # else
            #   expect(self).to have_no_notice_period_end_date
            # end
            #
            # if employment.new_job.present? && employment.new_job.to_s.split('.').last == 'yes'
            #   expect(pay_before_tax_at_new_job).to have_answer(text: with_money_not_entered(employment.new_job_gross_pay, employment.new_job_gross_pay_type))
            # end
          end

          def with_money_not_entered(amount, type)
            if amount.nil? && type.nil?
              t('review.common.not_entered')
            else
              key = "review.employment.pay.types.#{type.to_s.split('.').last}"
              "#{number_to_currency amount, unit: '£'} #{t(key)}"
            end
          end
        end
      end
    end
  end
end
