namespace :db do
  namespace :data_migrations do

    desc "Apply data migrations in the folder #{DATA_MIGRATION_DIR} up to VERSION."
    task :apply => :environment do
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
      DataMigrations::DataFixMigrator.migrate("db/data_migrations/", ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
    end

  end
end
