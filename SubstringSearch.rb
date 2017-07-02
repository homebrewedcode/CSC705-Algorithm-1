module SubstringSearch
  ASCII_CHARS = 256 # constant for arrays of ASCII characters

  #naive brute force method for substring search algorithm
  #Compares: mn - length of substring times the length of text to search
  #NOTE: in this example, we are using Ruby loops which does not
  #do a compare, but I made each trip into the loop a "compare count"
  #which is basically what we are concerned about.
  class BruteForce
    def initialize(pat)
      @pat = pat.split('')
    end

    def search(txt)
      m = @pat.length
      n = txt.length
      txt_array = txt.split('')

      diff = (n - m) + 1

      diff.tim do |i|
        m.times do |j|
          if txt_array[i + j] != @pat[j]
            break
          end
          if (j + 1) == m
            return i
          end
        end
      end
      n
    end
  end
  #Knuth-Morris-Pratt substring search algorithm
  #This basically uses a DFA simulation to return its results.
  #Compare count should be 2n
  class KMP

    def initialize(pat)
      @pat = pat.split('')
      m = pat.length
      @dfa = Array.new(ASCII_CHARS) { Array.new(m) }
      @dfa[@pat[0].ord][0] = 1

      j = 1
      x = 0
      while j < m
        c = 0
        while c < ASCII_CHARS
          @dfa[c][j] = @dfa[c][x]
          c += 1
        end

        @dfa[@pat[j].ord][j] = j + 1
        x = @dfa[@pat[j].ord][x]

        j += 1
      end
    end

    def search(txt)
      i = 0
      j = 0
      n = txt.length
      m = @pat.length
      txt_array = txt.split('')

      while i < n && j < m
        # check for nil
        val = @dfa[txt_array[i].ord][j]
        val.nil? ? j = 0 : j = val
        i += 1
      end
      if j == m
        i - m
      else
        n
      end
    end
  end

  class BoyerMoore
    def initialize(pat)
      @pat = pat.split('')
      m = pat.length
      r = ASCII_CHARS
      @right = Array.new(r)

      (0..r-1).each {|c| @right[c] = -1 }
      (0..m-1).each {|j| @right[@pat[j].ord] = j}
    end
    def search(txt)
      txt_array = txt.split('')
      n = txt.length
      m = @pat.length
      i = 0
      while i <= n - m
        skip = 0
        j = m - 1

        while j >= 0
          if @pat[j] != txt_array[i + j]
            skip = j - @right[txt_array[i + j].ord]
            if skip < 1
              skip = 1
              break
            end
          end
          j -= 1
        end
        return i if skip.zero?
        i += skip
      end
      n
    end
  end
end



