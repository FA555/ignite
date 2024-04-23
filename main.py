#! /usr/bin/env python3
# -*- coding: utf-8 -*-


from dataclasses import dataclass
from typing import Optional

import pypinyin


@dataclass
class Entry:
    content: str
    page_no: Optional[int]
    alphabetic: Optional[str]
    heading: Optional[str]


def read_entries(file_name):
    entries = []

    with open(file_name, 'r') as f:
        lines = f.readlines()
        for line in lines:
            line = line.strip()
            if not line:
                continue

            content = None
            page_no = None
            alphabetic = None
            heading = None

            if line[0] == '<' and line[-1] == '>':
                heading = True
                content = line[1:-1]
            else:
                line = line.split()
                content = ' '.join(line[:-1])
                page_no = int(line[-1])
                alphabetic = ''.join(pypinyin.slug(
                    content, separator='', style=pypinyin.Style.FIRST_LETTER).split()).upper()

            entries.append(Entry(content, page_no, alphabetic, heading))

    return entries


def write_alphabetic(entries, file_name):
    with open(file_name, 'w') as f:
        for entry in sorted(filter(lambda e: e.alphabetic is not None, entries), key=lambda e: e.alphabetic):
            f.write(f'{entry.content} {entry.page_no} {entry.alphabetic}\n')


def write_unsorted(entries, file_name):
    with open(file_name, 'w') as f:
        for entry in entries:
            f.write(f'{entry.content} {entry.page_no} {entry.heading}\n')


def preprocess_data():
    DATA_DIR = 'example'
    entries = read_entries(DATA_DIR + '/index.txt')
    write_alphabetic(entries, DATA_DIR + '/index_alphabetic.txt')
    write_unsorted(entries, DATA_DIR + '/index_unsorted.txt')


if __name__ == "__main__":
    preprocess_data()
