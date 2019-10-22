class Gene
  attr_accessor :gene_id
  attr_accessor :gene_name
  attr_accessor :mutant_phenotype
  attr_accessor :linked
  @@table_information = Hash.new
  
  #------------------------------#
  
  def initialize (params = {})
    @gene_id = params.fetch(:gene_id, "id not available")
    @gene_name = params.fetch(:gene_name, "name not available")
    @mutant_phenotype = params.fetch(:mutant_phenotype, "phenotype not available")
    @linked = params.fetch(:linked, false)
    @@table_information[gene_id] = self
  end
  
  #--------------------------------------#
  
  def self.all_table
    
    return @@table_information
  end
  
  #--------------------------------------#
  
  def self.take_gene_id(id)
    if @@table_information.has_key?(id)
      return @@table_information[id]
    else
      return "Error"
    end
  end
  
  
  #--------------------------------------#
  
  def self.load_data(file)
    
    unless File.exists?(file)
      abort "The file doesnt exists"
    end
    
    ld = File.open(file,"r")
    ld.readline
    ld.each_line do |line|
      id,name,type = line.split("\t")
      
      Gene.new(
        :gene_id => id,
        :gene_name => name,
        :mutant_phenotype => type,
        )
    end
    ld.close
  end
#-----------------------------------------#


  


end

