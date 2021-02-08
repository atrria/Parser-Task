class VisitsAnalyzer
  attr_accessor :data

  def initialize(filename)
    @data = FileParser.new
    @data.read_log(filename)
  end

  def evaluate_visits
    page_visits = Hash.new(0)
    @data.entries.each { |entry| page_visits[entry.page] += 1 }

    page_visits = page_visits.sort_by { |_, counter| counter }.reverse!
    puts 'Visits per page:'
    page_visits.each { |page, counter| puts "#{page} visits: #{counter}" }
  end

  def evaluate_unique_visits
    page_visits_by_ip = Hash.new(0)
    page_unique_visits = Hash.new(0)

    @data.entries.each { |entry| page_visits_by_ip[[entry.page, entry.ip]] += 1 }
    page_visits_by_ip.each_key { |key| page_unique_visits[key[0]] += 1 }

    page_unique_visits = page_unique_visits.sort_by { |_, counter| counter }.reverse!
    puts 'Unique visits per page:'
    page_unique_visits.each { |page, counter| puts "#{page} unique visits: #{counter}" }
  end
end
