begin
  require 'database_cleaner'

  Before('@javascript') do
    Cucumber::Rails::Database.before_js
  end

  Before('~@javascript') do
    Cucumber::Rails::Database.before_non_js
  end

  After do
    Cucumber::Rails::Database.after
  end

  Before do
    DatabaseCleaner.start
  end

  After do
    DatabaseCleaner.clean
  end

rescue LoadError => _ignore_if_database_cleaner_not_present
end

