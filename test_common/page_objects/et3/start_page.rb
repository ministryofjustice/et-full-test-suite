require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class StartPage < BasePage
        include RSpec::Matchers
        set_url ::EtFullSystem::Test::Configuration.et3_url
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        # Introduction
        section :main_header, '.content-header' do
          element :header, :content_header, "introduction.header"
        end
        element :description, :element_with_text, "introduction.description"
        # What you need for this form
        section :what_you_need, :wrapper_headered, "introduction.what_title" do
          element :header, :element_with_text, "introduction.what_title"
          element :bullet_one, :element_with_text, "introduction.what_content_1"
          element :bullet_two, :element_with_text, "introduction.what_content_2"
          element :bullet_three, :element_with_text, "introduction.what_content_3"
          element :bullet_four, :element_with_text, "introduction.what_content_4"
          element :bullet_five, :element_with_text, "introduction.what_content_5"
          element :bullet_six, :element_with_text, "introduction.what_content_6"
        end
        # How to fill in the form
        section :how_to_fill, :wrapper_headered, "introduction.how_title" do
          element :header, :element_with_text, "introduction.how_title"
          element :bullet_one, :element_with_text, "introduction.how_content_1"
          element :bullet_two, :element_with_text, "introduction.how_content_2"
          element :bullet_three, :element_with_text, "introduction.how_content_3"
        end
        # Data Protection Act 1998
        section :dpa, :wrapper_headered, "introduction.data_title"do
          element :header, :element_with_text, "introduction.data_title"
          element :content, :element_with_text, "introduction.data_content"
        end
        # Start now
        element :start_button, :css, ".button.button-start"
        def next
          start_button.click
        end
  
        def switch_to_welsh
          switch_language.welsh_link.click
        end
  
        def switch_to_english
          switch_language.english_link.click
        end

        def assert_language(locale)
          case locale
          when :cy then switch_language.wait_until_english_link_visible
          when :en then switch_language.wait_until_welsh_link_visible
          else
            raise "Unknown locale #{locale}"
          end
        end

        def has_correct_translation?
          #Introduction
          expect(main_header).to have_header
          expect(self).to have_description
          # What you need for this form
          expect(self).to have_what_you_need
          expect(what_you_need).to have_header
          expect(what_you_need).to have_bullet_one
          expect(what_you_need).to have_bullet_two
          expect(what_you_need).to have_bullet_three
          expect(what_you_need).to have_bullet_four
          expect(what_you_need).to have_bullet_five
          expect(what_you_need).to have_bullet_six
          # How to fill in the form
          expect(self).to have_how_to_fill
          expect(how_to_fill).to have_header
          expect(how_to_fill).to have_bullet_one
          expect(how_to_fill).to have_bullet_two
          expect(how_to_fill).to have_bullet_three
          # Data Protection Act 1998
          expect(self).to have_dpa
          expect(dpa).to have_header
          expect(dpa).to have_content
        end
      end
    end
  end
end
