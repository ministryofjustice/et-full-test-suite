require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class EarningsAndBenefitsPage < BasePage
        include RSpec::Matchers
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        # Earnings and Benefits
        section :main_header, '.content-header' do
          element :header, :content_header, 'earnings_and_benefits.header'
        end
        element :error_header, :error_titled, 'errors.header', exact: true
        section :agree_with_claimants_hours_question, :single_choice_option, 'questions.agree_with_claimants_hours.label', exact: false do
          include ::EtFullSystem::Test::I18n
          section :yes, :gds_multiple_choice_option, 'questions.agree_with_claimants_hours.yes.label', exact: false do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          section :no, :gds_multiple_choice_option, 'questions.agree_with_claimants_hours.no.label', exact: false do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          section :queried_hours, :question_labelled, 'questions.agree_with_claimants_hours.queried_hours.label', exact: false do
            element :field, :css, 'input'
            def set(*args); field.set(*args); end
          end
          element :error_not_a_number, :exact_error_text, 'errors.messages.not_a_number', exact: false
          def set_for(user_persona)
            choose(factory_translate(user_persona.agree_with_claimants_hours), name: 'earnings_and_benefits[agree_with_claimants_hours]')
            if (user_persona.queried_hours)
              queried_hours.set(user_persona.queried_hours)
            end
          end
        end
        section :agree_with_earnings_details_question, :single_choice_option, 'questions.agree_with_earnings_details.label', exact: false do
          include ::EtFullSystem::Test::I18n
          section :yes, :gds_multiple_choice_option, 'questions.agree_with_earnings_details.yes.label', exact: false do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          section :no, :gds_multiple_choice_option, 'questions.agree_with_earnings_details.no.label', exact: false do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          section :queried_pay_before_tax, :embedded_single_choice_option, 'questions.agree_with_earnings_details.queried_pay_before_tax_period.label', exact: true do
            section :field, :inputtext_labelled, 'questions.agree_with_earnings_details.queried_pay_before_tax.label', exact: false do
              def set(*args); root_element.set(*args); end
            end
            section :monthly, :gds_multiple_choice_option, 'questions.agree_with_earnings_details.queried_pay_before_tax_period.monthly.label', exact: true do
              element :selector, :css, 'input'
              def set(*args); selector.set(*args); end
            end
            section :weekly, :gds_multiple_choice_option, 'questions.agree_with_earnings_details.queried_pay_before_tax_period.weekly.label', exact: true do
              element :selector, :css, 'input'
              def set(*args); selector.set(*args); end
            end
            def set(*args); field.set(*args); end
          end
          section :queried_take_home_pay, :embedded_single_choice_option, 'questions.agree_with_earnings_details.queried_take_home_pay_period.label', exact: false do
            section :field, :inputtext_labelled, 'questions.agree_with_earnings_details.queried_take_home_pay.label', exact: false do
              def set(*args); root_element.set(*args); end
            end
            section :monthly, :gds_multiple_choice_option, 'questions.agree_with_earnings_details.queried_take_home_pay_period.monthly.label', exact: true do
              element :selector, :css, 'input'
              def set(*args); selector.set(*args); end
            end
            section :weekly, :gds_multiple_choice_option, 'questions.agree_with_earnings_details.queried_take_home_pay_period.weekly.label', exact: true do
              element :selector, :css, 'input'
              def set(*args); selector.set(*args); end
            end
            def set(*args); field.set(*args); end
          end
          element :error_not_a_number, :exact_error_text, 'errors.messages.not_a_number', exact: false
          def set_for(user_persona)
            choose(factory_translate(user_persona.agree_with_earnings_details), name: 'earnings_and_benefits[agree_with_earnings_details]')
            if t(user_persona.agree_with_earnings_details) == t('questions.agree_with_earnings_details.no.label')
              queried_pay_before_tax.set(user_persona.queried_pay_before_tax)
              queried_pay_before_tax.monthly.set(user_persona.queried_pay_before_tax_period)
              queried_take_home_pay.set(user_persona.queried_take_home_pay)
              queried_take_home_pay.monthly.set(user_persona.queried_take_home_pay_period)
            end
          end
        end
        section :agree_with_claimant_notice_question, :single_choice_option, 'questions.agree_with_claimant_notice.label', exact: false do
          include EtFullSystem::Test::I18n
          section :yes, :gds_multiple_choice_option, 'questions.agree_with_claimant_notice.yes.label', exact: true do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          section :no, :gds_multiple_choice_option, 'questions.agree_with_claimant_notice.no.label', exact: true do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          section :disagree_claimant_notice_reason, :textarea_labelled, 'questions.agree_with_claimant_notice.disagree_claimant_notice_reason.label', exact: false do
            def set(*args); root_element.set(*args); end
          end
          element :error_too_long, :exact_error_text, 'errors.messages.too_long', exact: false
          def set_for(user_persona)
            choose(factory_translate(user_persona.agree_with_claimant_notice), name: 'earnings_and_benefits[agree_with_claimant_notice]')
            if t(user_persona.agree_with_claimant_notice) == t('questions.agree_with_claimant_notice.no.label')
              disagree_claimant_notice_reason.set(user_persona.disagree_claimant_notice_reason)
            end
          end
        end
        section :agree_with_claimant_pension_benefits_question, :single_choice_option, 'questions.agree_with_claimant_pension_benefits.label', exact: false do
          include EtFullSystem::Test::I18n
          section :yes, :gds_multiple_choice_option, 'questions.agree_with_claimant_pension_benefits.yes.label', exact: true do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          section :no, :gds_multiple_choice_option, 'questions.agree_with_claimant_pension_benefits.no.label', exact: true do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          section :disagree_claimant_pension_benefits_reason, :textarea_labelled, 'questions.agree_with_claimant_pension_benefits.disagree_claimant_pension_benefits_reason.label', exact: false do
            def set(*args); root_element.set(*args); end
          end
          element :error_too_long, :exact_error_text, 'errors.messages.too_long', exact: false
          def set_for(user_persona)
            choose(factory_translate(user_persona.agree_with_claimant_pension_benefits), name: 'earnings_and_benefits[agree_with_claimant_pension_benefits]')
            if t(user_persona.agree_with_claimant_pension_benefits) == t('questions.agree_with_claimant_pension_benefits.no.label')
              disagree_claimant_pension_benefits_reason.set(user_persona.disagree_claimant_pension_benefits_reason)
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
      end
    end
  end
end
