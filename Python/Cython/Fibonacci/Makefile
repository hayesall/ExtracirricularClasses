.PHONY : help clean install demo

help:
				@echo "Specify a command: help clean install"

clean:
				rm -rf build
				rm -rf fib_demo.egg-info
				rm -f *.c
				rm -f *.so
				rm -f Fibo/*.c
				rm -f Fibo/*.so
				rm -rf Fibo/__pycache__

install:
				pip install -e .

demo: install
				@echo "Starting demo:"
				python -m timeit -s "from Fibo import cyFibo" "cyFibo.three_var_fib(30)"
