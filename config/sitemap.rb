# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://bookcamping.cc"
SitemapGenerator::Sitemap.sitemaps_path = 'shared/'

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  #

  Library.find_each do |library|
    add shelves_path(library: library), lastmod: library.updated_at

    library.shelves.each do |shelf|
      add shelf_path(shelf, library: library)
    end
  end

  Reference.find_each do |reference|
    add reference_path(reference), lastmod: reference.updated_at
  end


  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
