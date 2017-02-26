require 'open3'

# Background
Given(/^that I have a running linux server$/) do
  output, error, status = Open3.capture3 "#{RUNNING_SERVER_CHECK}"
  expect(status.success?).to eq(true)
end

Given(/^I provision it$/) do
  output, error, status = Open3.capture3 "#{SERVER_PROVISION_COMMAND}"
  expect(status.success?).to eq(true)
end

# Dependencies scenario
When(/^I install dependencies \(e\.g\. Java, Git, etc\)$/) do
  command = "ansible-playbook -i #{HOSTS_INVENTORY_FILE} --private-key=#{PRIVATE_KEY} playbooks/common.yml"
  output, error, @status = Open3.capture3 "#{command}"
end