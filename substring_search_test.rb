require 'hitimes'
require "./SubstringSearch.rb"


alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~!@#$%^&*()_=-+?><.,"
alphabet = alphabet.split('')
alphabet.push("NEEDLE")

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

correctness(alphabet)
