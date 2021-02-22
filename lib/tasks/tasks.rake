# frozen_string_literal: true

task tasks: :environment do
  Rake::Task['tasks'].invoke
end
