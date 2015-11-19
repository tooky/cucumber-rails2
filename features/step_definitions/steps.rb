Then(/^it should pass$/) do
  expect(last_command_started).to be_successfully_executed
end

Then(/^it should fail$/) do
  expect(last_command_started).to have_failed_running
end

Given(/^"([^"]*)" is appended with:$/) do |file_name, file_content|
  append_to_file(file_name, file_content)
end
