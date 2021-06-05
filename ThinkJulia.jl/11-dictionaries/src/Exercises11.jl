# Copyright © 2019 Alexander L. Hayes
# Copyright © 2019 Ben Lauwens & Allen B. Downey


module Exercises11

    using ExportPublic

    """
        exercise11_1(s::String)

    Task
    ----

    Use `get` to write `histogram` more concisely. You should be able to
    eliminate the `if` statement.
    """
    function exercise11_1(s::String)
        d = Dict()
        for c in s
            get!(d, c, 0)
            d[c] += 1
        end
        d
    end

    """
        exercise11_2(word::String, word_file::String)

    Task
    ----

    Write a function that reads the words in `words.txt` and stores them in a
    dictionary. It doesn't matter what the values are. Then use the `∈` operator
    as a fast way to check whether a string is in the dictionary.

    Notes
    -----

    The hint was to use the `∈` to check. It looks like there are a couple ways
    of writing the idea: `key ∈ keys(mydict)` or `haskey(mydict, key)`.
    I'm surprised the default behavior requires `key ∈ keys(mydict)`: checking
    whether a value is in the dictionary with `values(mydict)` could be useful
    in some situations, but it appears to be implemented using a slow
    linear scan over all the values.

    ```console
    @time 0 ∈ values(mydict)
        0.005341 seconds
    @time word ∈ keys(mydict)
        0.000001 seconds
    @time haskey(mydict, word)
        0.000000 seconds
    ```

    The *binary search* vs. *dictionary* battle appears to be within an
    epsilon of each other.

    ```console
    julia> exercise10_10("abraded", "words.txt")
      0.000003 seconds
      0.000001 seconds

    julia> exercise11_2("abraded", "words.txt")
      0.006220 seconds
      0.000002 seconds
      0.000000 seconds
    ```

    The fact that the second call `@time haskey(mydict, word)` appears to
    complete in `0.000000 seconds` is kind of funny. When I switch the order
    of `word ∈ keys(_mydict)` and `haskey(_mydict, word)`, the last line
    always takes `0.000000 seconds`. This is probably a fun side effect of
    the JIT compilation. I fiddled around with `InteractiveUtils` and
    `@code_native` for portions of the function. My hunch is that the one of
    the `movq` instructions is caching the return value of the first call
    (since the same thing is effectively being called twice) and returning
    the value immediately.

    ```llvm
    ; │ @ Exercises11.jl:79 within `exercise11_2'
    ; │┌ @ dict.jl:551 within `in'
            movabsq \$ht_keyindex, %r14
            movq    %r15, %rdi
            movq    64(%rsp), %rbx
            movq    %rbx, %rsi
            callq   *%r14
    ; │└
    ; │ @ Exercises11.jl:80 within `exercise11_2'
    ; │┌ @ dict.jl:550 within `haskey'
            movq    %r15, %rdi
            movq    %rbx, %rsi
            callq   *%r14
    ; │└
            testq   %rax, %rax
            setns   %al
            movq    8(%rsp), %rcx
            movq    %rcx, -32768(%r13)
            leaq    -40(%rbp), %rsp
            popq    %rbx
            popq    %r12
            popq    %r13
            popq    %r14
            popq    %r15
            popq    %rbp
            retq
    ```
    """
    function exercise11_2(word::String, word_file::String)

        words = readlines(word_file)
        _mydict = Dict()

        for (i, aword) in enumerate(words)
            _mydict[aword] = i
        end

        @time 0 ∈ values(_mydict)
        @time word ∈ keys(_mydict)
        @time haskey(_mydict, word)
    end

    """
        exercise11_3(d)

    Task
    ----

    Read the documentation of the dictionary function `get!` and use it to
    write a more concise version of `invertdict`.
    """
    function exercise11_3(d)
        inverse = Dict()
        for key in keys(d)
            get!(inverse, d[key], [])
            push!(inverse[d[key]], key)
        end
        inverse
    end

    """
        standard_ackermann(m::Int64, n::Int64)

    A "standard" (non-memoized) version of the Ackermann function from
    Chapter 6.
    """
    function standard_ackermann(m::Int64, n::Int64)
        if m == 0
            n + 1
        elseif m > 0 && n == 0
            standard_ackermann(m - 1, 1)
        else
            standard_ackermann(m - 1, standard_ackermann(m, n - 1))
        end
    end

    _ack_memo = Dict()

    """
        exercise11_4(m::Int64, n::Int64)

    A memoized version of the Ackermann function.

    Task
    ----

    Memoize the Ackermann function from Exercise 6-5 and see if memoization
    makes it possible to evaluate the function with bigger arguments.

    Notes
    -----

    I still don't think I have the hang of what triggers compilation. I
    thought running the functions once before timing would take care of it,
    but timing `exercise11_4(4, 1)` suggested that 12.33% of the time was
    compilation time.

    Whether memoization "*improves performance*" appears to be a "Yes" for this
    problem; the memoized version of the problem is ≈ 100x faster than the
    non-memoized version for inputs like `(4, 1)`.

    ```console
    julia> exercise11_4(0, 1)
    2

    julia> standard_ackermann(0, 1)
    2

    julia> @time exercise11_4(4, 1)
      0.151623 seconds (1.63 M allocations: 46.409 MiB, 7.05% gc time, 12.33% compilation time)
    65533

    julia> @time standard_ackermann(4, 1)
     13.832987 seconds
    65533
    ```

    Whether memoization "*makes it possible to evaluate the function with
    bigger arguments*" is a little less clear. It's relatively quick to
    evaluate inputs like `(5, 0)`, but evaluating `(5, 1)`, `(3, 15)`, or
    `(2, 1000000)` lead to a series of `StackOverflowError`; so while it can
    get answers more quickly, this doesn't universally translate into allowing
    the function to be evaluated on bigger ``m`` and ``n``.
    """
    function exercise11_4(m::Int64, n::Int64)

        if (m, n) ∈ keys(_ack_memo)
            return _ack_memo[(m, n)]
        end

        if m == 0
            res = n + 1
            _ack_memo[(0, n)] = res
            return res
        elseif m > 0 && n == 0
            res = exercise11_4(m - 1, 1)
            _ack_memo[(m, n)] = res
            return res
        else
            res = exercise11_4(m - 1, exercise11_4(m, n - 1))
            _ack_memo[(m, n)] = res
            return res
        end
    end

    @exportPublic
end
