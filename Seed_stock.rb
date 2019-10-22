class Seed_stock
  attr_accessor :stock_id
  attr_accessor :mutant_id
  attr_accessor :last_planted
  attr_accessor :storage
  attr_accessor :grams_remaining
  @@table_information = Hash.new
  
  #-------------------------------#
  
  def initialize(params = {})
    @stock_id= params.fetch(:stock_id, "stock not available")
    @mutant_id = params.fetch(:mutant_id, "id not available")
    @last_planted = params.fetch(:last_planted, "date not available")
    @storage = params.fetch(:storage, "storage not available")
    @grams_remaining = params.fetch(:grams_remaining, "grams not available")
    @@table_information[stock_id] = self
  
  end
  
  #--------------------------------#
  
  def self.all_table
    
    return @@table_information
  end
  
  #--------------------------------------#
  
  def self.take_seed_id(id)
    if @@table_information.has_key?(id)
      return @@table_information[id]
    else
      return "Error"
    end
  end
  
  #--------------------------------------#
  #--------------------------------------#
  
  def self.load_data(file)
    
    unless File.exists?(file)
      abort "No esta el archivo"
    end
    
    ld = File.open(file,"r")
    ld.readline
    ld.each_line do |line|
      stck,mtnt_id,lst,strg,grms = line.split("\t")
      
      Seed_stock.new(
        :stock_id => stck,
        :mutant_id => Gene.take_gene_id(mtnt_id),
        :last_planted => lst,
        :storage => strg,
        :grams_remaining => grms.to_i,
      )
    end
    ld.close
  end
  
#---------------------------------------------#
  def plant(new_grams)
    new_grams = new_grams.to_i
    if new_grams < @grams_remaining
     @grams_remaining -= new_grams
    else
      @grams_remaining  = 0
      puts "WARNING: We have run out of seeds #{stock_id}"
    end
  end

#---------------------------------------------#
def self.table_update(file)
  if File.exists? (file)
    File.delete(file)
  end
  tu = File.open(file, "a+")
  date = Time.now.strftime("%d/%m/%Y")
  @@table_information.each do |id, objs|
    objs.plant(7)
    objs.last_planted = date
    tu.puts "#{id}\t#{objs.mutant_id.gene_id}\t#{date}\t#{objs.storage}\t#{objs.grams_remaining}"
  end
end

#---------------------------------------------#
end
#---------------------------------------------#

  

