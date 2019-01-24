require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class ClaimantsDetailsPage < BasePage
        include RSpec::Matchers
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        # Claimant Details Details
        section :main_header, '.content-header' do
          element :header, :content_header, 'claimants_details.header'
        end
        section :error_summary, '.error-summary' do
          element :error_heading, :main_header, 'errors.header'
          element :description, :paragraph, 'errors.description'
          element :error_list, :error_summary_list, 'errors.claimants_details.agree_with_dates_of_employment', exact: true
        end
        
        section :claimants_name_question, :question_labelled, 'questions.claimants_name.label', exact: false do
          element :field, :css, "input"
          element :error_contains_numbers, :exact_error_text, 'errors.messages.contains_numbers', exact: false
          element :error_contains_no_spaces, :exact_error_text, 'errors.messages.contains_no_spaces', exact: false
          def set(*args); field.set(*args); end
        end
        # Do you agree with the details given by the claimant about Early Conciliation with Acas? (optional)
        section :agree_with_early_conciliation_details_question, :single_choice_option, 'questions.agree_with_early_conciliation_details.label', exact: false do
          include ::EtFullSystem::Test::I18n
          element :yes, :gds_multiple_choice_option, 'questions.agree_with_early_conciliation_details.yes.label', exact: false do
            element :selector, :css, 'input[type="radio"]'
            def set(*args); selector.set(*args); end
          end
          element :no, :gds_multiple_choice_option, 'questions.agree_with_early_conciliation_details.no.label', exact: false do
            element :selector, :css, 'input[type="radio"]'
            def set(*args); selector.set(*args); end
          end
          element :disagree_conciliation_reason, :textarea_labelled, 'questions.agree_with_early_conciliation_details.disagree_conciliation_reason.label', exact: false do
            def set(*args); root_element.set(*args); end
          end
          def set_for(user)
            choose(factory_translate(user.agree_with_early_conciliation_details), name: 'claimants_detail[agree_with_early_conciliation_details]')
            if user.disagree_conciliation_reason
              disagree_conciliation_reason.set(user.disagree_conciliation_reason)
            end
          end
        end
        section :agree_with_employment_dates_question, :single_choice_option, 'questions.agree_with_employment_dates.label', exact: false do
          element :yes, :gds_multiple_choice_option, 'questions.agree_with_employment_dates.yes.label', exact: false do
            element :selector, :css, 'input[type="radio"]'
            def set(*args); selector.set(*args); end
          end
          element :no, :gds_multiple_choice_option, 'questions.agree_with_employment_dates.no.label', exact: false do
            element :selector, :css, 'input[type="radio"]'
            def set(*args); selector.set(*args); end
          end
          section :employment_start, :single_choice_option, 'questions.agree_with_employment_dates.employment_start.label', exact: false do
            element :employment_start_hint, :form_hint, 'hint.claimants_detail.employment_start'
            section :day, :question_labelled, 'questions.agree_with_employment_dates.employment_start.day.label', exact: true do
              element :field, :css, 'input'
              def set(*args); field.set(*args); end
            end
            section :month, :question_labelled, 'questions.agree_with_employment_dates.employment_start.month.label', exact: true do
              element :field, :css, 'input'
              def set(*args); field.set(*args); end
            end
            section :year, :question_labelled, 'questions.agree_with_employment_dates.employment_start.year.label', exact: true do
              element :field, :css, 'input'
              def set(*args); field.set(*args); end
            end
            element :error_blank, :exact_error_text, 'errors.claimants_details.start_date_blank', exact: false
          end
          section :employment_end, :single_choice_option, 'questions.agree_with_employment_dates.employment_end.label', exact: false do
            element :employment_end_hint, :form_hint, 'hint.claimants_detail.employment_end'
            section :day, :question_labelled, 'questions.agree_with_employment_dates.employment_end.day.label', exact: true do
              element :field, :css, 'input'
              def set(*args); field.set(*args); end
            end
            section :month, :question_labelled, 'questions.agree_with_employment_dates.employment_end.month.label', exact: true do
              element :field, :css, 'input'
              def set(*args); field.set(*args); end
            end
            section :year, :question_labelled, 'questions.agree_with_employment_dates.employment_end.year.label', exact: true do
              element :field, :css, 'input'
              def set(*args); field.set(*args); end
            end
            element :error_blank, :exact_error_text, 'errors.claimants_details.end_date_blank', exact: false
          end
          section :disagree_employment, :question_labelled, 'questions.agree_with_employment_dates.disagree_employment.label', exact: false do
            element :field, :css, 'textarea'
            element :error_blank, :exact_error_text, 'errors.claimants_details.disagree_dates', exact: false
            def set(*args); field.set(*args); end
          end
          element :error_blank, :exact_error_text, 'errors.messages.blank', exact: false
          include ::EtFullSystem::Test::I18n
          def set_for(user_persona)
            choose(factory_translate(user_persona.agree_with_employment_dates), name: 'claimants_detail[agree_with_employment_dates]')
            if (t(user_persona.agree_with_employment_dates) == t('questions.agree_with_employment_dates.no.label'))
              # Employment started
              day, month, year = user_persona.employment_start.split('/')
              employment_start.day.set(day)
              employment_start.month.set(month)
              employment_start.year.set(year)
              # Employment ended
              day, month, year = user_persona.employment_end.split('/')
              employment_end.day.set(day)
              employment_end.month.set(month)
              employment_end.year.set(year)
              disagree_employment.set(user_persona.disagree_employment)
            end
          end
        end
        # Is their employment continuing? (optional)
        section :continued_employment_question, :single_choice_option, 'questions.continued_employment.label', exact: false do
          include ::EtFullSystem::Test::I18n
          element :yes, :gds_multiple_choice_option, 'questions.continued_employment.yes.label'
          element :no, :gds_multiple_choice_option, 'questions.continued_employment.no.label'
          def set_for(user)
            choose(factory_translate(user), name: 'claimants_detail[continued_employment]')
          end
        end
        # Is the claimant's description of their job or job title correct? (optional)
        section :agree_with_claimants_description_of_job_or_title_question, :single_choice_option, 'questions.agree_with_claimants_description_of_job_or_title.label', exact: false do
          include ::EtFullSystem::Test::I18n
          element :yes, :gds_multiple_choice_option, 'questions.agree_with_claimants_description_of_job_or_title.yes.label'
          element :no, :gds_multiple_choice_option, 'questions.agree_with_claimants_description_of_job_or_title.no.label'
          element :disagree_claimants_job_or_title, :textarea_labelled, 'questions.agree_with_claimants_description_of_job_or_title.disagree_claimants_job_or_title.label', exact: false
          def set_for(user_persona)
            choose(factory_translate(user_persona.agree_with_claimants_description_of_job_or_title), name: 'claimants_detail[agree_with_claimants_description_of_job_or_title]')
            if (t(user_persona.agree_with_claimants_description_of_job_or_title) == t('questions.agree_with_claimants_description_of_job_or_title.no.label'))
              disagree_claimants_job_or_title.set(user_persona.disagree_claimants_job_or_title)
            end
          end
        end
        # Save and continue
        element :continue_button, :submit_text, 'components.save_and_continue_button'
        def next
          continue_button.click
        end

        def switch_to_welsh
          switch_language.welsh_link.click
        end
  
        def switch_to_english
          switch_language.english_link.click
        end

        def has_correct_translation?
          # Claimants's Details
          expect(main_header).to have_header
          # Claimant's name (optional)
          expect(self).to have_claimants_name_question
          # Do you agree with the details given by the claimant about Early Conciliation with Acas? (optional)
          expect(self).to have_agree_with_early_conciliation_details_question
          # Why do you disagree with the claimant? (optional)
          expect(agree_with_early_conciliation_details_question).to have_disagree_conciliation_reason 
          # Are the dates of employment given by the claimant correct?
          expect(self).to have_agree_with_employment_dates_question
          # For example, 31 03 2010
          expect(agree_with_employment_dates_question.employment_start).to have_employment_start_hint
          # When their employment ended or will end
          expect(agree_with_employment_dates_question).to have_employment_end
          # For example, 01 12 2017
          expect(agree_with_employment_dates_question.employment_end).to have_employment_end_hint
          # Why do you disagree with the dates given by the claimant
          expect(agree_with_employment_dates_question).to have_disagree_employment
          # Is their employment continuing? (optional)
          expect(self).to have_continued_employment_question
          # Is the claimant's description of their job or job title correct? (optional
          expect(self).to have_agree_with_claimants_description_of_job_or_title_question
          # Please give the details you believe to be correct (optional)
          expect(agree_with_claimants_description_of_job_or_title_question).to have_disagree_claimants_job_or_title
        end
      end
    end
  end
end
