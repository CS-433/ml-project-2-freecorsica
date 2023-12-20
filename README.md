# PeaCoK Augmented PersonaChat based on BART

This is the copy of repository for ConvAI2 PersonaChat dialogue modeling with BART and PeaCoK knowledge graph augmentation (https://github.com/Silin159/PeaCoK-PersonaChat/tree/master) with our modifications applied for training, to reproduce our results, you should train the model following the steps written below. Then, clone the starter kit repository provided by the organizers of CPDC challenge (https://gitlab.aicrowd.com/aicrowd/challenges/commonsense-persona-grounded-dialogue-challenge-2023/commonsense-persona-grounded-dialogue-challenge-task-1-starter-kit#how-to-write-your-own-model) and change the path in the agent/bart_agent.py file to the checkpoint that you want to use for evaluation.

## Gathering the data
Our data can be downloaded from [this link](https://drive.google.com/drive/folders/1A51hZvSLvJoPAKDy2XR_eb-ooZqPRgbb?usp=sharing), please unzip the file and place the folder `data` under this root repository.

Our data include:

* Original PersonaChat (with either original or revised PersonaChat profiles):
  * Training set (original profiles): `data/persona_peacok/train_persona_original_chat_convai2.json`
  * Validation set (original profiles): `data/persona_peacok/valid_persona_original_chat_convai2.json`
  * Training set (revised profiles): `data/persona_peacok/train_persona_revised_chat_convai2.json`
  * Validation set (revised profiles): `data/persona_peacok/valid_persona_revised_chat_convai2.json`
* PersonaChat with profiles augmented with PeaCoK facts (up to 5 randomly chosen to augment each profile):
  * Training set (augmented original profiles): `data/persona_peacok/train_persona_original_chat_ext.json`
  * Validation set (augmented original profiles): `data/persona_peacok/valid_persona_original_chat_ext.json`
  * Training set (augmented revised profiles): `data/persona_peacok/train_persona_revised_chat_ext.json`
  * Validation set (augmented revised profiles): `data/persona_peacok/valid_persona_revised_chat_ext.json`
* Full set of PeaCoK facts linked to each PersonaChat profile:
  * For original profiles: `data/persona_peacok/persona_extend_full_original.json`
  * For revised profiles: `data/persona_peacok/persona_extend_full_revised.json`
* Full PeaCoK knowledge graph:
  * `data/peacok_kg.json`

## Environment setup

```
conda env create -f workstation_setup/bart_peacok.yml
conda activate bart_peacok
```

## Preparing datasets for train/eval

To save time prior to running training and evaluation, run the following command:

``python save_datasets.py --dataset {dataset}``

with options 'persona_chat_peacok' and 'persona_revised_chat' in order to prepare the required datasets.

## Run training or eval

To run the training and evaluation scripts, please refer to the Makefile. Prior to running it, set the desired arguments in the Makefile. The following options are supported:

```
make train-peacok

make eval-ppl
make eval-f1
make eval-hits1
```
