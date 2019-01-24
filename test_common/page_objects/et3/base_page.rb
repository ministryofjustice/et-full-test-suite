module EtFullSystem
  module Test
    module Et3
      class BasePage < ::SitePrism::Page
        section :sidebar, :sidebar_titled, 'components.sidebar.header' do
          element :claim_link, :link_named, 'components.sidebar.claim_link'
          element :response_link, :link_named, 'components.sidebar.response_link'
          element :help_fees_link, :link_named, 'components.sidebar.help_fees_link'
          element :contact_link, :link_named, 'components.sidebar.contact_link'
          element :download_link, :link_named, 'components.sidebar.download_link'
          element :more_category_link, :link_named, 'components.sidebar.more_category_link'
        end
      end
    end
  end
end