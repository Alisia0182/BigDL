# Qwen
In this directory, you will find examples on how you could run Qwen FP16 infernece with self-speculative decoding using BigDL-LLM on [Intel GPUs](../README.md). For illustration purposes, we utilize the [Qwen/Qwen-7B-Chat](https://huggingface.co/Qwen/Qwen-7B-Chat) and [Qwen/Qwen-14B-Chat](https://huggingface.co/Qwen/Qwen-14B-Chat) as reference Qwen models.

## 0. Requirements
To run these examples with BigDL-LLM on Intel GPUs, we have some recommended requirements for your machine, please refer to [here](../README.md#recommended-requirements) for more information.

## Example: Predict Tokens using `generate()` API
In the example [speculative.py](./speculative.py), we show a basic use case for a Qwen model to predict the next N tokens using `generate()` API, with BigDL-LLM speculative decoding optimizations on Intel GPUs.
### 1. Install
We suggest using conda to manage environment:
```bash
conda create -n llm python=3.9
conda activate llm
# below command will install intel_extension_for_pytorch==2.1.10+xpu as default
pip install --pre --upgrade bigdl-llm[xpu] -f https://developer.intel.com/ipex-whl-stable-xpu
```
### 2. Configures OneAPI environment variables
```bash
source /opt/intel/oneapi/setvars.sh
```

### 3. Run

For optimal performance on Intel Data Center GPU Max Series, it is recommended to set several environment variables.
```bash
export LD_PRELOAD=${LD_PRELOAD}:${CONDA_PREFIX}/lib/libtcmalloc.so
export SYCL_PI_LEVEL_ZERO_USE_IMMEDIATE_COMMANDLISTS=1
export ENABLE_SDP_FUSION=1
```

```
python ./speculative.py --repo-id-or-model-path REPO_ID_OR_MODEL_PATH --prompt PROMPT --n-predict N_PREDICT
```

Arguments info:
- `--repo-id-or-model-path REPO_ID_OR_MODEL_PATH`: argument defining the huggingface repo id for the Qwen model (e.g. `Qwen/Qwen-7B-Chat` and `Qwen/Qwen-14B-Chat`) to be downloaded, or the path to the huggingface checkpoint folder. It is default to be `'Qwen/Qwen-7B-Chat'`.
- `--prompt PROMPT`: argument defining the prompt to be infered (with integrated prompt format for chat). A default prompt is provided.
- `--n-predict N_PREDICT`: argument defining the max number of tokens to predict. It is default to be `128`.

#### Sample Output
#### [Qwen/Qwen-7B-Chat](https://huggingface.co/Qwen/Qwen-7B-Chat)
```log
system
You are a helpful assistant.

user
折纸的过程看似简单，其实想要做好，还是需要一套很复杂的工艺。以折一支玫瑰花为例，我们可以将整个折纸过程分成三个阶段，即：创建栅格折痕，制作立体基座，完成花瓣修饰。首先是创建栅格折痕：这一步有点像我们折千纸鹤的第一步，即通过对称州依次对折，然后按照长和宽两个维度，依次进行多等分的均匀折叠；最终在两个方向上的折痕会交织成一套完整均匀的小方格拼接图案；这些小方格就组成了类似二维坐标系的参考系统，使得我们在该平面上，通过组合临近折痕的方式从二维小方格上折叠出三维的高台或凹陷，以便于接下来的几座制作过程。需要注意的是，在建立栅格折痕的过程中，可能会出现折叠不对成的情况，这种错误所带来的后果可能是很严重的，就像是蝴蝶效应，一开始只是毫厘之差，最后可能就是天壤之别。然后是制作立体基座：在这一步，我们需要基于栅格折痕折出对称的三维高台或凹陷。从对称性分析不难发现，玫瑰花会有四个周对称的三维高台和配套凹陷。所以，我们可以先折出四分之一的凹陷和高台图案，然后以这四分之一的部分作为摸板，再依次折出其余三个部分的重复图案。值得注意的是，高台的布局不仅要考虑长和宽这两个唯独上的规整衬度和对称分布，还需要同时保证高这个维度上的整齐。与第一阶段的注意事项类似，请处理好三个维度上的所有折角，确保它们符合计划中所要求的那种布局，以免出现三维折叠过程中的蝴蝶效应；为此，我们常常会在折叠第一个四分之一图案的过程中，与成品玫瑰花进行反复比较，以便在第一时间排除掉所有可能的错误。最后一个阶段是完成花瓣修饰。在这个阶段，我们往往强调一个重要名词，叫用心折叠。这里的用心已经不是字面上的认真这个意思，而是指通过我们对于大自然中玫瑰花外型的理解，借助自然的曲线去不断修正花瓣的形状，以期逼近现实中的玫瑰花瓣外形。请注意，在这个阶段的最后一步，我们需要通过拉扯已经弯折的四个花瓣，来调整玫瑰花中心的绽放程度。这个过程可能会伴随玫瑰花整体结构的崩塌，所以，一定要控制好调整的力道，以免出现不可逆的后果。最终，经过三个阶段的折叠，我们会得到一支栩栩如生的玫瑰花冠。如果条件允许，我们可以在一根拉直的铁丝上缠绕绿色纸条，并将玫瑰花冠插在铁丝的一段。这样，我们就得到了一支手工玫瑰花。总之，通过创建栅格折痕，制作立体基座，以及完成花瓣修饰，我们从二维的纸面上创作出了一支三维的花朵。这个过程虽然看似简单，但它确实我们人类借助想象力和常见素材而创作出的艺术品。问: 请基于以上描述，分析哪些步骤做错了很大可能会导致最终折叠失败？答: 

assistant
根据上述描述，如果在折叠过程中出现了以下情况，那么可能会导致最终折叠失败：

1. 折叠不对称：在创建栅格折痕的过程中，如果折叠不对称，可能会导致后续的立体基座和花瓣修饰无法正确地组合在一起，从而影响最终的折叠效果。

2. 高台布局不合理：在制作立体基座的过程中，如果高台的布局不合理，可能会导致高这个维度上的整齐度受到影响，从而影响最终的折叠效果。

3. 花瓣形状不准确：在完成花瓣修饰的过程中，如果花瓣形状不准确，可能会导致玫瑰花
Tokens generated 128
E2E Generation time xx.xxxxs
First token latency xx.xxxxs
```

#### [Qwen/Qwen-14B-Chat](https://huggingface.co/Qwen/Qwen-14B-Chat)
```log
system
You are a helpful assistant.

user
折纸的过程看似简单，其实想要做好，还是需要一套很复杂的工艺。以折一支玫瑰花为例，我们可以将整个折纸过程分成三个阶段，即：创建栅格折痕，制作立体基座，完成花瓣修饰。首先是创建栅格折痕：这一步有点像我们折千纸鹤的第一步，即通过对称州依次对折，然后按照长和宽两个维度，依次进行多等分的均匀折叠；最终在两个方向上的折痕会交织成一套完整均匀的小方格拼接图案；这些小方格就组成了类似二维坐标系的参考系统，使得我们在该平面上，通过组合临近折痕的方式从二维小方格上折叠出三维的高台或凹陷，以便于接下来的几座制作过程。需要注意的是，在建立栅格折痕的过程中，可能会出现折叠不对成的情况，这种错误所带来的后果可能是很严重的，就像是蝴蝶效应，一开始只是毫厘之差，最后可能就是天壤之别。然后是制作立体基座：在这一步，我们需要基于栅格折痕折出对称的三维高台或凹陷。从对称性分析不难发现，玫瑰花会有四个周对称的三维高台和配套凹陷。所以，我们可以先折出四分之一的凹陷和高台图案，然后以这四分之一的部分作为摸板，再依次折出其余三个部分的重复图案。值得注意的是，高台的布局不仅要考虑长和宽这两个唯独上的规整衬度和对称分布，还需要同时保证高这个维度上的整齐。与第一阶段的注意事项类似，请处理好三个维度上的所有折角，确保它们符合计划中所要求的那种布局，以免出现三维折叠过程中的蝴蝶效应；为此，我们常常会在折叠第一个四分之一图案的过程中，与成品玫瑰花进行反复比较，以便在第一时间排除掉所有可能的错误。最后一个阶段是完成花瓣修饰。在这个阶段，我们往往强调一个重要名词，叫用心折叠。这里的用心已经不是字面上的认真这个意思，而是指通过我们对于大自然中玫瑰花外型的理解，借助自然的曲线去不断修正花瓣的形状，以期逼近现实中的玫瑰花瓣外形。请注意，在这个阶段的最后一步，我们需要通过拉扯已经弯折的四个花瓣，来调整玫瑰花中心的绽放程度。这个过程可能会伴随玫瑰花整体结构的崩塌，所以，一定要控制好调整的力道，以免出现不可逆的后果。最终，经过三个阶段的折叠，我们会得到一支栩栩如生的玫瑰花冠。如果条件允许，我们可以在一根拉直的铁丝上缠绕绿色纸条，并将玫瑰花冠插在铁丝的一段。这样，我们就得到了一支手工玫瑰花。总之，通过创建栅格折痕，制作立体基座，以及完成花瓣修饰，我们从二维的纸面上创作出了一支三维的花朵。这个过程虽然看似简单，但它确实我们人类借助想象力和常见素材而创作出的艺术品。问: 请基于以上描述，分析哪些步骤做错了很大可能会导致最终折叠失败？答: 

assistant
在折纸过程中，如果以下步骤做得不好，可能会导致最终折叠失败：

1. 创建栅格折痕时，如果折叠不对称，可能会导致后续的立体基座和花瓣修饰出现问题。

2. 制作立体基座时，如果高台的布局不合理或者折角处理不当，可能会导致三维折叠过程中的蝴蝶效应。

3. 完成花瓣修饰时，如果没有用心折叠，没有理解并模仿大自然中玫瑰花的外形，可能会导致花瓣形状偏离真实玫瑰花。

4. 在调整玫瑰花中心绽放程度时，如果用力过猛，可能会导致玫瑰花整体
Tokens generated 128
E2E Generation time x.xxxxs
First token latency x.xxxxs
```
