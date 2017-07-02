require 'hitimes'
require "./SubstringSearch.rb"

txt = ""
10_000.times do
  txt << 'a'
end

txt << 'bbb'

brute_force_search = SubstringSearch::BruteForce.new('bbb')

puts brute_force_search.search(txt)

kmp_search = SubstringSearch::KMP.new('bbb')

puts kmp_search.search(txt)

boyer_moore_search = SubstringSearch::BoyerMoore.new('bbb')

puts boyer_moore_search.search(txt)