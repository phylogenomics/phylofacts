namespace :db do
  desc "Load seed uniprot data into the database." 
  task :load_uniprot, [:uniprot_data_path] => :environment do |t, args|
    require 'bio/db/embl/sptr201107'

    uniprot_string = File.read(args[:uniprot_data_path])
    uniprot_data = Bio::SPTR201107.new(uniprot_string)

    prot = Protein.new
    prot.sequence = uniprot_data.seq
    primary_accession = true
    accessions_mapping = uniprot_data.accessions.each.map do |accession|
      ua = UniprotAccession.new
      ua.accession = accession
      pa = ProteinAccession.new
      pa.primary = primary_accession
      primary_accession = false
      ua.save
      pa.accession_id = ua.id
      pa
    end

    prot.protein_accessions = accessions_mapping
    prot.save
  end
end
