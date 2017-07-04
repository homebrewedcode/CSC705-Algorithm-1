module SubstringSearch
  ASCII_CHARS = 256 # constant for arrays of ASCII characters

  # naive brute force method for substring search algorithm
  # Compares: mn - length of substring times the length of text to search
  # NOTE: in this example, we are using Ruby loops which does not
  # do a compare, but I made each trip into the loop a "compare count"
  # which is basically what we are concerned about.
  class BruteForce
    def initialize(pat)
      @pat = pat.split('')
    end

    def search(txt)
      m = @pat.length
      n = txt.length
      txt_array = txt.split('')

      # loop for each index of string to search
      (0..n-m).each do |i|
        # from current index, loop through each pattern element while we match
        (0..m-1).each do |j|
          # break out if we find a mismatch,
          # or return our i index if we found a match
          break if txt_array[i + j] != @pat[j]
          return i if (j + 1) == m
        end
      end
      # no match found, return string length
      n
    end
  end
  # Knuth-Morris-Pratt substring search algorithm
  # This basically uses a DFA simulation to return its results.
  # Compare count should be 2n on worst cas or slightly over n in general
  class KMP

    def initialize(pat)
      @pat = pat.split('')
      m = pat.length
      # initialize our DFA with 0 values our
      # our DFA is represented as a 2 dimensional array
      # we will provide an index for a possible state for each ASCII value
      @dfa = Array.new(ASCII_CHARS) { Array.new(m, 0) }
      @dfa[@pat[0].ord][0] = 1
      x = 0
      # Computes the DFA
      (1..m-1).each do |j|
        # Create mismatch cases
        (0..ASCII_CHARS - 1).each { |c| @dfa[c][j] = @dfa[c][x] }
        # create the match cases
        @dfa[@pat[j].ord][j] = j + 1
        # update restart case
        x = @dfa[@pat[j].ord][x]
      end
    end

    def search(txt)
      i = 0
      j = 0
      n = txt.length
      m = @pat.length
      txt_array = txt.split('')

      # Progress through the sates of our DFA
      while i < n && j < m
        val = @dfa[txt_array[i].ord][j]
        val.nil? ? j = 0 : j = val
        i += 1
      end

      if j == m
        # return our index if a match
        i - m
      else
        # no match found, return string length
        n
      end

    end
  end

  # Boyer-Moore Substring Search Algorithm.  This algorithm creates a
  # skip table which represents how many values we can skip each time
  # on a mismatch. Each search begins from right to left and has potential to
  # skip m values on a miss which gives a best case runtime of m/n.  Our worst
  # case runtime is nm however, as we have potential to degrade to brute for on misses
  # at the end of each substring search (miss on first character of pattern)
  class BoyerMoore

    def initialize(pat)
      @pat = pat.split('')
      m = pat.length
      r = ASCII_CHARS
      @right = Array.new(r)

      # create the skip table
      # characters not in the pattern are initialized to -1
      # rightmost character positions are computed for chars in pattern
      (0..r-1).each { |c| @right[c] = -1 }
      (0..m-1).each { |j| @right[@pat[j].ord] = j }
    end

    def search(txt)
      txt_array = txt.split('')
      n = txt.length
      m = @pat.length
      i = 0
      # search for pattern
      while i <= n - m
        skip = 0
        j = m - 1

        # check for pattern match at current index
        # and calculate or skip value if no match found
        while j >= 0

          if @pat[j] != txt_array[i + j]
            skip = j - @right[txt_array[i + j].ord]
            skip = 1 if skip < 1
            break
          end

          j -= 1
        end
        # return our index if we did not skip
        return i if skip.zero?
        i += skip
      end
      # no match found
      n
    end
  end
end



