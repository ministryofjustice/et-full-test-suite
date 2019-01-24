require 'rspec/matchers'
module EtFullSystem
  module Test
    module Admin
      class BasePage < ::EtFullSystem::Test::BasePage
        include ::RSpec::Matchers
        elements :names, '.header ul li a'
        section :menu, '.header' do
          element :dashboard_menu_item, :link, 'Dashboard'
          element :acas_menu_item, :link, 'Acas'
          element :acas_certificates_menu_item, :link, 'Certificate Search'
          element :addresses_menu_item, :link, 'Addresses'
          element :atos_files_menu_item, :link, 'Atos Files'
          element :claimants_menu_item, :link, 'Claimants'
          element :claims_menu_item, :link, 'Claims'
          element :diversity_responses_menu_item, :link, 'Diversity Responses'
          element :et_offices_menu_item, :link, 'Et Offices'
          element :exported_files_menu_item, :link, 'Exported Files'
          element :exports_menu_item, :link, 'Exports'
          element :generate_references_menu_item, :link, 'Generate References'
          element :jobs_menu_item, :link, 'Jobs'
          element :office_postcodes_menu_item, :link, 'Office Postcodes'
          element :permissions_menu_item, :link, 'Permissions'
          element :representatives_menu_item, :link, 'Representatives'
          element :respondents_menu_item, :link, 'Respondents'
          element :roles_menu_item, :link, 'Roles'
          element :uploaded_files_menu_item, :link, 'Uploaded Files'
          element :users_menu_item, :link, 'Users'
          
          def choose_acas_certificates
            acas_menu_item.hover
            acas_certificates_menu_item.click
          end

          def click_office_postcodes
            office_postcodes_menu_item.click
          end

          def click_generate_references
            generate_references_menu_item.click
          end

          def click_users
            users_menu_item.click
          end
        end
        def self.base_url
          Configuration.admin_url
        end

        def self.set_url(url, *args)
          super("#{base_url}#{url}", *args)
        end

        def full_access
          ["Dashboard",
            "Acas",
            "",
            "",
            "Addresses",
            "Atos Files",
            "Claimants",
            "Claims",
            "Diversity Responses",
            "Et Offices",
            "Exported Files",
            "Exports",
            "External Systems",
            "Generate References",
            "Jobs",
            "Office Postcodes",
            "Permissions",
            "Representatives",
            "Respondents",
            "Responses",
            "Roles",
            "Uploaded Files",
            "Users",
            "",
            "Logout"]
        end

        def partial_access
          ["Dashboard", 
            "Acas", 
            "", 
            "", 
            "Claims", 
            "Et Offices", 
            "Generate References", 
            "Office Postcodes",
            "Responses",
            "Roles",
            "Users", 
            "", 
            "Logout"]
        end

        def basic_access
          ["Dashboard", 
            "Acas", 
            "", 
            "", 
            "Et Offices", 
            "Generate References", 
            "Logout"]
        end
        section :utility_nav, '#header ul#utility_nav' do
          element :logout_menu_item, :link, 'Logout'

          def click_logout
            logout_menu_item.click
          end
        end
      end
    end
  end
end