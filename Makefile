CONFIG=bart_original
prepare-workstation:
	chmod +x workstation_setup/${CONFIG}.sh
	./workstation_setup/${CONFIG}.sh

define train_accelerate
CUDA_VISIBLE_DEVICES="0,1,2,3" \
accelerate launch \
	--multi_gpu \
	--num_processes 4 \
	train.py \
		--lr 8e-5 \
		--epochs 40 \
		--val_batch_size 2
endef

define accelerate_eval_ppl
CUDA_VISIBLE_DEVICES="3" \
accelerate launch \
        --num_processes 1
endef

#####################################################################################################

train-pc:
	${train_accelerate} --peft --dataset persona_chat --train_batch_size 8

train-peacok:
	${train_accelerate} --dataset persona_chat_peacok --train_batch_size 2


eval-ppl:
	${accelerate_eval_ppl} eval.py \
		--dataset persona_chat_peacok \
		--model_checkpoint persona_chat_peacok_original_first_run/checkpoint_latest \
                --tokenizer_checkpoint persona_chat_peacok_original_first_run
		--eval_batch_size 32


eval-f1:
	python eval_parlai.py \
		--eval_type f1 \
		--beam 2 \
		--max_history 7 \
		--gpu 1 \
		--model_checkpoint persona_chat_peacok_original/checkpoint_latest \
                --tokenizer_checkpoint persona_chat_peacok_original


eval-hits1:
	python eval_parlai.py \
		--eval_type hits@1 \
		--gpu 0 \
		--model_checkpoint persona_chat_peacok_original/checkpoint_latest \
                --tokenizer_checkpoint persona_chat_peacok_original

		--peacok
