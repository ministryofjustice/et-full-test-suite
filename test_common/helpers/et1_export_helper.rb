module EtFullSystem
  module Test
    module Et1Export
      # Returns a huge array of matchera to validate what an ET1 claim txt file should look like
      #
      # @param [HashWithIndifferentAccess] user The user from the personas
      #
      # @return [Array<String,RSpec::Matchers::BuiltIn::BaseMatcher>] An array of simple strings and rspec matchers for use
      #  as one huge expectation based on the input user.
      def calculated_claim_matchers(args)
        [
          'ET1 - Online Application to an Employment Tribunal',
          '',
          'For Office Use',
          '',
          starting_with('Received at ET: ').and(ending_with(Date.today.strftime("%d/%m/%Y"))),
          'Case Number:',
          'Code:',
          'Initials:',
          '',
          match(/\AOnline Submission Reference: \d{12}\z/),
          '',
          'FormVersion: 2',
          '',
          "~1.1 Title: #{factory_translate(args.dig(:user, :title), locale: :en)}",
          'Title (other):',
          "~1.2 First Names: #{args.dig(:user, :first_name)}",
          "~1.3 Surname: #{args.dig(:user, :last_name)}",
          "~1.4 Date of Birth: #{args.dig(:user, :date_of_birth)}",
          "You are: #{factory_translate(args.dig(:user, :gender), locale: :en)}",
          '~1.5 Address:',
          "Address 1: #{args.dig(:user, :building)}",
          "Address 2: #{args.dig(:user, :street)}",
          "Address 3: #{args.dig(:user, :locality)}",
          "Address 4: #{args.dig(:user, :county)}",
          "Postcode: #{args.dig(:user, :post_code)}",
          "~1.6 Phone number: #{args.dig(:user, :telephone_number)}",
          "Mobile number: #{args.dig(:user, :alternative_telephone_number)}",
          "~1.7 How would you prefer us to communicate with you?: #{factory_translate(args.dig(:user, :correspondence), locale: :en)}",
          "E-mail address: #{args.dig(:user, :email_address)}",
          '',
          "## Section 2: Respondent's details",
          '',
          '~2.1 Give the name of your employer or the organisation or person you are complaining about (the respondent):',
          "Respondent name: #{args.dig(:respondents)[0].dig(:name)}",
          '~2.2 Address:',
          "Respondent Address 1: #{args.dig(:respondents)[0].dig(:building)}",
          "Respondent Address 2: #{args.dig(:respondents)[0].dig(:street)}",
          "Respondent Address 3: #{args.dig(:respondents)[0].dig(:locality)}",
          "Respondent Address 4: #{args.dig(:respondents)[0].dig(:county)}",
          "Respondent Postcode: #{args.dig(:respondents)[0].dig(:post_code)}",
          "Respondent Phone: #{args.dig(:respondents)[0].dig(:telephone_number)}",
          "~2.3 If you worked at an address different from the one you have given at 2.2, please give the full address:",
          "Alternative Respondent Address1: #{args.dig(:respondents)[0].dig(:work_building)}",
          "Alternative Respondent Address2: #{args.dig(:respondents)[0].dig(:work_street)}",
          "Alternative Respondent Address3: #{args.dig(:respondents)[0].dig(:work_locality)}",
          "Alternative Respondent Address4: #{args.dig(:respondents)[0].dig(:work_county)}",
          "Alternative Postcode: #{args.dig(:respondents)[0].dig(:work_post_code)}",
          "Alternative Phone: #{args.dig(:respondents)[0].dig(:work_telephone_number)}",
          '',
          '## Section 8: Your representative',
          '',
          "~8.1 Representative's name: #{args.dig(:representative, :name)}",
          "~8.2 Name of the representative's organisation: #{args.dig(:representative, :organisation_name)}",
          '~8.3 Address:',
          "Representative's Address 1: #{args.dig(:representative, :building)}",
          "Representative's Address 2: #{args.dig(:representative, :street)}",
          "Representative's Address 3: #{args.dig(:representative, :locality)}",
          "Representative's Address 4: #{args.dig(:representative, :county)}",
          "Representative's Postcode: #{args.dig(:representative, :post_code)}",
          "~8.4 Representative's Phone number: #{args.dig(:representative, :telephone_number)}",
          "Representative's Mobile number: #{args.dig(:representative, :alternative_telephone_number)}",
          "~8.5 Representative's Reference: #{args.dig(:representative, :dx_number)}",
          "~8.6 How would they prefer us to communicate with them?:",
          "Representative's E-mail address: #{args.dig(:representative, :email_address)}",
          "~8.7 Representative's Occupation: #{factory_translate(args.dig(:representative, :type), locale: :en)}",
          '',
          '## Section 10: Multiple cases',
          '',
          '~10.2 ET1a Submitted: ',
          '',
          '## Section 11: Details of Additional Respondents',
          '',
          "Name of your employer of the organisation you are claiming against1: #{args.dig(:respondents)[1].try(:dig, :name)}",
          'Address:',
          "AdditionalAddress1 1: #{args.dig(:respondents)[1].try(:dig, :building)}",
          "AdditionalAddress1 2: #{args.dig(:respondents)[1].try(:dig, :street)}",
          "AdditionalAddress1 3: #{args.dig(:respondents)[1].try(:dig, :locality)}",
          "AdditionalAddress1 4: #{args.dig(:respondents)[1].try(:dig, :county)}",
          "AdditionalPostcode1: #{args.dig(:respondents)[1].try(:dig, :post_code)}",
          "AdditionalPhoneNumber1: ",
          "Name of your employer of the organisation you are claiming against2: #{args.dig(:respondents)[2].try(:dig, :name)}",
          "Address:",
          "AdditionalAddress2 1: #{args.dig(:respondents)[2].try(:dig, :building)}",
          "AdditionalAddress2 2: #{args.dig(:respondents)[2].try(:dig, :street)}",
          "AdditionalAddress2 3: #{args.dig(:respondents)[2].try(:dig, :locality)}",
          "AdditionalAddress2 4: #{args.dig(:respondents)[2].try(:dig, :county)}",
          "AdditionalPostcode2: #{args.dig(:respondents)[2].try(:dig, :post_code)}",
          "AdditionalPhoneNumber2: ",
          "Name of your employer of the organisation you are claiming against3: #{args.dig(:respondents)[3].try(:dig, :name)}",
          "Address:",
          "AdditionalAddress3 1: #{args.dig(:respondents)[3].try(:dig, :building)}",
          "AdditionalAddress3 2: #{args.dig(:respondents)[3].try(:dig, :street)}",
          "AdditionalAddress3 3: #{args.dig(:respondents)[3].try(:dig, :locality)}",
          "AdditionalAddress3 4: #{args.dig(:respondents)[3].try(:dig, :county)}",
          "AdditionalPostcode3: #{args.dig(:respondents)[3].try(:dig, :post_code)}",
          "AdditionalPhoneNumber3: "
        ]
      end

      # Returns a huge matcher to validate what an ET1a (the a meaning additional claimants) txt file should look like
      # @param [HashWithIndifferentAccess] user The user from the personas
      #
      # @return [Array<String,RSpec::Matchers::BuiltIn::BaseMatcher>] An array of simple strings and rspec matchers for use
      #  as one huge expectation based on the input user.
      def calculated_et1a_claim_matchers(args)
        matchers = [
          'ET1a - Online Application to an Employment Tribunal',
          '',
          'For Office Use',
          '',
          "Received at ET: #{Date.today.strftime('%d/%m/%Y')}",
          'Case Number:',
          'Code:',
          'Initials:',
          '',
          match(/\AOnline Submission Reference: (?:\d{12})\z/),
          '',
          'FormVersion: 2',
          '',
          "The following claimants are represented by  (if applicable) and the relevant required information for all the additional claimants is the same as stated in the main claim of #{args.dig(:user,:first_name)} #{args.dig(:user, :last_name)} v #{args.dig(:respondents)[0].dig(:name)}",
          '',
          ''

        ]
        group_claimants_for(args.dig(:user, :group_claims_csv)).each do |claimant|
          matchers.concat [
            '## Section et1a: claim',
            '',
            "~1.1 Title: #{factory_translate(claimant[:title], locale: :en)}",
            "~1.2 First Names: #{claimant[:first_name].downcase}",
            "~1.3 Surname: #{claimant[:last_name].downcase}",
            "~1.4 Date of Birth: #{claimant[:date_of_birth]}",
            '~1.5 Address:',
            "Address 1: #{claimant[:building].downcase}",
            "Address 2: #{claimant[:street].downcase}",
            "Address 3: #{claimant[:locality].downcase}",
            "Address 4: #{claimant[:county].downcase}",
            "Postcode: #{claimant[:post_code].downcase}",
            '',
            '',
            ''
          ]
        end
        matchers
      end

      private

      def group_claimants_for(user)
        full_path = File.absolute_path(File.join('..', 'fixtures', user), __dir__)
        raise "#{full_path} does not exist" unless File.exist?(full_path)
        results = CSV.read(full_path, headers: true)
        results.map do |row|
          {
            title: row['Title'],
            first_name: row['First name'],
            last_name: row['Last name'],
            date_of_birth: row['Date of birth'],
            building: row['Building number or name'],
            street: row['Street'],
            locality: row['Town/city'],
            county: row['County'],
            post_code: row['Postcode']
          }
        end
      end
    end
  end
end
