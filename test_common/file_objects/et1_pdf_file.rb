require 'rspec/matchers'
require 'pdf-forms'
require_relative './base_pdf_file'
require_relative './et1_pdf_file/base.rb'
Dir.glob(File.absolute_path('./et1_pdf_file/**/*.rb', __dir__)).each { |f| require f }

module EtFullSystem
  module Test
    module FileObjects
      # Represents the ET3 PDF file and provides assistance in validating its contents
      class Et1PdfFile < BasePdfFile # rubocop:disable Metrics/ClassLength
        def has_correct_contents_for?(claim: , claimants:, respondents:, representative:, employment:)
          Et1PdfFileSection::YourDetailsSection.new(tempfile).has_contents_for?(claimant: claimants.first)
          Et1PdfFileSection::RespondentsDetailsSection.new(tempfile).has_contents_for?(respondents: respondents)
          Et1PdfFileSection::MultipleCasesSection.new(tempfile).has_contents_for?(claim: claim)
          Et1PdfFileSection::NotYourEmployerSection.new(tempfile).has_contents_for?
          Et1PdfFileSection::EmploymentDetailsSection.new(tempfile).has_contents_for?(employment: employment)
          Et1PdfFileSection::EarningsAndBenefitsSection.new(tempfile).has_contents_for?(employment: employment)
          Et1PdfFileSection::WhatHappenedSinceSection.new(tempfile).has_contents_for?(employment: employment)
          Et1PdfFileSection::TypeAndDetailsSection.new(tempfile).has_contents_for?(claim: claim)
          Et1PdfFileSection::WhatDoYouWantSection.new(tempfile).has_contents_for?(claim: claim)
          Et1PdfFileSection::InformationToRegulatorsSection.new(tempfile).has_contents_for?(claim: claim)
          Et1PdfFileSection::YourRepresentativeSection.new(tempfile).has_contents_for?(representative: representative)
          Et1PdfFileSection::DisabilitySection.new(tempfile).has_contents_for?(claimant: claimants.first)
          Et1PdfFileSection::AdditionalRespondentsSection.new(tempfile).has_contents_for?(respondents: respondents)
          Et1PdfFileSection::FinalCheckSection.new(tempfile).has_contents_for?
          Et1PdfFileSection::AdditionalInformationSection.new(tempfile).has_contents_for?(claim: claim)
          true
        end
      end
    end
  end
end
