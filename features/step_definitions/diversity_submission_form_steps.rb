Then("the populated data is displayed on the submission page") do
  diversity_pages.submission_form_page.has_correct_data_populated?(@diversity)
end
