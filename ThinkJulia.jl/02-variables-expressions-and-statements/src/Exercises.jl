# Copyright © 2019 Alexander L. Hayes

module Exercises
export exercise_2_1
export exercise_2_3_1
export exercise_2_3_2
export exercise_2_3_3

    """
        exercise_2_1()

    First exercise
    """
    function exercise_2_1()
        x = 5
        println(x)
        x + 1
        println(x)
    end

    """
        exercise_2_3_1(radius)

    Calculate the volume of a sphere with a given radius.
    """
    function exercise_2_3_1(radius)
        return 4/3 * π * radius ^ 3
    end

    """
        exercise_2_3_2(n)

    Calculate the wholesale cost of ``n`` books. Round your answer to two
    decimal places.
    """
    function exercise_2_3_2(n)
        @assert n > 0
        discounted_cost = 14.97 * n
        shipping_cost = 3 + (0.75 * (n - 1))
        wholesale = (24.95 * n) - discounted_cost - shipping_cost
        return round(wholesale, digits=2)
    end

    """
        exercise_2_3_3()

    When do I get home for breakfast? Return your answer as a string with the
    form: `HH:MM`.
    """
    function exercise_2_3_3()
        hours = 6
        minutes = 52
        seconds = 0

        # easy pace
        minutes += 8
        seconds += 15

        # fast pace
        minutes += 7 * 3
        seconds += 12 * 3

        # easy pace
        minutes += 8
        seconds += 15

        # Total them up
        minutes += trunc(Int, seconds/60)
        hours += trunc(Int, minutes/60)
        minutes = minutes % 60
        return string(hours) * ":" * string(minutes)
    end
end
