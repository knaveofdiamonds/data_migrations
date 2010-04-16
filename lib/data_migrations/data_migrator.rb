module DataMigrations
  # Runs data Migrations
  class DataMigrator < ActiveRecord::Migrator
    # Overrides Migrator's initialize method to make sure
    # DATA_MIGRATION_TABLE is present rather than schema_info.
    def initialize(direction, migrations_path, target_version = nil)
      raise StandardError.new("This database does not yet support migrations") unless ActiveRecord::Base.connection.supports_migrations?
      create_data_fix_table
      @direction, @migrations_path, @target_version = direction, migrations_path, target_version      
    end
    
    # Returns the fully qualified data migration table name.
    def self.schema_migrations_table_name
      ActiveRecord::Base.table_name_prefix + DATA_MIGRATION_TABLE + ActiveRecord::Base.table_name_suffix
    end

    private

    def create_data_fix_table
      sm_table = self.class.schema_migrations_table_name
      unless ActiveRecord::Base.connection.tables.detect { |t| t == sm_table }
        ActiveRecord::Base.connection.create_table(sm_table, :id => false) do |schema_migrations_table|
          schema_migrations_table.column :version, :string, :null => false
        end
        ActiveRecord::Base.connection.add_index sm_table, :version, :unique => true, :name => "#{Base.table_name_prefix}unique_data_fixes#{Base.table_name_suffix}"
      end
    end
  end
end
