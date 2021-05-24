# Copyright © 2019 Alexander L. Hayes
# Copyright © 2019 Ben Lauwens & Allen B. Downey

module Exercises08

    using ExportPublic

    """
        exercise_8_1(input_string::String)

    Task
    ----

    Write a function that takes a string as an argument and displays the letters backward,
    one per line.

    Usage
    -----

    ```julia
    julia> exercise_8_1("Hello")
    o
    l
    l
    e
    H
    ```
    """
    function exercise_8_1(input_string::String)
        for ind in length(input_string):-1:1
            println(input_string[ind])
        end
    end

    """
        exercise_8_2()

    In Robert McCloskey's book *Make Way for Ducklings*, the names of the ducklings are
    Jack, Kack, Lack, Mack, Nack, Ouack, Pack, and Quack.

    Task
    ----

    Using `prefixes = "JKLMNOPQ"` and `suffix = "ack"`, print the names of the ducklings.
    """
    function exercise_8_2()
        prefixes = "JKLMNOPQ"
        suffix = "ack"
        for letter in prefixes
            if letter in ['O' 'Q']
                println(letter * "u" * suffix)
            else
                println(letter * suffix)
            end
        end
    end

    """
        exercise_8_4(word::String, letter::Char, position::Int64)

    Task
    ----

    Modify `find` so that it has a third parameter, the index in `word` where it should
    start looking.

    Usage
    -----

    ```julia
    julia> exercise_8_4("Hello", 'e', 1)
    2
    julia> exercise_8_4("Hello", 'e', 3)
    -1
    ```
    """
    function exercise_8_4(word::String, letter::Char, position::Int64)
        index = position
        while index <= sizeof(word)
            if word[index] == letter
                return index
            end
            index = nextind(word, index)
        end
        -1
    end

    """
        exercise_8_5(word::String, letter::Char)

    Task
    ----

    Generalize the `counter` example to take a string and a letter as arguments, and
    counts the number of times the character appears in the string.

    Instead of directly traversing the string, use the `exercise_8_3` implementation as
    a subroutine.
    """
    function exercise_8_5(word::String, letter::Char)
        counter = 0

        next_index = exercise_8_4(word, letter, 1)

        if next_index == -1
            return 0
        end

        while next_index != 0
            next_index = exercise_8_4(word, letter, next_index) + 1
            counter += 1
        end

        return counter - 1
    end

    """
        exercise_8_6(word_one::String, word_two::String)

    Task
    ----

    Find the error in the `isreverse` function, and fix it.
    """
    function exercise_8_6(word_one::String, word_two::String)
        if length(word_one) != length(word_two)
            return false
        end

        i = firstindex(word_one)
        j = lastindex(word_two)

        while j > 0
            if word_one[i] != word_two[j]
                return false
            end
            i = nextind(word_one, i)
            j = prevind(word_two, j)
        end
        return true
    end

    """
        exercise_8_9(word::String)

    Task
    ----

    Write a one-line version of `ispalindrome` from Exercise 6-6.
    """
    function exercise_8_9(word::String)
        word == word[end:-1:1]
    end

    """
        exercise_8_11(word::String, rotation::Int64)

    Overview
    --------

    A Caesar cypher is a weak form of encryption that involves "rotating" the each letter
    by a fixed number of places.

    Task
    ----

    Write a function called `rotateword` that takes a string and integer as parameters, and
    returns a new string that contains the letters from the original word rotated by the
    given amount.
    """
    function exercise_8_11(word::String, rotation::Int64)

        output = ""

        for letter in word
            if islowercase(letter)
                output *= Char(((26 + (Int(letter) - 97 + rotation)) % 26) + 97)
            elseif isuppercase(letter)
                output *= Char(((26 + (Int(letter) - 65 + rotation)) % 26) + 65)
            else
                output *= letter
            end
        end

        return output
    end

    @exportPublic
end
