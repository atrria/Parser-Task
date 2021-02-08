require 'rspec'
require './lib/visits_analyzer'
require './lib/file_parser'
require './lib/log_entry'

describe 'VisitsAnalyzer' do
  before do
    @filename = 'foo.log'
    @entries = ['/help_page/1 126.318.035.038', '/contact 184.123.665.067', '/help_page/1 126.318.035.038',
                '/contact 184.123.665.067', '/home 184.123.665.067', '/about/2 444.701.448.104']
    allow(File).to receive(:open).with(@filename).and_return(@entries)
    @va = VisitsAnalyzer.new(@filename)
  end
  
  describe 'initialize' do
    context 'given filename' do
      it 'creates FileParser object and updates it with file contents' do
        expect(@va).to be_instance_of(VisitsAnalyzer)
        expect(@va.data).to be_instance_of(FileParser)
        expect(@va.data.entries[0].page).to eql('/help_page/1')
        expect(@va.data.entries[0].ip).to eql('126.318.035.038')
        expect(@va.data.entries.length).to eql(6)
      end
    end
  end

  describe 'evaluate_visits' do
    it 'prints evaluated number of visits per page' do
      output = "Visits per page:\n/help_page/1 visits: 2\n/contact visits: 2\n/about/2 visits: 1\n/home visits: 1\n"
      expect{ @va.evaluate_visits }.to output(output).to_stdout
    end
  end

  describe 'evaluate_unique_visits' do
    it 'prints evaluated number of unique visits per page' do
      output = "Unique visits per page:\n/help_page/1 unique visits: 1\n/about/2 unique visits: 1\n/home unique visits: 1\n/contact unique visits: 1\n"
      expect{ @va.evaluate_unique_visits }.to output(output).to_stdout
    end
  end
end
