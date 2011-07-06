namespace :db do
  desc "Load seed uniprot data into the database." 
  task :load_uniprot do
    require 'active_record/base'
    require 'bio/db/embl/sptr201107'
    puts "hey, I'm loading uniprot"
  end
end
