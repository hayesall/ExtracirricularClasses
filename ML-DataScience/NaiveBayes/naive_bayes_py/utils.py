# Copyright © 2021 Alexander L. Hayes

from PIL import Image
import numpy as np

from dataclasses import dataclass

CHARACTER_WIDTH = 14
CHARACTER_HEIGHT = 25


def load_letters(fname):
    # (based on skeleton code by D. Crandall, Oct 2020)

    im = Image.open(fname)
    px = im.load()
    (x_size, y_size) = im.size
    result = []
    for x_beg in range(
        0, int(x_size / CHARACTER_WIDTH) * CHARACTER_WIDTH, CHARACTER_WIDTH
    ):
        result += [
            [
                [
                    0 if px[x, y] < 1 else 1
                    for x in range(x_beg, x_beg + CHARACTER_WIDTH)
                ]
                for y in range(0, CHARACTER_HEIGHT)
            ],
        ]
    return result


def load_training_letters(fname):
    # (based on skeleton code by D. Crandall, Oct 2020)

    TRAIN_LETTERS = Alphabet.symbols
    letter_images = load_letters(fname)
    return {
        TRAIN_LETTERS[i]: Letter(TRAIN_LETTERS[i], np.array(letter_images[i]))
        for i in range(0, len(TRAIN_LETTERS))
    }


def make_denoised_image(fname, array_of_indexes):
    # https://stackoverflow.com/questions/30227466/combine-several-images-horizontally-with-python

    alpha = Alphabet()
    train_letters = load_training_letters("courier-train.png")

    max_height = CHARACTER_HEIGHT
    total_width = len(array_of_indexes) * CHARACTER_WIDTH

    new_im = Image.new("RGB", (total_width, max_height))

    x_offset = 0

    for l in array_of_indexes:

        im = Image.fromarray(np.uint8(train_letters[alpha[l]].array * 255))
        new_im.paste(im, (x_offset, 0))
        x_offset += im.size[0]

    new_im.save(fname)


@dataclass
class Letter:
    name: str
    array: np.ndarray


class Alphabet:
    """
    Alphabet Σ represents the discrete symbols in the language.

    Examples
    --------

    This may be used as a bidirectional map: requesting a string will return
    an integer, and requesting an integer will return a string.

    >>> alpha = Alphabet()
    >>> alpha['A']
    0
    >>> alpha[0]
    'A'
    """

    symbols = (
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789(),.-!?\"' "
    )

    def __init__(self):
        self._index = dict(zip(Alphabet.symbols, range(len(Alphabet.symbols))))

    def __repr__(self):
        return self.symbols

    def __len__(self):
        return len(self.symbols)

    @property
    def size(self):
        return len(self.symbols)

    def __getitem__(self, i):
        if isinstance(i, str):
            return self._index[i]
        elif isinstance(i, int):
            return self.symbols[i]
        elif isinstance(i, np.int64):
            return self.symbols[int(i)]
        raise TypeError("Cannot handle type.")
