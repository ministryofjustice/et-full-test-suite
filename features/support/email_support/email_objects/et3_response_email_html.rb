require 'mail'
require_relative './base'

require 'rack/utils'
module EtFullSystem
  module Test
    class Et3ResponseEmailHtml < SitePrism::Page
      include RSpec::Matchers
      include EtFullSystem::Test::I18n

      def self.find(search_url: ::EtFullSystem::Test::Configuration.mailhog_search_url, reference:, locale:, sleep: 30, timeout: 120)
        item = find_email(reference, search_url, sleep: sleep, timeout: timeout)
        raise "ET3 Mail with reference #{reference} not found" unless item.present?
        new(item, locale: locale)
      end

      def self.find_email(reference, search_url, timeout: 120, sleep: 10)
        Timeout.timeout(timeout) do
          item = nil
          until item.present? do
            query = Rack::Utils.build_query(kind: 'containing', query: reference, start: 0, limit: 1)
            url = URI.parse(search_url)
            url.query = query
            response = HTTParty.get(url, headers: { accept: 'application/json' })
            item = response.parsed_response['items'].first
            sleep sleep unless item.present?
          end
          Mail.new item.dig('Raw', 'Data')
        end
      rescue Timeout::Error
        return nil
      end

      def initialize(mail, locale:)
        self.mail = mail
        self.locale = locale
        multipart = mail.parts.detect { |p| p.content_type =~ %r{multipart\/alternative} }
        part = multipart.parts.detect { |p| p.content_type =~ %r{text\/html} }
        body = part.nil? ? '' : part.body.to_s
        load(body)
      end

      def has_reference_element?(reference)
        assert_reference_element(reference)
        true
      rescue Capybara::ElementNotFound
        false
      end

      def has_correct_content_for?(submission_date:, reference:) # rubocop:disable Naming/PredicateName
        aggregate_failures 'validating content' do
          assert_reference_element(reference)
          expect(has_correct_subject?).to be true
          assert_submission_date_element(submission_date)
          expect(attached_pdf_for(reference: reference)).to be_present
        end
        true
      end

      def has_correct_subject? # rubocop:disable Naming/PredicateName
        mail.subject == t('response_email.subject', locale: locale)
      end

      private

      def has_correct_to_address_for?(input_data) # rubocop:disable Naming/PredicateName
        mail.to.include?(input_data.email_receipt)
      end

      def assert_reference_element(reference)
        assert_selector(:css, 'p', text: t('response_email.reference', locale: locale, reference: reference), wait: 0)
      end

      def assert_submission_date_element(submission_date)
        assert_selector(:css, 'p', text: t('response_email.submission_date', locale: locale, submission_date: submission_date))
      end

      def has_submission_date_element?(submission_date)
        assert_submission_date_element(submission_date)
        true
      rescue Capybara::ElementNotFound
        false
      end

      def attached_pdf_for(reference:)
        mail.parts.attachments.detect { |a| a.filename == "#{reference}.pdf" }
      end

      attr_accessor :mail, :locale
    end
  end
end
