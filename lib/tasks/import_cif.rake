namespace :cif do
  desc 'Import all CIF task'
  task import: :environment do
    Rake::Task['clients:import'].invoke
    # Rake::Task['agencies:import'].invoke
    # Rake::Task['departments:import'].invoke
    # Rake::Task['provinces:import'].invoke
    # Rake::Task['referral_sources:import'].invoke
    # Rake::Task['quantitative_types:import'].invoke
    # Rake::Task['quantitative_cases:import'].invoke
  end
end
