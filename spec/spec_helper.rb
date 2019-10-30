# frozen_string_literal: true

require "jekyll-readme-index"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.example_status_persistence_file_path = "spec/examples.txt"

  config.default_formatter = "doc" if config.files_to_run.one?

  config.order = :random
  Kernel.srand config.seed
end

Jekyll.logger.adjust_verbosity(:quiet => true)

def fixture_path(fixture)
  File.expand_path "./fixtures/#{fixture}", File.dirname(__FILE__)
end

def fixture_site(fixture, override = {})
  default_config = { "source" => fixture_path(fixture) }
  config = Jekyll::Utils.deep_merge_hashes(default_config, override)
  config = Jekyll.configuration(config)
  Jekyll::Site.new(config)
end

RSpec::Matchers.define :be_an_existing_file do
  match { |path| File.exist?(path) }
end

fixture_site("readme-no-index").process
