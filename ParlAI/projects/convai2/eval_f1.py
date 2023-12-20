#!/usr/bin/env python3

# Copyright (c) Facebook, Inc. and its affiliates.
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
"""
Base script for running official ConvAI2 validation eval for f1.

This uses a the version of the dataset which does not contain candidates. Leaderboard
scores will be run in the same form but on a hidden test set.
"""

from parlai.scripts.eval_model import eval_model, setup_args as base_setup_args
import os

def setup_task(type='original', peacok=''):
    peacok_str = '' if peacok == '' else f'_{peacok}'
    task_name = f"convai2:self_{type}{peacok_str}:no_cands"
    return task_name

def setup_args(parser=None, type='original', peacok=''):
    task_name = setup_task(type, peacok)
    parser = base_setup_args(parser)
    parser.set_defaults(
        task=task_name,
        datatype='valid',
        hide_labels=False,
        dict_tokenizer='split',
        metrics='f1',
    )
    return parser


def eval_f1(opt, print_parser, output_file, beam=1):
    print("load model from {}".format(output_file))
    report = eval_model(opt, print_parser)
    print('============================')
    print(f"FINAL F1:  {report['f1']}")
    with open(os.path.join(output_file, f"f1_beam{beam}.txt"), 'w') as out:
        out.write(f"FINAL F1:  {report['f1']}")


if __name__ == '__main__':
    parser = setup_args()
    parser.set_defaults(model='repeat_label')
    opt = parser.parse_args()
    report = eval_f1(opt, parser)
