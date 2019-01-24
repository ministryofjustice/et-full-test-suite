require 'rspec/matchers'
module EtFullSystem
  module Test
    module Admin
      class NewUserPage < Admin::BasePage
        element :success_message, 'div.flash.flash_notice'
        element :name, 'input[name="admin_user[name]"]'
        element :email, 'input[name="admin_user[email]"]'
        element :username, 'input[name="admin_user[username]"]'
        element :username_error, '#admin_user_username_input .inline-errors'
        element :department, 'input[name="admin_user[department]"]'
        element :password, 'input[name="admin_user[password]"]'
        element :confirm_password, 'input[name="admin_user[password_confirmation]"]'
        element :password, 'input[name="admin_user[password]"]'
        element :role_selection_field, '.select2-selection'
        section :drop_downList, '.select2-dropdown' do
          element :role_input_field, '.select2-search input'
          element :role_selection, '.select2-results ul li'
        end
        element :create_user_button, 'fieldset.actions input[value="Create User"]'
        element :cancel_button, 'fieldset.actions a[href="/admin/users"]'

        def add_new_user(user)
          name.set(user[:name])
          email.set("#{user[:email]}@blah.com")
          username.set(user[:username])
          department.set(user[:department])
          password.set(user[:password])
          confirm_password.set(user[:password])
          role_selection_field.click
          drop_downList.role_input_field.set(user[:role])
          sleep 1
          drop_downList.role_selection.click
          create_user_button.click
        end

        def has_successfully_created?
          expect(success_message).to have_content("User was successfully created.")
        end
      end
    end
  end
end
