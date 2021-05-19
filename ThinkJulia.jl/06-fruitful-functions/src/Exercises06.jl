# Copyright © 2019 Alexander L. Hayes
# Copyright © 2019 Ben Lauwens & Allen B. Downey

module Exercises06

    export distance

    """
    2-D Euclidean Distance

    Parameters
    ----------
    - x₁ (Int):
    - y₁ (Int):
    - x₂ (Int):
    - y₂ (Int):

    Computes the Euclidean Distance in two dimensions:

    ```math
    d = \\sqrt{(x_{2} - x_{1})^{2} + (y_{2} - y_{1})^{2}}
    ```
    """
    function distance(x₁, y₁, x₂, y₂)
        dx = x₂ - x₁
        dy = y₂ - y₁
        d² = dx^2 + dy^2
        @show d²
    end

end
