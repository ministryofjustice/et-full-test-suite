require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class GuidePage < BasePage
        include RSpec::Matchers
        set_url ::EtFullSystem::Test::Configuration.et1_url
        section :static_content, '.main-content .static-content' do
          #Time limits
          section :time_limits, '#time_limits' do
            element :time_limits_title, :content_header, 'guides.time_limits.title'
            element :line_one, :paragraph, 'guides.time_limits.line_one'
            element :list_one, :listing_containing_text, 'guides.time_limits.list.one'
            element :list_two, :listing_containing_text, 'guides.time_limits.list.two'
            element :line_two_html, :paragraph, 'guides.time_limits.line_two_html'
            element :line_three, :paragraph, 'guides.time_limits.line_three'
          end
          #Acas: early conciliation
          section :early_conciliation, '#acas_early_conciliation' do
            element :conciliation_title, :content_header, 'guides.acas_early_conciliation.title', exact: false
            element :conciliation_line_one, :paragraph, 'guides.acas_early_conciliation.line_one_html', exact: false
            element :conciliation_line_two, :paragraph, 'guides.acas_early_conciliation.line_two', exact: false
            element :conciliation_line_three, :paragraph, 'guides.acas_early_conciliation.line_three', exact: false
            element :phone, :paragraph, 'guides.acas_early_conciliation.address.phone', exact: false
            element :textphone, :paragraph, 'guides.acas_early_conciliation.address.textphone', exact: false
            element :week, :paragraph, 'guides.acas_early_conciliation.address.week', exact: false
            element :weekend, :paragraph, 'guides.acas_early_conciliation.address.weekend', exact: false
            element :conciliation_title_two, :support_header, 'guides.acas_early_conciliation.title_two', exact: false
            element :conciliation_line_four, :paragraph, 'guides.acas_early_conciliation.line_four_html', exact: false
            element :conciliation_line_five, :paragraph, 'guides.acas_early_conciliation.line_five_html', exact: false
            element :conciliation_title_three, :support_header, 'guides.acas_early_conciliation.title_three', exact: false
            element :conciliation_line_six, :paragraph, 'guides.acas_early_conciliation.line_six_html', exact: false
          end
        end
        #Support links
        section :support, 'aside[role="complementary"]' do
          element :suport_header, :support_header, 'shared.aside.gethelp_header'
          element :guide, :link_named, 'shared.aside.read_guide'
          element :contact_use, :link_named, 'shared.aside.contact_us'
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def has_correct_translation_for_time_limits?
          expect(static_content.time_limits.time_limits_title.text).to be_truthy
          expect(static_content.time_limits.line_one.text).to be_truthy
          expect(static_content.time_limits.list_one.text).to be_truthy
          expect(static_content.time_limits.list_two.text).to be_truthy
          expect(static_content.time_limits.line_two_html.text).to be_truthy
          expect(static_content.time_limits.line_three.text).to be_truthy
        end

        def has_correct_translation_for_acas_early_conciliation?
          expect(static_content.early_conciliation.conciliation_title.text).to be_truthy
          expect(static_content.early_conciliation.conciliation_line_one.text).to be_truthy
          expect(static_content.early_conciliation.conciliation_line_two.text).to be_truthy
          expect(static_content.early_conciliation.conciliation_line_three.text).to be_truthy
          expect(static_content.early_conciliation.phone.text).to be_truthy
          expect(static_content.early_conciliation.textphone.text).to be_truthy
          expect(static_content.early_conciliation.week.text).to be_truthy
          expect(static_content.early_conciliation.weekend.text).to be_truthy
          expect(static_content.early_conciliation.conciliation_title_two.text).to be_truthy
          expect(static_content.early_conciliation.conciliation_line_four.text).to be_truthy
          expect(static_content.early_conciliation.conciliation_line_five.text).to be_truthy
          expect(static_content.early_conciliation.conciliation_title_three.text).to be_truthy
          expect(static_content.early_conciliation.conciliation_line_six.text).to be_truthy
        end
      end
    end
  end
end