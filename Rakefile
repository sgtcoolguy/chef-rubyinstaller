require 'bundler/setup'
require 'rspec/core/rake_task'
require 'foodcritic'
require 'stove/rake_task'
require 'cookstyle'
require 'rubocop/rake_task'

FoodCritic::Rake::LintTask.new do |t|
  t.options = {
    cookbook_paths: '.',
    fail_tags: ['any']
  }
end

RSpec::Core::RakeTask.new :spec

RuboCop::RakeTask.new do |task|
  task.options << '--display-cop-names'
end

desc 'Default task. Runs Foodcritic, Chefspec, and Rubocop'
task default: [:foodcritic, :spec, :rubocop]
