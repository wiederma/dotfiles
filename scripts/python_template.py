#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import time
import argparse

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--sleeptime',
        default=10,
        type=int,
        help='provide sleeptime in seconds'
    )

    args = parser.parse_args()

    while True:
        try:
            print('hello')
            sys.stdout.flush()
        except Exception as e:
            print(e, file=sys.stderr)
            continue

        time.sleep(args.sleeptime)

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('Shutting down', file=sys.stderr)
    except Exception as e:
        print(e)
