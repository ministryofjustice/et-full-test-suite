require 'mail'
require_relative './base'
require 'rack/utils'
module EtFullSystem
  module Test
    class Et1ClaimContinueEmailHtml < SitePrism::Page
      include RSpec::Matchers
      include ::EtFullSystem::Test::I18n
      element(:claim_number_element, :xpath, XPath.generate { |x| x.descendant(:td)[x.string.n.starts_with('Claim number')].child(:p)[2] })
      element(:claim_submitted_element, :xpath, XPath.generate { |x| x.descendant(:tr)[x.child(:td)[x.string.n.starts_with('Claim submitted:')]].child(:td)[2] })
    
      def self.find(search_url: ::EtFullSystem::Test::Configuration.mailhog_search_url, claim_number:, sleep: 10, timeout: 120)
        item = find_email(claim_number, search_url, sleep: sleep, timeout: timeout)
        raise "ET1 Mail with claim number #{claim_number} not found" unless item.present?
        new(item)
      end

      def self.find_email(claim_number, search_url, timeout: 120, sleep: 10, subject_text: t('base_mailer.access_details_email.subject'))
        Timeout.timeout(timeout) do
          item = nil
          until item.present? do
            query = Rack::Utils.build_query(kind: 'containing', query: claim_number, start: 0, limit: 10)
            url = URI.parse(search_url)
            url.query = query
            response = HTTParty.get(url, headers: { accept: 'application/json' })
            item = response.parsed_response['items'].detect {|i| i.dig('Content', 'Headers', 'Subject').try(:first) == subject_text}
            sleep sleep unless item.present?
          end
          Mail.new item.dig('Raw', 'Data')
        end
      rescue Timeout::Error
        return nil
      end

      def initialize(mail)
        self.mail = mail
        part = mail.parts.detect { |p| p.content_type =~ %r{text\/html} }
        body = part.nil? ? '' : part.body.to_s
        load(body)
      end

      def claim_number
        claim_number_element.text
      end

      def submission_submitted
        claim_submitted_element.text
      end

      def has_correct_subject_for_complete_your_claim?
        mail.subject == t('base_mailer.access_details_email.subject')
      end

      attr_accessor :mail
    end
  end
end
