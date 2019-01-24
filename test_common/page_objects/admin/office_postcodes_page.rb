require 'rspec/matchers'
module EtFullSystem
  module Test
    module Admin
      class OfficePostcodesPage < Admin::BasePage
        include ::RSpec::Matchers
        element :new_office_postcode, '#titlebar_right .action_item'
        element :success_error_msg, '.flash_notice' 
        section :main_content, '#main_content .paginated_collection .paginated_collection_contents' do
          section :tbody, 'tbody' do
            element :postcode, '.col.col-postcode'
            element :office, '.col.col-office'
            section :action_table, '.col.col-actions .table_actions' do
              element :view, '.view_link.member_link'
              element :edit, '.edit_link.member_link'
              element :delete, '.delete_link.member_link'
            end
          end
        end
        element :filter_by_office_id, 'select[id="q_office_id"]'
        element :filter_by_postcode_id, 'input[id="q_postcode"]'
        element :filter_button, 'input[type="submit"]'

        def search_by_postcode(postcode_id)
          filter_by_postcode_id.set(postcode_id)
          filter_button.click
        end

        def add_new_office_postcode(postcode_id, local_office)
          search_by_postcode(postcode_id)
          if postcode_exist(postcode_id)
            delete_postcode
          end
          new_office_postcode.click
          admin_pages.new_office_postcodes_page.create_office_postcode(postcode_id, local_office)
        end

        def postcode_exist(postcode_id)
          main_content.tbody.postcode.has_content?(postcode_id)
            rescue Capybara::ElementNotFound
            return false
        end

        def delete_postcode
          main_content.tbody.action_table.delete.click
          page.driver.browser.switch_to.alert.accept
        end

        def edit_postcode
          main_content.tbody.action_table.edit.click
        end

        def has_successfully_created_error_msg?
          expect(success_error_msg).to have_content("Office post code was successfully created")
        end

        def has_successfully_edited_error_msg?
          expect(success_error_msg).to have_content("Office post code was successfully updated")
        end

        def has_successfully_delete_error_msg?
          expect(success_error_msg).to have_content("Office post code was successfully destroyed")
        end
      end
    end
  end
end
