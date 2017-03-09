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
  command = "ansible-playbook -i #{HOSTS_INVENTORY_FILE} --private-key=#{PRIVATE_KEY} playbooks/common.yml -vvv"
  output, error, @status = Open3.capture3 "#{command}"
end

Then(/^it should be successful$/) do
  expect(@status.success?).to eq(true)
end

# Download Android scenario
When(/^I download Android build tools$/) do
  command = "ansible-playbook -i #{HOSTS_INVENTORY_FILE} --private-key=#{PRIVATE_KEY} playbooks/sdk.yml --tags 'sdk_download' -vvv"
  output, error, status = Open3.capture3 "#{command}"

  expect(status.success?).to eq(true)
end

When(/^I update sdk from downloaded tools$/) do
  command = "ansible-playbook -i #{HOSTS_INVENTORY_FILE} --private-key=#{PRIVATE_KEY} playbooks/sdk.yml --tags 'sdk_update' -vvv"
  output, error, @status = Open3.capture3 "#{command}"
end

# Configure Android scenario
When(/^I configure Android environment$/) do
  command = "ansible-playbook -i #{HOSTS_INVENTORY_FILE} --private-key=#{PRIVATE_KEY} playbooks/sdk.yml --tags 'sdk_configure' -vvv"
  output, error, @status = Open3.capture3 "#{command}"
end

# Configure AVD
When(/^I create AVD$/) do
  command = "ansible-playbook -i #{HOSTS_INVENTORY_FILE} --private-key=#{PRIVATE_KEY} playbooks/avd.yml --tags 'avd_configure' -vvv"
  output, error, @status = Open3.capture3 "#{command}"
end

When(/^I should be able to see the device from the list of devices$/) do
  command = "ansible-playbook -i #{HOSTS_INVENTORY_FILE} --private-key=#{PRIVATE_KEY} playbooks/avd.yml --tags 'avd_verify' -vvv"
  output, error, status = Open3.capture3 "#{command}"

  expect(status.success?).to eq(true)
end
