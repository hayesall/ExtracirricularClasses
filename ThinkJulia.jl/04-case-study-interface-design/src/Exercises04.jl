# Copyright © 2019 Alexander L. Hayes
# Copyright © 2019 Ben Lauwens & Allen B. Downey


module Exercises04

    using ThinkJulia

    export exercise_4_1
    export exercise_4_2
    export exercise_4_3
    export exercise_4_4
    export exercise_4_5
    export exercise_4_6
    export exercise_4_7
    export polyline
    export arc

    """
        exercise_4_1()

    Modify the macro to draw a square.
    """
    function exercise_4_1()
        🐢 = Turtle()

        @svg begin
            for i in 1:4
                forward(🐢, 100)
                turn(🐢, -90)
            end
        end
    end

    """
        exercise_4_2(t)

    (**Exercise 4-2**) Write a function called `square` that takes a parameter
    named `t`, which is a turtle. It should use the turtle to draw a square.
    """
    function exercise_4_2(t)
        for i in 1:4
            forward(t, 100)
            turn(t, -90)
        end
    end

    """
        exercise_4_3(t)

    (**Exercise 4-3**) Write a function that passes `t` as an argument
    to `square`, and then run the macro again.
    """
    function exercise_4_3(t)
        exercise_4_2(t)
    end

    """
        exercise_4_4(t, len)

    (**Exercise 4-4**) Add another parameter, named `len`, to square. Modify
    the body so length of the sides is `len`, and then modify the function
    call to provide a second argument. Run the macro again. Test with a
    range of values for `len`.
    """
    function exercise_4_4(t, len)
        for i in 1:4
            forward(t, len)
            turn(t, -90)
        end
    end

    """
        exercise_4_5(t, n, len)

    (**Exercise 4-5**) Make a copy of `square` and change the name to
    `polygon`. Add another parameter named `n` and modify the body so it
    draws an ``n``-sided polygon.

    *Hint*: The exterior angles of an ``n``-sided polygon are
    \$\\frac{360}{n}\$ degrees.
    """
    function exercise_4_5(t, n, len)
        angle = 360 / n
        for i in 1:n
            forward(t, len)
            turn(t, -angle)
        end
    end

    """
        exercise_4_6(t, r)

    (**Exercise 4-6**) Write a function called `circle` that takes a turtle,
    `t`, and radius `r`, as parameters and that draws an approximate circle
    by calling polygon with an appropriate length and number of sides.
    Test your function with a range of values of `r`.

    *Hint*: Figure out the circumference of the circle and make sure that
    `len * n == circumference`.
    """
    function exercise_4_6(t, r)
        circumference = 2 * π * r
        len = circumference / 360
        exercise_4_5(t, 360, len)
    end

    """
        exercise_4_7(t, r, angle)

    (**Exercise 4-7**) Make a more general version of `circle` called `arc`
    that takes an additional parameter `angle`, which determines what fraction
    of a circle to draw. `angle` is in units of degrees, so when
    `angle = 360`, arc should draw a complete circle.
    """
    function exercise_4_7(t, r, angle)
        @assert 0 <= angle <= 360

        for i in 1:angle
            forward(t, 2 * π * r / 360)
            turn(t, -1)
        end
    end

    """
    polyline(t, n, len, angle)

    Draws n line segments with the given length and
    angle (in degrees) between them. t is a turtle.

        t: turtle
        n: number of line segments
        len: length of each line
        angle: degrees
    """
    function polyline(t, n, len, angle)
        for i in 1:n
            forward(t, len)
            turn(t, -angle)
        end
    end

    """
    arc(t, r, angle)

    Draws an arc with the given radius and angle:

        t: turtle
        r: radius
        angle: angle subtended by the arc, in degrees
    """
    function arc(t, r, angle)
        arc_len = 2 * π * r * abs(angle) / 360
        n = trunc(arc_len / 4) + 3
        step_len = arc_len / n
        step_angle = angle / n

        # making a slight left turn before starting reduces
        # the error caused by the linear approximation of the arc
        turn(t, -step_angle/2)
        polyline(t, n, step_len, step_angle)
        turn(t, step_angle/2)
    end
end
