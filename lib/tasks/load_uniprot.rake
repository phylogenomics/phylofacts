require 'bio/db/embl/sptr201107'

namespace :db do
  desc "Load seed uniprot data into the database." 
  task :load_uniprot, [:uniprot_data_path] => :environment do |t, args|
    filename = args[:uniprot_data_path]

    unless File.exists?(filename)
      $stderr.puts "Could not find #{filename}"
      exit 1
    end

    uniprot_dat = File.new(filename)

    current_protein = ''
    found_proteins = 0;
    while (line = uniprot_dat.gets)
      current_protein << line

      if (line =~ /^\/\//) != nil
        Protein.create_from_uniprot(current_protein)
        if found_proteins % 100 == 0
          puts "loaded #{found_proteins} proteins"
        end
        found_proteins += 1
        current_protein = ''
      end
    end
    uniprot_dat.close
    puts "finished loading #{found_proteins} proteins from #{filename}"
  end
end
