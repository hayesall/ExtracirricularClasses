# Copyright © 2019 Alexander L. Hayes
# Copyright © 2019 Ben Lauwens & Allen B. Downey

module Exercises09

    using ExportPublic

    """
        exercise_9_1()

    Task
    ----

    Write a program that reads `words.txt` and prints only the words with more than
    20 characters (not counting whitespace).
    """
    function exercise_9_1()
        result = []
        for line in eachline("words.txt")
            if length(line) > 20
                push!(result, line)
            end
        end
        return result
    end

    """
        exercise_9_2()

    Task
    ----

    Write a function called `hasno_e` that returns `true` if the given word doesn't have
    the letter `e` in it.

    Modify your program from the previous exercise to compute the percentage of words
    that have no `e`.
    """
    function exercise_9_2()
        _hasno_e(word::String) = !('e' in word)

        _n_words = 0
        _e_words = 0

        for line in eachline("words.txt")
            if _hasno_e(line)
                _e_words += 1
            end
            _n_words += 1
        end

        return _e_words / _n_words
    end

    """
        exercise_9_3(constraint::String)

    Task
    ----

    Write a function `avoids` that takes a word and a string of forbidden letters, and
    that returns `true` if the word doesn't use any of the forbidden letters.

    Modify your program to take a string of forbidden letters and then print the number of
    words that don't contain any of them. Can you find a combination of 5 forbidden letters
    that excludes the smallest number of words?

    Discussion
    ----------

    The best case I found with some guesswork was `zxquv`. Assuming `x` and `z` would be
    some of the least common letters, that `q` and `u` would have a significant overlap,
    and assuming that `v` was a fairly uncommon letter.

    ```julia
    julia> exercise_9_3("zxquv")
    0.6416627858956673

    julia> exercise_9_3("estan")
    0.019769965468460316
    ```

    `v` was the one I was least certain about. But it's easy to check:

    ```julia
    julia> for letter in "abcdefghijklmnoprstvwy"
             println(letter, "  ", exercise_9_3("zxqu" * letter))
           end
    a  0.3253696983542602
    b  0.6069642998356897
    c  0.5137730759430273
    d  0.5099157360138478
    e  0.22200353223383038
    f  0.6346598247941727
    g  0.5457916333506138
    h  0.5756311012310098
    i  0.31503659640274495
    j  0.693170135929496        <--- j = 0.69
    k  0.6397297226054178
    l  0.4571431081900377
    m  0.562468697554675
    n  0.39985414158809934
    o  0.42024795930023107
    p  0.5552460701701974
    r  0.3590225729072393
    s  0.3024189651082076
    t  0.41441362282420546
    v  0.6416627858956673       <--- v = 0.641
    w  0.6387280443550158
    y  0.6149601525362669
    ```
    """
    function exercise_9_3(constraint::String)
        _hasno(letters::String, word::String) = all([letter ∉ word for letter in letters])

        _n_words = 0
        _e_words = 0

        for line in eachline("words.txt")
            if _hasno(constraint, line)
                _e_words += 1
            end
            _n_words += 1
        end

        return _e_words / _n_words
    end

    @exportPublic
end
