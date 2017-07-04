require 'hitimes'
require "./SubstringSearch.rb"


alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~!@#$%^&*()_=-+?><.,"
alphabet = alphabet.split('')
alphabet.push("NEEDLE")

# correctness test
def correctness(alphabet)

  needle = 'NEEDLE'
  fail = 0
  pass = 0
  found = 0
  brute_force_search = SubstringSearch::BruteForce.new(needle)
  kmp_search = SubstringSearch::KMP.new(needle)
  boyer_moore_search = SubstringSearch::BoyerMoore.new(needle)


  # Random Cases, run 1k times
  10_000.times do
    txt = ''
    # make a random string of 100 characters
    100.times do
      num = rand(alphabet.length)
      txt << alphabet[num]
    end

    brute_force = brute_force_search.search(txt)
    kmp = kmp_search.search(txt)
    boyer_moore = boyer_moore_search.search(txt)

    if brute_force == kmp && brute_force == boyer_moore
      pass += 1
    else
      fail += 1
    end

    if brute_force < txt.length
      found += 1
    end

  end

  puts "========================RANDOM CASES=============================\n"
  puts "Pass cases: #{pass}\nFail cases: #{fail}\nTotal needles found: #{found}\n\n"

  # Remove our Needle from the search string and verify all failures
  alphabet.pop
  pass = 0
  fail = 0
  found = 0

  10_000.times do
    txt = ''
    # make a random string of 100 characters
    100.times do
      num = rand(alphabet.length)
      txt << alphabet[num]
    end

    brute_force = brute_force_search.search(txt)
    kmp = kmp_search.search(txt)
    boyer_moore = boyer_moore_search.search(txt)

    if brute_force == kmp && brute_force == boyer_moore
      pass += 1
    else
      fail += 1
    end

    if brute_force < txt.length
      found += 1
    end

  end

  puts "========================NO NEEDLE CASES=============================\n"
  puts "Pass cases: #{pass}\nFail cases: #{fail}\nTotal needles found: #{found}\n\n"

  # Edge case, needle is at end of search string
  pass = 0
  fail = 0
  found = 0

  10_000.times do
    txt = ''
    # make a random string of 100 characters
    100.times do
      num = rand(alphabet.length)
      txt << alphabet[num]
    end
    txt << needle

    brute_force = brute_force_search.search(txt)
    kmp = kmp_search.search(txt)
    boyer_moore = boyer_moore_search.search(txt)

    if brute_force == kmp && brute_force == boyer_moore
      pass += 1
    else
      fail += 1
    end

    if brute_force < txt.length
      found += 1
    end

  end
  puts "========================NEEDLE AT END CASES=============================\n"
  puts "Pass cases: #{pass}\nFail cases: #{fail}\nTotal needles found: #{found}\n\n"

  # Edge case, needle is at beginning of search string
  pass = 0
  fail = 0
  found = 0

  10_000.times do
    txt = 'NEEDLE'
    # make a random string of 100 characters
    100.times do
      num = rand(alphabet.length)
      txt << alphabet[num]
    end

    brute_force = brute_force_search.search(txt)
    kmp = kmp_search.search(txt)
    boyer_moore = boyer_moore_search.search(txt)

    if brute_force == kmp && brute_force == boyer_moore
      pass += 1
    else
      fail += 1
    end

    if brute_force < txt.length
      found += 1
    end

  end

  puts "========================NEEDLE AT BEGINNING CASES=============================\n"
  puts "Pass cases: #{pass}\nFail cases: #{fail}\nTotal needles found: #{found}\n\n"

end

# Brute force tests
def brute_force_average(alphabet)
  needle = 'NEEDLE'
  brute_force_search = SubstringSearch::BruteForce.new(needle)
  n = 250_000

  puts "***************************************************************************"
  puts "******************Brute Force Average Case, Doubling N Test****************"
  puts "***************************************************************************\n\n"

  5.times do
    txt = ''
    timed_metric = Hitimes::TimedMetric.new('operation on items')

    5.times do

      n.times do
        num = rand(alphabet.length)
        txt << alphabet[num]
      end

      timed_metric.start
      brute_force_search.search(txt)
      timed_metric.stop
    end
    puts "Pass n = #{ n.to_s.reverse.scan(/\d{1,3}/).join(",").reverse }=======================\n\n"
    puts "Mean run time: #{ timed_metric.mean.round(4) }\n"
    puts "Max run time: #{ timed_metric.max.round(4) }\n"
    puts "Min run time: #{ timed_metric.min.round(4) }\n\n"
    n = n * 2
  end
