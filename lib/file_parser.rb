class FileParser
  attr_accessor :entries
  
  def initialize
    @entries = []
  end
  
  def read_log(filename)
    File.open(filename).each do |line|
      entry = line.split(' ')
      @entries << LogEntry.new(entry[0], entry[1])
    end
  rescue Errno::ENOENT, Errno::EACCES => e
    puts "Unable to open #{filename}.\n#{e.message}"
    exit(1)
  end
end
