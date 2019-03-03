namespace :importers do
  desc 'Import Shopify CSV'
  task :shopify, %i(file_path) => :environment do |_t, args|
    ShopifyImporter.do_it(args[:file_path])
  end
end
