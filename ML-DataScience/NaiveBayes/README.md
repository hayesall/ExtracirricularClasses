# Naïve Bayes

*Trying to write a clean, concise, and minimal Multinomial Naive Bayes implementation.*

## Problem 1: Denoise Images

| Step | Result |
| :--- | :--- |
| Given a ground-truth image of monospace characters | ![72 characters in monospace font](courier-train.png) |
| ... and a noisy image | ![It is a little difficult to tell, but the image contains the phrase Supreme Court of the United States](00.png) |
| ... produce a de-noised version of the image | ![The image has been denoised and it is easy to read the phrase Supreme Court of the United States](output-py.png) |
| ... and its text. | `SUPREME COURT OF THE UNITED STATES` |
