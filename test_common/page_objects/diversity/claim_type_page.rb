require_relative './base_page'
module EtFullSystem
  module Test
    module Diversity
      class ClaimTypePage < BasePage
        include RSpec::Matchers
        section :feedback_notice, '.feedback-notice' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        section :main_content, '.container' do
          #What is the type of your claim?
          element :header, :main_header, 'diversities.claim_type.hint', exact: false
          #This will help us analyse other information provided in this form
          element :subheader, :paragraph, 'diversities.claim_type.sub_header'
          section :unfair_dismissal, :form_labelled, 'claim_type.unfair-dismissal-or-constructive-dismissal'do
            element :field, 'input'
            def set(*args); field.set(*args); end
          end
          section :discrimination, :form_labelled, 'claim_type.discrimination'do
            element :field, 'input'
            def set(*args); field.set(*args); end
          end
          section :redundancy_payment, :form_labelled, 'claim_type.redundancy-payment'do
            element :field, 'input'
            def set(*args); field.set(*args); end
          end
          section :other_payments, :form_labelled, 'claim_type.other-payments-you-are-owed'do
            element :field, 'input'
            def set(*args); field.set(*args); end
          end
          section :other_complaints, :form_labelled, 'claim_type.other-complaints'do
            element :field, 'input'
            def set(*args); field.set(*args); end
          end
          #save and continue button
          element :save_and_continue, :submit_text, 'helpers.submit.update', exact: false
        end

        def save_and_continue
          main_content.save_and_continue.click
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def set_for(answers)
          data = answers.to_h
          if data[:claim_type] != nil
            choose(factory_translate(data[:claim_type]), name: 'diversities_claim_type[claim_type]')
          end
          save_and_continue
        end

        def has_correct_translation?
          expect(feedback_notice).to have_language
          expect(main_content).to have_header
          expect(main_content).to have_subheader
          expect(main_content).to have_unfair_dismissal
          expect(main_content).to have_discrimination
          expect(main_content).to have_redundancy_payment
          expect(main_content).to have_other_payments
          expect(main_content).to have_other_complaints
        end
      end
    end
  end
end
