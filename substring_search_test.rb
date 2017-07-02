require 'hitimes'
require "./SubstringSearch.rb"

rand = Random.new_seed
vals = ['a', 't', 'g']
txt = ''

5_000_000.times do
  num = rand(3)
  txt << vals[num]
end

txt << 'ctta'

brute_force_search = SubstringSearch::BruteForce.new('ctta')
puts brute_force_search.search(txt)

kmp_search = SubstringSearch::KMP.new('ctta')
puts kmp_search.search(txt)

boyer_moore_search = SubstringSearch::BoyerMoore.new('ctta')
puts boyer_moore_search.search(txt)