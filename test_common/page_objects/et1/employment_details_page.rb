require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class EmploymentDetailsPage < BasePage
        include RSpec::Matchers
        #Employment details
        section :main_header, '.main-header' do
          element :page_header, :page_title, 'claims.employment.header', exact: false
        end
        section :main_content, '#content .main-section .main-content' do
          section :error_message, '#error-summary' do
            element :error_summary, :content_header, 'shared.error_notification.error_summary', exact: false
            element :default_message, :paragraph, 'shared.error_notification.default_message', exact: false
          end
          #Your employment details
          element :your_employment_details_header, :legend_header, 'claims.employment.situation_legend'
          section :your_employment_details, '.employment_was_employed' do
            #Have you ever been employed by the person or organisation that you’re making this claim against? (optional)
            element :employment_intro, :form_labelled, 'simple_form.labels.employment.was_employed'
            include ::EtFullSystem::Test::I18n
            element :yes, :form_labelled, 'claims.employment.yes' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            element :no, :form_labelled, 'claims.employment.no' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            def set(value)
              choose(factory_translate(value), name: 'employment[was_employed]')
            end
          end
          #What is your current work situation in relation to the employer you're making a claim against?
          element :current_work_situation_labelled, :legend_header, 'claims.employment.current_situation', exact: false
          section :employment_current_situation, '.employment_current_situation' do
            element :error_current_situation, :error, 'activemodel.errors.models.employment.attributes.current_situation.blank'
            include ::EtFullSystem::Test::I18n
            element :still_employed, :form_labelled, 'simple_form.options.employment.current_situation.still_employed' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            element :notice_period, :form_labelled, 'simple_form.options.employment.current_situation.notice_period' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            element :employment_terminated, :form_labelled, 'simple_form.options.employment.current_situation.employment_terminated' do
              element :selector, :css, 'input[type="radio"]'
              def set(*args); selector.set(*args); end
            end
            def set(value)
              choose(factory_translate(value), name: 'employment[current_situation]')
            end
          end
          #Employment details
          element :employment_details_header, :legend_header, 'claims.employment.situation_legend'
          #Job title (optional)
          section :employment_job_title, '.employment_job_title' do
            element :job_title, :form_labelled, 'simple_form.labels.employment.job_title'
            #The job you were doing at the time of the problem at work
            element :job_title_hint, :form_hint, 'simple_form.hints.employment.job_title'
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          #Employment start date
          section :employment_start_date, :legend_header, 'claims.employment.start_date', exact: false do
            element :invalid_employment_start_date, :error, 'activemodel.errors.models.employment.attributes.start_date.invalid'
            #For example, 22 04 2014 (if you don’t know the exact date then put your best estimate)
            element :employment_start_date_hint, :form_hint, 'simple_form.hints.employment.start_date'
            section :day, :question_labelled, 'simple_form.labels.employment.start_date.day' do
              element :field, :css, '#employment_start_date_day'
              def set(*args); field.set(*args); end
            end
            section :month, :question_labelled, 'simple_form.labels.employment.start_date.month' do
              element :field, :css, '#employment_start_date_month'
              def set(*args); field.set(*args); end
            end
            section :year, :question_labelled, 'simple_form.labels.employment.start_date.year' do
              element :field, :css, '#employment_start_date_year'
              def set(*args); field.set(*args); end
            end
            def set(value)
              (day_value, month_value, year_value) = value.split("/")
              day.set(day_value)
              month.set(month_value)
              year.set(year_value)
            end
          end
          #Employment end date
          section :employment_end_date, :legend_header, 'claims.employment.end_date', exact: false do
            element :invalid_employment_end_date, :error, 'activemodel.errors.models.employment.attributes.end_date.invalid'
            #For example, 22 04 2014 (if you don’t know the exact date then put your best estimate)
            element :employment_end_date_hint, :form_hint, 'simple_form.hints.employment.end_date', exact: false
            section :day, :question_labelled, 'simple_form.labels.employment.end_date.day' do
              element :field, :css, '#employment_notice_period_end_date_day'
              def set(*args); field.set(*args); end
            end
            section :month, :question_labelled, 'simple_form.labels.employment.end_date.month' do
              element :field, :css, '#employment_notice_period_end_date_month'
              def set(*args); field.set(*args); end
            end
            section :year, :question_labelled, 'simple_form.labels.employment.end_date.year' do
              element :field, :css, '#employment_notice_period_end_date_year'
              def set(*args); field.set(*args); end
            end
            def set(value)
              (day_value, month_value, year_value) = value.split("/")
              day.set(day_value)
              month.set(month_value)
              year.set(year_value)
            end
          end
          #Did you work (or get paid for) a period of notice?
          section :worked_notice_period_or_paid_in_lieu, :legend_header, 'claims.employment.worked_notice_period_or_paid_in_lieu' do
            section :period_of_notice, '.options' do
              include ::EtFullSystem::Test::I18n
              element :yes, :form_labelled, 'claims.employment.yes' do
                element :selector, :css, 'input[type="radio"]'
                def set(*args); selector.set(*args); end
              end
              element :no, :form_labelled, 'claims.employment.no' do
                element :selector, :css, 'input[type="radio"]'
                def set(*args); selector.set(*args); end
              end
              def set(value)
                choose(factory_translate(value), name: 'employment[worked_notice_period_or_paid_in_lieu]')
              end
            end
          end
          #For how many weeks or months did you get paid? (optional)
          section :notice_period_value, '#reveal_notice_pay_period' do
            element :notice_pay_period_count, :form_labelled, 'simple_form.labels.employment.notice_pay_period_count'
            section :notice_pay, '.inline-fields.slim-fieldset' do
              element :field, :css, '#employment_notice_pay_period_count'
              def set(*args); field.set(*args); end
              section :employment_notice_pay_period_type, '.employment_notice_pay_period_type .options' do
                include ::EtFullSystem::Test::I18n
                element :weeks, :form_labelled, 'simple_form.options.employment.notice_pay_period_type.weeks' do
                  element :selector, :css, '#employment_notice_pay_period_type_weeks'
                  def set(*args); selector.set(*args); end
                end
                element :months, :form_labelled, 'simple_form.options.employment.notice_pay_period_type.months' do
                  element :selector, :css, '#employment_notice_pay_period_type_months'
                  def set(*args); selector.set(*args); end
                end
                def set(value)
                  choose(factory_translate(value), name: "employment[notice_pay_period_type]")
                end
              end
            end
            def set(value)
              notice_pay.set(value)
            end
          end
          #Average hours worked per week (optionl)
          section :employment_average_hours_worked_per_week, '.employment_average_hours_worked_per_week' do
            element :average_hours_worked_per_week, :form_labelled, 'simple_form.labels.employment.average_hours_worked_per_week'
            #Don’t include overtime
            element :overtime_hint, :form_hint, 'simple_form.hints.employment.average_hours_worked_per_week'
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          #Pay, pension and benefits
          element :pay_pension_benefits, :legend_header, 'claims.employment.pay_legend'
          #Pay before tax (optional)
          section :employment_gross_pay, '.employment_gross_pay' do
            element :gross_pay, :form_labelled, 'simple_form.labels.employment.gross_pay'
            #This is your gross pay, before tax and other deductions. You can find it on your payslip. Don’t include any overtime payments
            element :gross_pay_hint, :form_hint, 'simple_form.hints.employment.gross_pay'
            section :gross_pay_count, '.prefixed-field.inline-fields' do
              element :field, :css, 'input'
              def set(*args); field.set(*args); end
              section :employment_gross_pay_period_type, '.employment_gross_pay_period_type .options' do
                include ::EtFullSystem::Test::I18n
                element :weekly, :form_labelled, 'simple_form.options.employment.gross_pay_period_type.weekly' do
                  element :selector, :css, 'input[type="radio"]'
                  def set(*args); selector.set(*args); end
                end
                element :monthly, :form_labelled, 'simple_form.options.employment.gross_pay_period_type.monthly' do
                  element :selector, :css, 'input[type="radio"]'
                  def set(*args); selector.set(*args); end
                end
                def set(value)
                  choose(factory_translate(value), name: "employment[gross_pay_period_type]")
                end
              end
            end
            def set(value)
              gross_pay_count.set(value)
            end
          end
          #Pay after tax (optional)
          section :employment_net_pay, '.employment_net_pay' do
            element :net_pay, :form_labelled, 'simple_form.labels.employment.net_pay'
            #This is your net or take-home pay, after tax and other deductions. You can find it on your payslip. Include overtime, commission and bonuses
            element :net_pay_hint, :form_hint, 'simple_form.hints.employment.net_pay'
            section :net_pay_count, '.prefixed-field.inline-fields' do
              element :field, :css, 'input'
              def set(*args); field.set(*args); end
              section :employment_net_pay_period_type, '.employment_net_pay_period_type .options' do
                include ::EtFullSystem::Test::I18n
                element :weekly, :form_labelled, 'simple_form.options.employment.net_pay_period_type.weekly' do
                  element :selector, :css, 'input[type="radio"]'
                  def set(*args); selector.set(*args); end
                end
                element :monthly, :form_labelled, 'simple_form.options.employment.net_pay_period_type.monthly' do
                  element :selector, :css, 'input[type="radio"]'
                  def set(*args); selector.set(*args); end
                end
                def set(value)
                  choose(factory_translate(value), name: "employment[net_pay_period_type]")
                end
              end
            end
            def set(value)
              net_pay_count.set(value)
            end
          end
          #Are – or were – you a member of your employer’s pension scheme? (optional)
          section :employment_enrolled_in_pension_scheme, '.employment_enrolled_in_pension_scheme' do
            element :enrolled_in_pension_scheme, :form_labelled, 'simple_form.labels.employment.enrolled_in_pension_scheme'
            section :pension_scheme, '.options' do
              include ::EtFullSystem::Test::I18n
              element :yes, :form_labelled, 'claims.employment.true' do
                element :selector, :css, 'input[type="radio"]'
                def set(*args); selector.set(*args); end
              end
              element :no, :form_labelled, 'claims.employment.false' do
                element :selector, :css, 'input[type="radio"]'
                def set(*args); selector.set(*args); end
              end
              def set(value)
                choose(factory_translate(value), name: 'employment[enrolled_in_pension_scheme]')
              end
            end
          end
          #Do – or did – you have any benefits, like a company car? (optional)
          section :employment_benefit_details, '.employment_benefit_details' do
            element :benefit_details, :form_labelled, 'simple_form.labels.employment.benefit_details'
            #Details of benefit(s)
            element :benefit_details_hint, :form_hint, 'simple_form.hints.employment.benefit_details'
            element :field, :css, 'textarea'
            def set(*args); field.set(*args); end
          end

          #Save and continue
          element :save_and_continue_button, :submit_text, 'helpers.submit.update', exact: false
        end

        def save_and_continue
          main_content.save_and_continue_button.click
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def has_correct_translation?
          #your feedback header
          expect(feedback_notice).to have_language
          expect(feedback_notice).to have_feedback_link
          expect(feedback_notice).to have_feedback_info
          #Employment details
          expect(main_header).to have_page_header
          #Your employment details
          expect(main_content).to have_your_employment_details_header
          #Have you ever been employed by the person or organisation that you’re making this claim against? (optional)
          expect(main_content.your_employment_details).to have_employment_intro
          expect(main_content.your_employment_details).to have_yes
          expect(main_content.your_employment_details).to have_no
          #What is your current work situation in relation to the employer you're making a claim against?
          expect(main_content).to have_current_work_situation_labelled
          expect(main_content.employment_current_situation).to have_still_employed
          expect(main_content.employment_current_situation).to have_notice_period
          expect(main_content.employment_current_situation).to have_employment_terminated
          #Employment details
          expect(main_content).to have_employment_details_header
          #Job title (optional)
          expect(main_content.employment_job_title).to have_job_title
          expect(main_content.employment_job_title).to have_job_title_hint
          #Employment start date
          expect(main_content).to have_employment_start_date
          expect(main_content.employment_start_date).to have_employment_start_date_hint
          expect(main_content.employment_start_date).to have_day
          expect(main_content.employment_start_date).to have_month
          expect(main_content.employment_start_date).to have_year
          #Employment end date
          expect(main_content).to have_employment_end_date
          expect(main_content.employment_end_date).to have_employment_end_date_hint
          expect(main_content.employment_end_date).to have_day
          expect(main_content.employment_end_date).to have_month
          expect(main_content.employment_end_date).to have_year
          #Did you work (or get paid for) a period of notice?
          expect(main_content).to have_worked_notice_period_or_paid_in_lieu
          expect(main_content.worked_notice_period_or_paid_in_lieu.period_of_notice).to have_yes
          expect(main_content.worked_notice_period_or_paid_in_lieu.period_of_notice).to have_no
          #For how many weeks or months did you get paid? (optional)
          expect(main_content.notice_period_value).to have_notice_pay_period_count
          expect(main_content.notice_period_value.notice_pay.employment_notice_pay_period_type).to have_weeks
          expect(main_content.notice_period_value.notice_pay.employment_notice_pay_period_type).to have_months
          #Average hours worked per week (optional)
          expect(main_content.employment_average_hours_worked_per_week).to have_average_hours_worked_per_week
          expect(main_content.employment_average_hours_worked_per_week).to have_overtime_hint
          #Pay, pension and benefits
          expect(main_content).to have_pay_pension_benefits
          #Pay before tax (optionl)
          expect(main_content.employment_gross_pay).to have_gross_pay
          expect(main_content.employment_gross_pay).to have_gross_pay_hint
          expect(main_content.employment_gross_pay.gross_pay_count.employment_gross_pay_period_type).to have_weekly
          expect(main_content.employment_gross_pay.gross_pay_count.employment_gross_pay_period_type).to have_monthly
          #Pay after tax (optional)
          expect(main_content.employment_net_pay).to have_net_pay
          expect(main_content.employment_net_pay).to have_net_pay_hint
          expect(main_content.employment_net_pay.net_pay_count.employment_net_pay_period_type).to have_weekly
          expect(main_content.employment_net_pay.net_pay_count.employment_net_pay_period_type).to have_monthly
          #Are – or were – you a member of your employer’s pension scheme? (optional)
          expect(main_content.employment_enrolled_in_pension_scheme).to have_enrolled_in_pension_scheme
          expect(main_content.employment_enrolled_in_pension_scheme.pension_scheme).to have_yes
          expect(main_content.employment_enrolled_in_pension_scheme.pension_scheme).to have_no
          #Do – or did – you have any benefits, like a company car? (optional)
          expect(main_content.employment_benefit_details).to have_benefit_details
          expect(main_content.employment_benefit_details).to have_benefit_details_hint
          #Save and continue
          expect(main_content).to have_save_and_continue_button
          #Support
          expect(support).to have_suport_header
          expect(support).to have_guide
          expect(support).to have_contact_use
          #Save your claim later
          expect(support).to have_your_claim
          #TODO this has stopped working - why?
          # expect(support).to have_save_and_complete_later
        end

        def has_correct_error_message_for_current_work_situation?
          expect(main_content.error_message).to have_error_summary
          expect(main_content.error_message).to have_default_message
          expect(main_content.employment_current_situation).to have_error_current_situation
        end

        def has_correct_invalid_date_error_messages?
          expect(main_content.error_message).to have_error_summary
          expect(main_content.error_message).to have_default_message
          expect(main_content.employment_start_date).to have_invalid_employment_start_date
          # expect(main_content.employment_notice_period_end_date).to have_invalid_employment_end_date
        end

        def set(employment)
          data = employment.to_h
          if data.nil? || data == {}
            main_content.your_employment_details.set(:"claims.employment.no")
          else
            main_content.your_employment_details.set(:"claims.employment.yes")
            main_content do |s|
              s.employment_current_situation.set(data[:current_work_situation])
              s.employment_job_title.set(data[:job_title])
              s.employment_start_date.set(data[:start_date])
              if data.key?(:notice_period)
                s.worked_notice_period_or_paid_in_lieu.period_of_notice.set(:"claims.employment.yes")
                s.notice_period_value.set(data[:notice_period])
                s.notice_period_value.notice_pay.employment_notice_pay_period_type.set(data[:notice_period_type])
              else
                s.worked_notice_period_or_paid_in_lieu.period_of_notice.set(:"claims.employment.no")
              end
              s.employment_average_hours_worked_per_week.set(data[:average_weekly_hours])
              s.employment_gross_pay.set(data[:pay_before_tax])
              s.employment_gross_pay.gross_pay_count.employment_gross_pay_period_type.set(data[:pay_before_tax_type])
              s.employment_net_pay.set(data[:pay_after_tax])
              s.employment_net_pay.net_pay_count.employment_net_pay_period_type.set(data[:pay_after_tax_type])
              s.employment_enrolled_in_pension_scheme.pension_scheme.set(data[:employers_pension_scheme])
              s.employment_benefit_details.set(data[:benefits])
            end
          end
        end
      end
    end
  end
end
