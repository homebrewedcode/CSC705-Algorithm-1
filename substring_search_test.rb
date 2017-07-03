require 'hitimes'
require "./SubstringSearch.rb"

rand = Random.new_seed
vals = ['a', 't', 'g']
txt = ''

10.times do
  #num = rand(3)
  txt << "AAAAA"
end

txt << 'ABABAC'

brute_force_search = SubstringSearch::BruteForce.new('ABABAC')
puts brute_force_search.search(txt)

kmp_search = SubstringSearch::KMP.new('ABABAC')
puts kmp_search.search(txt)

boyer_moore_search = SubstringSearch::BoyerMoore.new('ABABAC')
puts boyer_moore_search.search(txt)