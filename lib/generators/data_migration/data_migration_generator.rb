class DataMigrationGenerator < Rails::Generator::NamedBase  
  def manifest
    record do |m|
      m.migration_template 'migration.rb', DataMigrations::DATA_MIGRATION_DIR
    end
  end
end
