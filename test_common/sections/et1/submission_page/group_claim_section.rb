require_relative './base_section'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class GroupClaimSection < BaseSection
          section :group_claim, :et1_review_question_labelled, 'review.group_claim.questions.group_claim.label' do
            element :answer, :css, 'td'
            element :yes_answer, :td_containing, 'review.group_claim.questions.group_claim.options.yes'
            element :no_answer, :td_containing, 'review.group_claim.questions.group_claim.options.no'
          end
          section :csv_file_name, :et1_review_question_labelled, 'review.group_claim.questions.csv_file_name' do
            element :answer, :css, 'td'
          end
          section :number_of_additional_claimants, :et1_review_question_labelled, 'review.group_claim.questions.number_of_additional_claimants' do
            element :answer, :css, 'td'
          end
          sections :claimants, :et1_review_additional_claimant_labelled, 'review.group_claim.claimant_header' do
            include RSpec::Matchers
            include EtFullSystem::Test::I18n
            section :full_name, :et1_review_question_labelled, 'review.group_claim.claimant.questions.full_name' do
              element :answer, :css, 'td'
              element :answer_empty, :td_containing, 'review.common.not_entered'
            end

            section :date_of_birth, :et1_review_question_labelled, 'review.group_claim.claimant.questions.date_of_birth' do
              element :answer, :css, 'td'
              element :answer_empty, :td_containing, 'review.common.not_entered'
            end

            section :address, :et1_review_question_labelled, 'review.group_claim.claimant.questions.address' do
              element :answer, :css, 'td'
              element :answer_empty, :td_containing, 'review.common.not_entered'
            end

            def has_correct_translation?(claimant)
              has_full_name? &&
                  has_date_of_birth? &&
                  has_address? &&
                  has_full_name_answer_for?(claimant) &&
                  has_date_of_birth_answer_for?(claimant.date_of_birth) &&
                  has_address_answer_for?(claimant)
            end

            # @param [String] dob A date of birth in the format "dd/mm/yyyy"
            def has_date_of_birth_answer_for?(dob)
              date = Date.parse(dob)
              date_of_birth.answer == date.strftime("%d #{t('date.month_names')[date.month]} %Y")
            end

            def has_full_name_answer_for?(claimant)
              expect(full_name).to have_answer(text: "#{factory_translate(claimant.title)} #{claimant.first_name} #{claimant.last_name}")
            end

            def has_address_answer_for?(claimant)
              if claimant.building.empty? && claimant.street.empty? && claimant.locality.empty? && claimant.county.empty && claimant.post_code.empty?
                address.has_answer_empty?
              else
                adress.answer.has_text(claimant.building) &&
                    address.answer.has_text?(claimant.street) &&
                    address.answer.has_text?(claimant.locality) &&
                    address.answer.has_text?(claimant.county) &&
                    address.answer.has_text?(claimant.post_code)
              end
            end
          end

          def has_all_additional_claimants_for?(additional_claimants)
            idx = 0
            additional_claimants.all? do |claimant|
              claimants[idx].has_correct_translation?(claimant)
              idx += 1
            end
          end

          def has_correct_translation?(claimants:)
            if claimants.length > 1
              aggregate_failures 'validating for multiple claimants without csv' do
                expect(self).to have_no_group_claim
                expect(self).to have_no_csv_file_name
                expect(self).to have_no_number_of_additional_claimants
                expect(self).to have_claimants
                expect(self).to have_all_additional_claimants_for(claimants.drop(1))
              end
            elsif claimants.length == 1 && claimants.first.group_claims_csv
              aggregate_failures 'validating for multiple claimants with csv' do
                expect(self).to have_group_claim
                expect(self).to have_csv_file_name
                expect(self).to have_number_of_additional_claimants
                expect(self).to have_no_claimants
                expect(group_claim).to have_yes_answer
              end
            elsif claimants.length == 1
              aggregate_failures 'validating for single claimant' do
                expect(self).to have_group_claim
                expect(self).to have_no_csv_file_name
                expect(self).to have_no_number_of_additional_claimants
                expect(self).to have_no_claimants
                expect(group_claim).to have_no_answer
              end
            else
              raise "#{self.class.name} #has_correct_translation? called with empty claimants - If this is valid, please teach it what to do :-)"
            end
            true
          end
        end
      end
    end
  end
end
