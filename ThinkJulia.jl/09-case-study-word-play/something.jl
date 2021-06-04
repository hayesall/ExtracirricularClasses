
using Test


function doubles_string(word::String)

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
@test doubles_string("abbccdde")
@test doubles_string("abccddeef")
@test doubles_string("aabbccdd")
@test doubles_string("aabbccefghh")
@test doubles_string("aabccddeefghiij")
@test !doubles_string("")
@test !doubles_string("ab")
@test !doubles_string("abc")
@test !doubles_string("acccdd")

@test !doubles_string("greenness")
@test !doubles_string("heelless")
"""

doubles_string("heelless")

# If length of myarray ≥ 3 and each element is 2 apart.
