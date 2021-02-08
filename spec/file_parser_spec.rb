require 'rspec'
require './lib/log_entry'
require './lib/file_parser'

describe 'FileParser' do
  describe 'read_log' do
    context 'given filename' do
      it 'saves logs split by space to array of LogEntry objects' do
        filename = 'foo.log'
        entries = ['/help_page/1 126.318.035.038', '/contact 184.123.665.067']
        allow(File).to receive(:open).with(filename).and_return entries
        fp = FileParser.new
        fp.read_log(filename)

        expect(fp).to be_instance_of(FileParser)
        expect(fp.entries[0].page).to eql('/help_page/1')
        expect(fp.entries[0].ip).to eql('126.318.035.038')
        expect(fp.entries[1].page).to eql('/contact')
        expect(fp.entries[1].ip).to eql('184.123.665.067')
      end
    end
  end
end
