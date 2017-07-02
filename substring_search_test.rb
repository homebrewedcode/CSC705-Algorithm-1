require 'hitimes'
require "./SubstringSearch"

txt = ""
1_000_000.times do
  txt << 'a'
end

txt << 'bbb'

puts SubstringSearch.brute_force('bbb', txt)

kmp_search = SubstringSearch::KMP.new('bbb')

puts kmp_search.search(txt)

