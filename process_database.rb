require './Genes.rb'
require './Seed_stock.rb'
require './Hybrid_cross.rb'

Gene.load_data('gene_information.tsv')
Seed_stock.load_data('seed_stock_data.tsv')
Hybrid_cross.load_data('cross_data.tsv')
Seed_stock.table_update('seed_stock_data_update.tsv')

Hybrid_cross.all_table.each do |hybrid|
  Hybrid_cross.chisquare(hybrid)
end

puts "Final report:"
Gene.all_table.each do |id, objs|
  if objs.linked
    puts "#{objs.gene_name} is linked to #{objs.linked.gene_name}"
  end
end