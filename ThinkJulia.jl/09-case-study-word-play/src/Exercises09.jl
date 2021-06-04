# Copyright © 2019 Alexander L. Hayes
# Copyright © 2019 Ben Lauwens & Allen B. Downey

module Exercises09

    using ExportPublic

    """
        exercise_9_1(file_location::String)

    Task
    ----

    Write a program that reads `words.txt` and prints only the words with more than
    20 characters (not counting whitespace).
    """
    function exercise_9_1(file_location::String)
        result = []
        for line in eachline(file_location)
            if length(line) > 20
                push!(result, line)
            end
        end
        return result
    end

    """
        exercise_9_2(file_location::String)

    Task
    ----

    Write a function called `hasno_e` that returns `true` if the given word doesn't have
    the letter `e` in it.

    Modify your program from the previous exercise to compute the percentage of words
    that have no `e`.
    """
    function exercise_9_2(file_location::String)
        _hasno_e(word::String) = !('e' in word)

        _n_words = 0
        _e_words = 0

        for line in eachline(file_location)
            if _hasno_e(line)
                _e_words += 1
            end
            _n_words += 1
        end

        return _e_words / _n_words
    end

    # _help_check
    # Checks what percent of lines in `file_location` return `true` for a
    # `boolean_function` with a `constraint`.
    function _help_check(file_location, boolean_function, constraint)

        total_words = 0
        satisfied = 0

        for line in eachline(file_location)
            if boolean_function(constraint, line)
                satisfied += 1
            end
            total_words += 1
        end

        return satisfied / total_words
    end

    """
        exercise_9_3(file_location::String, constraint::String)

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
    julia> exercise_9_3("words.txt", "zxquv")
    0.6416627858956673

    julia> exercise_9_3("words.txt", "estan")
    0.019769965468460316
    ```

    `v` was the one I was least certain about. But it's easy to check:

    ```julia
    julia> for letter in "abcdefghijklmnoprstvwy"
             println(letter, "  ", exercise_9_3("words.txt", "zxqu" * letter))
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

    I tried using the `JuliaMath/Combinatorics.jl` package to enumerate likely
    possibilities, but this crashed my Ubuntu machine the first time I tried it.
    """
    function exercise_9_3(file_location::String, constraint::String)
        _hasno(letters::String, word::String) = all([letter ∉ word for letter in letters])
        _help_check(file_location, _hasno, constraint)
    end

    """
        exercise_9_4(file_location::String, constraint::String)

    Write a function named `usesonly` that takes a word and a string of letters,
    and that returns true if the word contains only letters in the list.
    """
    function exercise_9_4(file_location::String, constraint::String)
        _usesonly(letters::String, word::String) = all([letter ∈ letters for letter in word])
        _help_check(file_location, _usesonly, constraint)
    end

    """
        exercise_9_5(file_location::String, constraint::String)

    Write a function named `usesall` that takes a word and a string of required
    letters, and that returns true if the word uses all the required letters at
    least once.
    """
    function exercise_9_5(file_location::String, constraint::String)
        _usesall(letters::String, word::String) = all([letter ∈ word for letter in letters])
        _help_check(file_location, _usesall, constraint)
    end

    """
        exercise_9_6(file_location::String)

    Write a function called `isabecedarian` that returns `true` if the letters
    in a word appear in alphabetical order (double letters are ok). How many
    abecedarian words are there?
    """
    function exercise_9_6(file_location::String)
        # TODO(hayesall): My `_isabecedarian` interface looks silly to work with `_help_check`
        _isabecedarian(unused, word::String) = all([i ≤ j for (i, j) in zip(word[1:end], word[2:end])])
        _help_check(file_location, _isabecedarian, "")
    end

    function is_triple_double(word::String)
        # TODO(hayesall): Over-complicated, but lots of corner-cases.

        myarray = []
        for (i, (j, k)) in enumerate(zip(word[1:end], word[2:end]))
            if j == k
                push!(myarray, i)
            end
        end

        newarray = [j - i for (i, j) in zip(myarray[1:end], myarray[2:end])]
        finalarray = [(i == j) & (i == 2) for (i, j) in zip(newarray[1:end], newarray[2:end])]
        return any(finalarray)

    end

    """
        exercise_9_7(file_location::String)

    > Give me a word with three consecutive double letters. I'll give you a
    > couple of words that almost qualify, but don't. For example, the word
    > committee, c-o-m-m-i-t-t-e-e. It would be great except for the i that
    > sneaks in there. Or Mississippi: M-i-s-s-i-s-s-i-p-p-i. If you could
    > take out those i's it would work. But there is a word that has three
    > consecutive pairs of letters and to the best of my knowledge this may be
    > the only word. Of course there are probably 500 more but I can only think
    > of one. What is the word?
    """
    function exercise_9_7(file_location::String)
        valid_words = String[]
        for word in eachline(file_location)
            if is_triple_double(word)
                push!(valid_words, word)
            end
        end
        return valid_words
    end

    @exportPublic
end
