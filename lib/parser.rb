require './log_entry'
require './file_parser'
require './visits_analyzer'

va = VisitsAnalyzer.new(ARGV[0])

va.evaluate_visits
va.evaluate_unique_visits
