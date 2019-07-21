# Copyright © 2019 Alexander L. Hayes

module Exercises
export justifyright;
export dotwice;
export dofour;
export returngrid;

    """
        justifyright(s)

    Return a string with enough leading spaces so that the last letter of the
    string is in column 70 of the display.
    """
    function justifyright(s)
        _spaces_to_print = 70 - length(s)
        _output_string = " " ^ _spaces_to_print
        _output_string = _output_string * s
        return _output_string
    end

    function printtwice(value)
        println(value)
        println(value)
    end

    """
        dotwice(f, value)

    Call the function `f` with parameter `value` twice.
    """
    function dotwice(f, value)
        f(value)
        f(value)
    end

    """
        dofour(f, value)

    Call the function `f` with parameter `value` four times.
    """
    function dofour(f, value)
        dotwice(f, value)
        dotwice(f, value)
    end

    """
        returngrid(number_rows, number_cols)

    Return a string representing a grid.
    """
    function returngrid(number_rows, number_cols)

            function get_col_layout(number_cols)
                _output_string = ("+ - - - - " ^ number_cols) * "+\n"
                _output_string *= (("|         " ^ number_cols) * "|\n") ^ 4
                return _output_string
            end

            function build_grid(number_rows, number_cols)
                _output_string = get_col_layout(number_cols) ^ number_rows
                _output_string *= ("+ - - - - " ^ number_cols) * "+\n"
                return _output_string
            end

        return build_grid(number_rows, number_cols)
    end
end
