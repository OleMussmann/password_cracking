#!/usr/bin/env python3

import sys

num_words = int(sys.argv[1])
word_file = sys.argv[2]

with open(word_file) as f:
    words = f.readlines()

words = [w.strip() for w in words]

multiple = words

for _ in range(num_words - 1):
    multiple = [w + m for w in words for m in multiple]

for combined in multiple:
    print(combined)
