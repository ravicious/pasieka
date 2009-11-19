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
  t.libs << 'lib' << 'spec'
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end

desc "Load environment"
task :environment do

  require "app"

end

namespace :messages do

  desc "Save typos to the database"
  task :save => :environment do
    typos_before = Typo.all.count
    typo_counters_before = TypoCounter.all.count

    Miodek.get_messages.each do |msg|
      Pasieka.parse_message msg
    end

    Pasieka.save_typos

    typos_after = Typo.all.count
    typo_counters_after = TypoCounter.all.count

    puts "#{typos_after - typos_before} typos and #{typo_counters_after - typo_counters_before} typo counters saved into the database"
  end

end
