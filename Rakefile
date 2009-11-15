require "rubygems"
require "rake"

require 'spec/rake/spectask'

desc "Rin all examples and clear test database before"
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.spec_opts = %w(-fs)
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new('rcov') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end

desc "Load environment"
task :environment do

  require "app"

end

namespace :messages do

  desc "Get recent messages manually"
  task :parse => :environment do

    @miodek.get_messages.each do |msg|
      @pasieka.parse_message msg
    end

  end

  desc "Save typos to the database"
  task :save => :parse do
    count_before = Typo.all.count

    @pasieka.save_typos

    count_after = Typo.all.count
    puts "#{count_after - count_before} typos saved into the database"
  end

end
