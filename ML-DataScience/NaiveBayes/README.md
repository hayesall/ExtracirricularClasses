# Naïve Bayes

*Trying to write a clean, concise, and minimal Multinomial Naive Bayes implementation.*

---

Brian Kernighan had a quote about "learning new languages" that I kept
thinking about. I've transcribed a portion of it:

> "... I would love to be able to try more ... languages; the closest I've
> come is in a class [that I teach where I have one small example that] I will
> write in as many languages as I possibly can.... I have this trivial task
> [that takes] 15 lines in `awk` and not much more in a variety of other
> languages; [so I'll write each of these programs and ask] how big is it,
> how fast does it run, and what pain did I go through to learn how to do it?"

- Lex Friedman. "Brian Kernighan: UNIX, C, AWK, AMPL, and Go Programming | Lex Fridman Podcast \#109." *Lex Friedman Podcast*. Podcast Audio. July 18, 2020, https://www.youtube.com/watch?v=O9upVbGSBFo&t=3729s. (Quote near marker 1:02:09)

I like Bayesian learning and inference, and I like programming languages.
This is a small hierarchy of tasks where I try to ask and answer similar
questions to those posed by Professor Kernighan.

## Problem 0: Minimal Working Example

Write a Naive Bayes classifier that takes as input a "*Design matrix*"
represented as a 2D list/array/vector, and a "*Label vector*" represented as
a 1D list/array/vector as input.

Store the learned "*model parameters*," allowing them to be applied to new
"*examples*" represented as 2D lists/arrays/vectors, and produce
"*classifications*" as 1D lists/arrays/vectors.

## Problem 1: Classify a clean CSV file

**Given**: a `.csv` file where the first column is a set of labels and the
remaining columns represent the variables.

**Task**: Split the data into a training and test set (70%/30%). Print the
accuracy when applying the classifier to the test set.

## Problem 2: Fairly Clean Text Data

Implement a bag of words model.

## Problem 3: Denoise Images

| Step | Result |
| :--- | :--- |
| Given a ground-truth image of monospace characters | ![72 characters in monospace font](courier-train.png) |
| ... and a noisy image | ![It is a little difficult to tell, but the image contains the phrase Supreme Court of the United States](00.png) |
| ... produce a de-noised version of the image | ![The image has been denoised and it is easy to read the phrase Supreme Court of the United States](output-py.png) |
| ... and its text. | `SUPREME COURT OF THE UNITED STATES` |
