class Hybrid_cross
  attr_accessor :p1
  attr_accessor :p2
  attr_accessor :f2_wild
  attr_accessor :f2_p1
  attr_accessor :f2_p2
  attr_accessor :f2_p1p2
  @@table_information = Array.new
  
  #----------------------------------#
  
  def initialize(params = {})
    @p1 = params.fetch(:p1, "not available")
    @p2 = params.fetch(:p2, "not available")
    @f2_wild = params.fetch(:f2_wild, "not available")
    @f2_p1 = params.fetch(:f2_p1, "not available")
    @f2_p2 = params.fetch(:f2_p2, "not available")
    @f2_p1p2 = params.fetch(:f2_p1p2, "not available")
    @@table_information << self
  end
  
  #--------------------------------------------#
  
  def self.all_table
    
    return @@table_information
  end
  
  #----------------------------------------------#
  
  def self.load_data(file)
    
    unless File.exists?(file)
      abort "No esta el archivo"
    end
    
    ld = File.open(file,"r")
    ld.readline
    ld.each_line do |line|
      parent1,parent2,f2_w,f2_parent1,f2_parent2,f2_parent1_2 = line.split("\t")
      
      Hybrid_cross.new(
        :p1 => Seed_stock.take_seed_id(parent1),
        :p2 => Seed_stock.take_seed_id(parent2),
        :f2_wild => f2_w.to_i,
        :f2_p1 => f2_parent1.to_i,
        :f2_p2 => f2_parent2.to_i,
        :f2_p1p2 => f2_parent1_2.to_i
      )
    end
    ld.close
  end
  #----------------------------------------#
  
  def self.chisquare(obj)
    total = obj.f2_wild+obj.f2_p1+obj.f2_p2+obj.f2_p1p2
    esp1 = ((total * 9) / 16).to_f
    esp2 = ((total * 3) / 16).to_f
    esp3 = ((total * 3) / 16).to_f
    esp4 = ((total) / 16).to_f
    
    chi_square = (((obj.f2_wild - esp1) ** 2) / esp1 + ((obj.f2_p1 - esp2) ** 2) / esp2 + ((obj.f2_p2 - esp3) ** 2) / esp3 + ((obj.f2_p1p2 - esp4) ** 2) / esp4).to_f
    if chi_square >= 3.48
      puts "Recording: #{obj.p1.mutant_id.gene_name} is genetically linked to #{obj.p2.mutant_id.gene_name} with chisquare score #{chi_square}"
      obj.p1.mutant_id.linked = obj.p2.mutant_id
      obj.p2.mutant_id.linked = obj.p1.mutant_id
    end
  end
  
  #----------------------------------------#
  
end

