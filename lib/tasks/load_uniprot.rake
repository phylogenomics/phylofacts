require 'bio/db/embl/sptr201107'
require 'zlib'

namespace :db do
  desc "Load seed uniprot data into the database." 
  task :load_uniprot, [:uniprot_data_path] => :environment do |t, args|
    filename = args[:uniprot_data_path]

    unless File.exists?(filename)
      $stderr.puts "Could not find #{filename}"
      exit 1
    end

    uniprot_dat = Zlib::GzipReader.open(filename)

    puts "loading proteins from #{filename}"
    Tire.index('proteins') { delete }

    current_protein = ''
    proteins = []
    found_proteins = 0;
    parse_time = 0.0
    load_time = 0.0
    total_time = 0 - Time.now.to_f

    while (line = uniprot_dat.gets)
      current_protein << line

      unless line[/^\/\//].nil?
        found_proteins += 1
        
        parse_time -= Time.now.to_f
        proteins << Protein.new_from_uniprot(current_protein)
        parse_time += Time.now.to_f

        current_protein = ''

        if found_proteins % 500 == 0
          load_time -= Time.now.to_f
          Tire.index('proteins') { import proteins }
          load_time += Time.now.to_f
          proteins.clear

          puts "loaded #{found_proteins} proteins"
        end

      end
    end

    load_time -= Time.now.to_f
    Tire.index('proteins') { import proteins } unless proteins.empty?
    load_time += Time.now.to_f

    total_time += Time.now.to_f
    uniprot_dat.close
    puts "finished loading #{found_proteins} proteins"
    puts "parse: %.4fs" % parse_time
    puts "load:  %.4fs" % load_time
    puts "total: %.4fs" % total_time
  end
end
