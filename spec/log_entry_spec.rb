require 'rspec'
require './lib/log_entry'

describe 'LogEntry' do
  describe 'initialize' do
    context 'given page path and ip' do
      it 'initializes LogEntry object' do
        le = LogEntry.new('/help_page/1', '126.318.035.038')
        expect(le).to be_instance_of(LogEntry)
        expect(le.page).to eql('/help_page/1')
        expect(le.ip).to eql('126.318.035.038')
      end
    end
  end
end
