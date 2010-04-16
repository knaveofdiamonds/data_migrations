namespace :db do
  namespace :data_migrations do

    desc "Apply data migrations in the folder 'db/data_migrations' up to VERSION."
    task :apply => :environment do
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
      DataMigrations::DataMigrator.migrate(DataMigrations::DATA_MIGRATION_DIR, ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
    end

  end
end
