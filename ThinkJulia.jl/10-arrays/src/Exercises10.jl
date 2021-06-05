# Copyright © 2019 Alexander L. Hayes
# Copyright © 2019 Ben Lauwens & Allen B. Downey


module Exercises10

    using ExportPublic
    using Random

    """
        exercise10_1(ls)

    Task
    ----

    Write a function called `nestedsum` that takes an array of integers and adds
    up the elements from all of the nested arrays.
    """
    function exercise10_1(ls)

        # The boring way:
        # import Base.iterators.flatten
        # sum(collect(flatten(ls)))

        acc = 0

        for i in ls
            if isa(i, Array)
                acc += exercise10_1(i)
            else
                acc += i
            end
        end

        return acc
    end

    """
        exercise10_2(ls)

    Task
    ----

    Write a function called `cumulsum` that takes an array of numbers and
    returns the cumulative sum; that is, a new array where the ``i``th element
    is the sum of the first ``i`` elements from the original array.
    """
    function exercise10_2(ls)
        output = []

        acc = 0
        for i in ls
            acc += i
            push!(output, acc)
        end
        return output
    end

    """
        exercise10_3(ls)

    Task
    ----

    Write a function called `interior` that takes an array and returns a new
    array that contains all but the first and last elements.

    Assumptions
    -----------

    The given example was `interior([1, 2, 3, 4]) == [2, 3]`. I'll assume that
    for arrays with less than 3 elements, `interior` will always return an empty
    array.
    """
    function exercise10_3(ls)
        if length(ls) < 3
            return []
        end

        return ls[2:length(ls) - 1]
    end

    """
        exercise10_4(ls)

    Task
    ----

    Write a function called `interior!` that takes an array, modifies it by
    removing the first and last elements, and returns nothing.

    Examples
    --------

    ```julia
    julia> t = [1, 2, 3, 4];

    julia> exercise10_4!(t)

    julia> print(t)
    [2, 3]
    ```
    """
    function exercise10_4!(ls)
        deleteat!(ls, length(ls))
        deleteat!(ls, 1)
        return nothing
    end

    """
        exercise10_5(ls)

    Task
    ----

    Write a function called `issort` that takes an array as a parameter and
    returns `true` if the array is sorted in ascending order and `false`
    otherwise.

    Examples
    --------

    ```julia
    julia> issort([1, 2, 2])
    true

    julia> issort(['b', 'a'])
    false
    ```
    """
    function exercise10_5(ls)
        for (i, j) in zip(ls[1:end], ls[2:end])
            if j < i
                return false
            end
        end
        return true
    end

    """
        exercise10_6(word1::String, word2::String)

    Task
    ----

    Two words are anagrams if you can rearrange the letters from one to spell
    the other. Write a function called `isanagram` that takes two strings and
    returns `true` if they are anagrams.
    """
    function exercise10_6(word1::String, word2::String)
        sort(collect(word1)) == sort(collect(word2))
    end

    """
        exercise10_7(ls)

    Task
    ----

    Write a function called `hasduplicates` that takes an array and returns
    `true` if there is any element that appears more than once. It should not
     modify the original array.
    """
    function exercise10_7(ls)
        sorted = sort(ls)

        for (i, j) in zip(sorted[1:end], sorted[2:end])
            if i == j
                return true
            end
        end

        return false
    end

    """
        exercise10_8()

    Task
    ----

    This exercise pertains to the so-called Birthday Paradox. If there are 23
    students in your class, what are the chances that two of you have the same
    birthday? You can estimate this probability by generating random samples of
    23 birthdays and checking for matches.

    Notes
    -----

    This draws samples of 23 students with `rand(1:365, 23)` 100,000 times and
    checks whether there are duplicates.
    """
    function exercise10_8()

        n_times = 0
        total_times = 100000

        for _ in 1:total_times
            if exercise10_7(rand(1:365, 23))
                n_times += 1
            end
        end

        return n_times / total_times
    end

    function _part1_push(word_file)

        output = []

        for word in eachline(word_file)
            push!(output, word)
        end

        return output
    end

    function _part2_idiom(word_file)

        output = []

        for word in eachline(word_file)
            output = [output..., word]
        end
    end

    """
        exercise10_9(word_file::String)

    Task
    ----

    Write a function that reads the file `words.txt` and builds an array with
    one element per word. Write two versions of this function, one using
    `push!` and the other using the idiom `t = [t..., x]`. Which one takes
    longer to run? Why?

    Notes
    -----

    I ran this on a small set of 5000 words:
    `head -n 5000 words.txt > words-small.txt`.

    The result of running was:

    ```console
    julia> exercise10_9("words-small.txt")
        0.000872 seconds (5.03 k allocations: 286.391 KiB)
        0.245276 seconds (22.46 k allocations: 191.074 MiB, 6.84% gc time)
    ```

    It looks like the `t = [t..., x]` idiom is re-allocating the contents
    and copying the contents every time an element is appended, whereas the
    `push!` implementation only requires an allocation for each string.

    This might be an instance of "*Schlemiel the Painter's Algorithm*"
    - [Joel Spolsky (Wikipedia)](https://en.wikipedia.org/wiki/Joel_Spolsky)
    - [Schlemiel the Painter's Algorithm (WikiChip)](https://en.wikichip.org/wiki/schlemiel_the_painter%27s_algorithm)
    """
    function exercise10_9(word_file::String)

        _part1_push(word_file)
        _part2_idiom(word_file)

        @time _part1_push(word_file)
        @time _part2_idiom(word_file)
    end

    function _binary_search(word::String, A)
        # Search for a `word` in `word_file`

        l = 1
        r = length(A)

        while l ≤ r

            m = (l + r) ÷ 2

            if A[m] < word
                l = m + 1
            elseif A[m] > word
                r = m - 1
            else
                return true
            end
        end

        return false
    end

    """
        exercise10_10(word::String, word_file::String)

    Task
    ----

    To check whether a word is in the word array, you could use the `∈`
    operator, but it would be slow because it searches through the words in
    order.

    Because the words are in alphabetical order, we can speed things up with a
    bisection search (a.k.a. binary search) .... Write a function called
    `inbisect` that takes a sorted array and a target value and returns `true`
    if the word is in the array and `false` if it is not.

    Notes
    -----

    I implemented a separate `_binary_search` method; `exercise10_10` calls
    `@time` on `word ∈ words` and `_binary_search(word, words)`.

    The results fall in line with expectations: `word ∈ file` has better
    "best case" complexity:

    ```console
    julia> exercise10_10("aa", "words.txt")  # "aa" is the first element
      0.000001 seconds
      0.000003 seconds
    ```

    But `word ∈ file` suffers in the case where the element is not in the list

    ```console
    julia> exercise10_10("gcda", "words.txt")
      0.000549 seconds
      0.000003 seconds
    julia> exercise10_10("fjasdlkf", "words.txt")
      0.000850 seconds
      0.000002 seconds
    ```

    Surprisingly, it appears to take ≈ 300 comparisons before they take a
    similar amount of time. This has me curious if `∈` has some hidden
    optimization that lets it compare things faster, if the overhead of
    my binary search implementation's comparison operators between strings
    (`A[m] < word`) has some hidden inefficiency, or if what I usually assume
    to be "*constant time operations*" explain the overhead.

    ```console
    julia> exercise10_10("abraded", "words.txt")
      0.000004 seconds
      0.000004 seconds
    ```

    **Update**: Silly me. I was including compilation time. Calling
    `_binary_search` prior to evaluating `@time` seems to make this more
    consistent:

    ```console
    julia> exercise10_10("aa", "words.txt")
      0.000001 seconds
      0.000002 seconds

    julia> exercise10_10("abraded", "words.txt")
      0.000003 seconds
      0.000001 seconds

    julia> exercise10_10("fjasdlkf", "words.txt")
      0.000875 seconds
      0.000002 seconds
    ```
    """
    function exercise10_10(word::String, word_file::String)

        words = readlines(word_file)

        _ = _binary_search(word, words)

        @time word ∈ words
        @time _binary_search(word, words)
    end

    @exportPublic
end
