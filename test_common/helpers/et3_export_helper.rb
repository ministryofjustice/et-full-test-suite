module EtFullSystem
  module Test
    module Et3Export
      # Returns a huge array of matchers to validate what an ET3 response txt file should look like
      #
      # @param [HashWithIndifferentAccess] user The user from the personas
      #
      # @return [Array<String,RSpec::Matchers::BuiltIn::BaseMatcher>] An array of simple strings and rspec matchers for use
      #  as one huge expectation based on the input user.
      def calculated_response_matchers(args)
        [
          'ET3 - Response to an Employment Tribunal claim',
          '',
          'For Office Use',
          '',
          starting_with('Received at ET: ').and(ending_with(Date.today.strftime("%d/%m/%Y"))),
          starting_with('Case Number: ').and(ending_with(args.dig(:respondent, :case_number))),
          'Code:',
          'Initials:',
          '',
          match(/\AOnline Submission Reference: \d{10}00\z/),
          '',
          'FormVersion: 2',
          '',
          '## Intro: ',
          '',
          starting_with('**In the claim of: ').and(ending_with(args.dig(:user, :claimants_name))),
          starting_with('**Case number: ').and(ending_with(args.dig(:respondent, :case_number))),
          starting_with('**Tribunal office: ').and(ending_with('@hmcts.gsi.gov.uk')),
          '',
          "## Section 1: Claimant's name",
          '',
          starting_with("~1.1 Claimant's name: ").and(ending_with(args.dig(:user, :claimants_name))),
          '',
          "## Section 2: Your organisation's details",
          '',
          starting_with('~2.1 Name of your organisation: ').and(ending_with(args.dig(:respondent, :name))),
          "Contact name: #{args.dig(:respondent, :contact)}",
          "~2.2 Address",
          "Address 1: #{args.dig(:respondent, :building_name)}",
          "Address 2: #{args.dig(:respondent, :street_name)}",
          "Address 3: #{args.dig(:respondent, :town)}",
          "Address 4: #{args.dig(:respondent, :county)}",
          "Postcode: #{args.dig(:respondent, :postcode)}",
          "~2.3 Phone number: #{args.dig(:respondent, :contact_number)}",
          "Mobile number: #{args.dig(:respondent, :contact_mobile_number)}", 
          "~2.4 How would you prefer us to communicate with you?: #{factory_translate(args.dig(:respondent, :contact_preference), locale: :en).downcase}",
          "E-mail address: #{args.dig(:respondent, :email_address)}",
          '',
          "## Section 7: Your representative",
          '',
          "~7.1 Representative's name: #{args.dig(:representative, :name)}",
          "~7.2 Name of the representative's organisation: #{args.dig(:representative, :organisation_name)}",
          "Representative's Address 1: #{args.dig(:representative, :building)}",
          "Representative's Address 2: #{args.dig(:representative, :street)}",
          "Representative's Address 3: #{args.dig(:representative, :locality)}",
          "Representative's Address 4: #{args.dig(:representative, :county)}",
          "Representative's Postcode: #{args.dig(:representative, :post_code)}",
          "~7.4 Representative's Phone number: #{args.dig(:representative, :telephone_number)}",
          "~7.5 Representative's Reference: #{args.dig(:representative, :representative_reference)}",
          "~7.6 How would they prefer us to communicate with them?: #{factory_translate(args.dig(:representative, :representative_contact_preference), locale: :en).downcase}",
          "Representative's E-mail address: #{args.dig(:representative, :representative_email)}",
          '',
          '**Version: Jadu 1.0',
          ''
        ]
      end
    end
  end
end
