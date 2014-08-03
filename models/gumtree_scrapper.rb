require 'mechanize'

class GumtreeScrapper
  def initialize(service, terms, postal_code) 
    @service = service
    @terms = terms
    @postal_code = postal_code
  end

  def scrape
    agent = Mechanize.new
    page = agent.get(grab_url)

    search_form = page.forms.first
    search_form.q = @terms
    search_form.search_location = @postal_code

    page = agent.submit(search_form)
    parse(page)
  end

  def grab_url
    case @service.downcase
    when "gumtree"
      return "http://www.gumtree.com/"
    else
      return "http://www.gumtree.com/"
    end
  end

  def parse(page)
    description_links = page.search("ul.ad-listings").search("a.description")
    links = []
    description_links.each do |link|
      links << [link[:title], link[:href]]
    end
    links
  end
end