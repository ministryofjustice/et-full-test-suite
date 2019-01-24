require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class ClaimSubmitted < BasePage
        include RSpec::Matchers
        #Claim submitted
        section :main_header, '.main-header' do
          element :page_header, :page_title, 'claim_confirmations.show.header', exact: false
        end
        section :main_content, '.main-section' do
          section :callout_confirmation, '.callout-confirmation' do
            #Your claim number
            element :claim_number, :paragraph, 'claim_confirmations.show.callout_detail'
            element :answer, :css, '.number'
          end
          #What happens next
          element :what_happens_next, :content_header, 'claim_confirmations.show.what_happens_next.header'
          section :numerical_list, '.numerical-list' do
            #A copy of the claim will be sent to the respondent. They’ll have 28 days to reply.
            element :send_to_respondent, :paragraph, 'claim_confirmations.show.what_happens_next.send_to_respondent'
            #We’ll contact you when we’ve sent your claim to the respondent and explain the next steps.
            element :next_steps, :paragraph, 'claim_confirmations.show.what_happens_next.next_steps'
          end
          #Submission details
          section :submission_details, :table_captioned, 'claim_confirmations.show.submission_details.header' do
            #Download your claim
            section :download_application, :table_row_with_th_labelled, 'claim_confirmations.show.download_application.header' do
              element :download_application_link, :link_named, 'claim_confirmations.show.download_application.link_html'
            end
            #Claim submitted
            section :submission_information, :table_row_with_th_labelled, 'claim_confirmations.show.submission_details.submission_information' do
              element :answer, :css, 'td'
            end
            #Attachments included
            section :attachments, :table_row_with_th_labelled, 'claim_confirmations.show.submission_details.attachments' do
              element :answer, :css, 'td'
              element :no_attachments, :td_containing, 'claim_confirmations.show.no_attachments'
            end
          end
          element :print_this_page, :link_named, 'claim_confirmations.show.print_link_html'
          element :for_your_record, :paragraph, 'claim_confirmations.show.print_link_info', exact: false
          element :your_feedback, :link_named, 'claim_confirmations.show.feedback_html'
          element :your_feedback_info, :paragraph, 'claim_confirmations.show.feedback_info', exact: false
          element :diversity_info, :paragraph, 'claim_confirmations.show.diversity_html', exact: false
          element :diversity_link, :link_named, 'claim_confirmations.show.diversity_link'
        end

        def diversity_link
          main_content.diversity_link.click
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def has_correct_translation?(claim_number, rtf_attachment, csv_attachment, office)
          #your feedback header
          expect(feedback_notice).to have_language
          expect(feedback_notice).to have_feedback_link
          expect(feedback_notice).to have_feedback_info
          #Claim submitted
          expect(self).to have_main_header
          #Your claim number
          expect(main_content.callout_confirmation).to have_claim_number
          expect(main_content.callout_confirmation).to have_answer(text: claim_number)
          #What happens next
          expect(main_content).to have_what_happens_next
          expect(main_content.numerical_list).to have_send_to_respondent 
          expect(main_content.numerical_list).to have_next_steps
          #Submission details
          expect(main_content).to have_submission_details
          #Down your claim
          expect(main_content.submission_details).to have_download_application
          expect(main_content.submission_details.download_application).to have_download_application_link
          #Claim submitted
          expect(has_forwarded_to_local_office?(office)).to be true
          #attachment
          expect(has_attachment?(rtf_attachment, csv_attachment)).to be true
          #Print this page
          expect(main_content).to have_print_this_page
          expect(main_content).to have_for_your_record
          #Your feedback
          expect(main_content).to have_your_feedback
          expect(main_content).to have_your_feedback_info
          #Helps us keep track
          expect(main_content).to have_diversity_info
          expect(main_content).to have_diversity_info
        end
        
        def has_forwarded_to_local_office?(office)
          expect(main_content.submission_details).to have_submission_information
          date = Time.now
          expect(main_content.submission_details.submission_information).to have_answer(text: t('claim_confirmations.show.submission_details.submission_with_office', date: date.strftime("%d #{t("date.month_names")[date.month]} %Y"), office: office))
        end

        def has_attachment?(rtf_attachment, csv_attachment)
          expect(main_content.submission_details).to have_attachments
          if rtf_attachment != nil  && csv_attachment != nil
            #Attachments included rtf and csv
            expect(main_content.submission_details.attachments.answer.text.tr("\n", '')).to eq("#{rtf_attachment}#{csv_attachment}")
          elsif rtf_attachment != nil && csv_attachment == nil
            #rtf only
            expect(main_content.submission_details.attachments).to have_answer(text: rtf_attachment)
          elsif csv_attachment != nil && rtf_attachment == nil
            #csv only
            expect(main_content.submission_details.attachments).to have_answer(text: csv_attachment)
          else
            #no attachments
            expect(main_content.submission_details.attachments).to have_no_attachments
          end
        end
      end
    end
  end
end