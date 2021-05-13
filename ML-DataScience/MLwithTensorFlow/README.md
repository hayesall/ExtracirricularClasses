# ML with TensorFlow

Saturday, September 23, 2017

Python notebooks are from [sruti-jain/MachineLearningWithTensorflow](https://github.com/sruti-jain/MachineLearningWithTensorflow).

## Installation Instructions for getting up and running:

1. Install Anaconda 3:

   ```bash
   $ curl -O https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh
   $ bash Anaconda3-4.2.0-Linux-x86_64.sh
   ```

2. Create a tensorflow instance and install tensorflow:

   ```bash
   # Create an Anaconda environment
   $ conda create -n tensorflow
   
   # Switch to the newly created environment.
   $ source activate tensorflow
   
   # Install tensorflow (https://www.tensorflow.org/install/install_linux#InstallingAnaconda)
   $ pip install pip install --ignore-installed --upgrade \
   > https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.3.0-cp35-cp35m-linux_x86_64.whl
   ```

3. Check that it installed properly:

   `$ python`

   ```python
   >>> import tensorflow as tf
   >>> hello = tf.constant('Hello tensorflow!')
   >>> sess = tf.Session()
   >>> print(sess.run(hello))
   ```
