# et-full-test-suite
Employment tribunal full test suite

Running The end-to-end test suite in different environments and using profile
local: ./bin/dev/test_exec bundle exec cucumber dev: ./bin/dev/test_exec bundle exec cucumber ENVIRONMENT=dev staging: ./bin/dev/test_exec bundle exec cucumber ENVIRONMENT=staging

Using cucumber.yml profile
./bin/dev/test_exec bundle exec cucumber -p smoke_test

Running test in parallel
./bin/dev/test_exec bundle exec parallel_cucumber features/ ENVIRONMENT=dev

Running test in different locale
TEST_LOCALE=cy [if left blank it will default to english']