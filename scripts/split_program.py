#!/usr/bin/env python3
"""
Split a list of 32-bit hex instructions into 4 byte-wide .mem files
Little-endian per instruction (LSB goes to program_ram0.mem)
Usage: python tools\split_program.py input_hex.txt output_dir
Input format: one 32-bit hex word per line, optionally with 0x prefix
Example line: 00500093
"""
import sys
from pathlib import Path

def normalize_hex(s):
    s = s.strip()
    if s.startswith('0x') or s.startswith('0X'):
        s = s[2:]
    # pad to 8 chars
    return s.zfill(8)


def split(words, outdir):
    outdir = Path(outdir)
    outdir.mkdir(parents=True, exist_ok=True)
    files = [outdir / f'program_ram{i}.mem' for i in range(4)]
    # open files
    fhs = [open(p, 'w') for p in files]
    try:
        for w in words:
            h = normalize_hex(w)
            # bytes little-endian
            b0 = h[6:8]
            b1 = h[4:6]
            b2 = h[2:4]
            b3 = h[0:2]
            fhs[0].write(b0 + '\n')
            fhs[1].write(b1 + '\n')
            fhs[2].write(b2 + '\n')
            fhs[3].write(b3 + '\n')
    finally:
        for fh in fhs:
            fh.close()


if __name__ == '__main__':
    if len(sys.argv) < 3:
        print('Usage: split_program.py input_hex.txt output_dir')
        sys.exit(1)
    infile = Path(sys.argv[1])
    outdir = Path(sys.argv[2])
    words = [l for l in infile.read_text().splitlines() if l.strip()]
    split(words, outdir)
    print(f'Wrote 4 .mem files to {outdir.resolve()}')
