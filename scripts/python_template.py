#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import logging
import time
import argparse

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--sleeptime', type=int, help='provide sleeptime in seconds')
    parser.set_defaults(sleeptime=10)
    args = parser.parse_args()

    if args.sleeptime != None:
        sleeptime = args.sleeptime

    print(sleeptime)
    
    
    while True:
        try:
            print('hello')
            sys.stdout.flush()
        except Exception as e:
            logging.warning(e)
            continue

        time.sleep(sleeptime)

if __name__ == '__main__':
    main()
