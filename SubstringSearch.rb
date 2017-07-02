module SubstringSearch
  ASCII_CHARS = 256 # constant for arrays of ASCII characters

  #naive brute force method for substring search algorithm
  #Compares: mn - length of substring times the length of text to search
  #NOTE: in this example, we are using Ruby loops which does not
  #do a compare, but I made each trip into the loop a "compare count"
  #which is basically what we are concerned about.
  def SubstringSearch.brute_force(pat, txt)
    m = pat.length
    n = txt.length
    pat_array = pat.split('')
    txt_array = txt.split('')
    passes = 0

    diff = (n - m) + 1

    diff.times do |i|
      passes += 1
      m.times do |j|
        passes += 1
        if txt_array[i + j] != pat_array[j]
          passes += 1
          break
        end
        if (j + 1) == m
          passes += 1
          puts "Op Count: #{passes}"
          return i
        end
      end
    end
    puts "Op Count: #{passes}"
    n
  end

  #Knuth-Morris-Pratt substring search algorightm
  #This basically uses a DFA simulation to return its results.
  #Compare count should be 2n
  class KMP

    def initialize(pat)
      @count = 0
      @pat = pat.split('')
      m = pat.length
      @dfa = Array.new(ASCII_CHARS) { Array.new(m) }
      @dfa[@pat[0].ord][0] = 1

      j = 1
      x = 0
      while j < m
        c = 0
        while c < ASCII_CHARS
          @count += 1
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
        @count += 1
        val = @dfa[txt_array[i].ord][j]
        val.nil? ? j = 0 : j = val
        i += 1
      end
      if j == m
        puts "OpCount: #{@count}"
        i - m
      else
        n
      end
    end
  end

  class BoyerMoore

  end

end



