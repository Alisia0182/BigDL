#
# Copyright 2016 The BigDL Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

export MASTER_ADDR=127.0.0.1
export OMP_NUM_THREADS=7
export FI_PROVIDER=tcp
export CCL_ATL_TRANSPORT=ofi

mpirun -n 8 \
    python -u ./alpaca_qlora_finetuning.py \
    --micro_batch_size 8 \
    --batch_size 128 \
    --base_model "meta-llama/Llama-2-7b-hf" \
    --data_path "yahma/alpaca-cleaned" \
    --output_dir "./bigdl-lora-alpaca" \
    --gradient_checkpointing False \
    --lora_target_modules "['k_proj', 'q_proj', 'o_proj', 'v_proj', 'up_proj', 'down_proj', 'gate_proj']" \
    --training_mode "lora"