end

def brute_force_worst()
  needle_length = 29
  n = 250_000

  puts "***************************************************************************"
  puts "******************Brute Force Worst Case, Doubling M Test****************"
  puts "***************************************************************************\n\n"

  5.times do
    txt = ''
    needle = ''
    timed_metric = Hitimes::TimedMetric.new('operation on items')

    needle_length.times { needle << 'A'}
    needle << 'B'

    brute_force_search = SubstringSearch::BruteForce.new(needle)

    5.times do

      n.times do
        txt << 'A'
      end

      txt << needle

      timed_metric.start
      brute_force_search.search(txt)
      timed_metric.stop

    end
    puts "Pass m = #{ needle.length } =======================\n\n"
    puts "Mean run time: #{ timed_metric.mean.round(4) }\n"
    puts "Max run time: #{ timed_metric.max.round(4) }\n"
    puts "Min run time: #{ timed_metric.min.round(4) }\n\n"

    needle_length = (needle.length * 2) - 1
  end
end

# KMP tests
def kmp_average(alphabet)
  needle = 'NEEDLE'
  kmp_search = SubstringSearch::KMP.new(needle)
  n = 250_000

  puts "***************************************************************************"
  puts "******************KMP Average Case, Doubling N Test************************"
  puts "***************************************************************************\n\n"

  5.times do
    txt = ''
    timed_metric = Hitimes::TimedMetric.new('operation on items')

    5.times do

      n.times do
        num = rand(alphabet.length)
        txt << alphabet[num]
      end

      timed_metric.start
      kmp_search.search(txt)
      timed_metric.stop
    end
    puts "Pass n = #{ n.to_s.reverse.scan(/\d{1,3}/).join(",").reverse }=======================\n\n"
    puts "Mean run time: #{ timed_metric.mean.round(4) }\n"
    puts "Max run time: #{ timed_metric.max.round(4) }\n"
    puts "Min run time: #{ timed_metric.min.round(4) }\n\n"
    n = n * 2
  end
end

def kmp_worst()

  n, m = 25_000, 25_000

  puts "***************************************************************************"
  puts "******************KMP, Doubling M = N Test*********************************"
  puts "***************************************************************************\n\n"

  5.times do
    txt = ''
    needle = ''
    n.times { txt << 'A' }
    m.times { needle << 'A' }

    timed_metric_build_dfa = Hitimes::TimedMetric.new('operation on items')
    timed_metric_search = Hitimes::TimedMetric.new('operation on items')

    5.times do
      timed_metric_build_dfa.start
      kmp = SubstringSearch::KMP.new(needle)
      timed_metric_build_dfa.stop

      timed_metric_search.start
      kmp.search(txt)
      timed_metric_search.stop

    end

    puts "Pass m = #{ m.to_s.reverse.scan(/\d{1,3}/).join(",").reverse }, n = #{ n.to_s.reverse.scan(/\d{1,3}/).join(",").reverse } =======================\n\n"
    puts "Mean run time of DFA build: #{ timed_metric_build_dfa.mean.round(4) }\n"
    puts "Max run time of DFA build: #{ timed_metric_build_dfa.max.round(4) }\n"
    puts "Min run time of DFA build: #{ timed_metric_build_dfa.min.round(4) }\n\n"
    puts "Mean run time search: #{ timed_metric_search.mean.round(4) }\n"
    puts "Max run time search: #{ timed_metric_search.max.round(4) }\n"
    puts "Min run time search: #{ timed_metric_search.min.round(4) }\n\n"

    n *= 2
    m *= 2
  end

end

# Boyer-Moore tests


# correctness(alphabet)
# brute_force_average()
# kmp_average(alphabet)
# kmp_worst


