begin
  require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
rescue LoadError
  puts "You need to install rspec in your base app"
  exit
end


ActiveRecord::Schema.define(:version => 1) do
  create_table :semantic_users do |t|
    t.string :name
    t.string :password
    t.string :body
    t.string :file
    t.string :option
  end
end
