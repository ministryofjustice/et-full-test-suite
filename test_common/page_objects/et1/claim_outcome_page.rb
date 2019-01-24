require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class ClaimOutcomePage < BasePage
        include RSpec::Matchers
        #Claim outcome
        section :main_header, '.main-header' do
          element :page_header, :page_title, 'claim_confirmations.show.header', exact: false
        end
        section :main_content, '#content .main-section .main-content' do
          #Choose your preferred outcome(s)
          section :claim_outcome, :legend_header, 'claims.claim_outcome.claim_outcome' do
            #What do you want if your claim is successful? (optional)
            element :desired_outcomes, :form_labelled, 'simple_form.labels.claim.desired_outcomes'
            #You can select more than one
            element :desired_outcomes_hint, :form_hint, 'simple_form.hints.claim_outcome.desired_outcomes'
            #Compensation
            element :compensation_only, :form_labelled, 'simple_form.options.claim_outcome.desired_outcomes.compensation_only' do
              element :selector, :css, 'input[type="checkbox"]'
              def set(*args); selector.set(*args); end
            end
            #A recommendation from a tribunal (that the employer takes action so that the problem at work doesn’t happen again)
            element :tribunal_recommendation, :form_labelled, 'simple_form.options.claim_outcome.desired_outcomes.tribunal_recommendation' do
              element :selector, :css, 'input[type="checkbox"]'
              def set(*args); selector.set(*args); end
            end
            #To get your old job back
            element :reinstated_employment_and_compensation, :form_labelled, 'simple_form.options.claim_outcome.desired_outcomes.reinstated_employment_and_compensation' do
              element :selector, :css, 'input[type="checkbox"]'
              def set(*args); selector.set(*args); end
            end
            #To get another job with the same employer or associated employer
            element :new_employment_and_compensation, :form_labelled, 'simple_form.options.claim_outcome.desired_outcomes.new_employment_and_compensation' do
              element :selector, :css, 'input[type="checkbox"]'
              def set(*args); selector.set(*args); end
            end

            section :claim_outcome_other_outcome, '.claim_outcome_other_outcome' do
              #What compensation or other outcome do you want? (optional)
              element :other_outcome, :form_labelled, 'simple_form.labels.claim_outcome.other_outcome'
              #If you’re claiming financial compensation, you can say how much you want and how you worked out the sum. 
              #You can change these details later, or leave this section blank if you don’t know
              element :other_outcome_hint, :form_hint, 'simple_form.hints.claim_outcome.other_outcome'
              element :field, :css, 'textarea'
              def set(*args); field.set(*args); end
            end
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
          #Claim outcome
          expect(self).to have_main_header
          #Choose your preferred outcome(s)
          expect(main_content).to have_claim_outcome
          ##What do you want if your claim is successful? (optional)
          expect(main_content.claim_outcome).to have_desired_outcomes
          expect(main_content.claim_outcome).to have_desired_outcomes_hint
          expect(main_content.claim_outcome).to have_compensation_only
          expect(main_content.claim_outcome).to have_tribunal_recommendation
          expect(main_content.claim_outcome).to have_reinstated_employment_and_compensation
          expect(main_content.claim_outcome).to have_new_employment_and_compensation
          expect(main_content.claim_outcome.claim_outcome_other_outcome).to have_other_outcome
          expect(main_content.claim_outcome.claim_outcome_other_outcome).to have_other_outcome_hint
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

        def set(claim)
          return if claim.nil? || claim.preferred_outcome.nil?
          claim.preferred_outcome.each do |preferred_outcome|
            section, element = map_preferred_outcome_section_element_from(preferred_outcome)
            main_content.send(section).send(element).click
          end
          data = claim.to_h
          main_content.claim_outcome.claim_outcome_other_outcome.set(data[:preferred_outcome_notes])
        end
        
        def map_preferred_outcome_section_element_from(preferred_outcome)
          case preferred_outcome
            when :"simple_form.options.claim_outcome.desired_outcomes.compensation_only" then [:claim_outcome, :compensation_only]
            when :"simple_form.options.claim_outcome.desired_outcomes.tribunal_recommendation" then [:claim_outcome, :tribunal_recommendation]
            when :"simple_form.options.claim_outcome.desired_outcomes.reinstated_employment_and_compensation" then [:claim_outcome, :reinstated_employment_and_compensation]
            when :"simple_form.options.claim_outcome.desired_outcomes.new_employment_and_compensation" then [:claim_outcome, :new_employment_and_compensation]
          end
        end
      end
    end
  end
end
