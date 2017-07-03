# CSC 705 Algorithms Assignment 1

This is code I am using for my first assignment in my CSC
705 Analysis of Algorithms class.  In this project
I am working on substring search algorithms.

The following algorithms have been implemented:

**Brute Force (Naive approach):**
This algorithm uses a pointer to check each index of the search string
and a second pointer to check the current index against the 
pattern. Worst case runtime is ~mn (pattern length times input length)  

**Knuth-Morris-Pratt (KMP):**
Essentially builds a Deterministic Finite Automaton to step through for a match.
This algorithm prevents pointer backup and makes less comparisons in general.
The runtime of this implementation of KMP is no more than m + n.  If m = n, our
worst case will be 2n, gauranteeing linear time independent of pattern length. 

**Boyer-Moore:**
This algorithm checks for matches starting with the rightmost character and works backwards.
When we don't have a match, we can generally skip the m spaces to begin our check again.
This gives us a best case run time n/m.  However, in situations where we cannot skip, we
may only skip to next index, degrading to nm.  
