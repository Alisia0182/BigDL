# ChatGLM2
In this directory, you will find examples on how you could use BigDL-LLM `optimize_model` API to accelerate ChatGLM2 models. For illustration purposes, we utilize the [THUDM/chatglm2-6b](https://huggingface.co/THUDM/chatglm2-6b) as reference ChatGLM2 models.

## Requirements
To run these examples with BigDL-LLM on Intel GPUs, we have some recommended requirements for your machine, please refer to [here](../../../README.md#requirements) for more information.

## Example 1: Predict Tokens using `generate()` API
In the example [generate.py](./generate.py), we show a basic use case for a ChatGLM2 model to predict the next N tokens using `generate()` API, with BigDL-LLM INT4 optimizations on Intel GPUs.
### 1. Install
We suggest using conda to manage the Python environment. For more information about conda installation, please refer to [here](https://docs.conda.io/en/latest/miniconda.html#).

After installing conda, create a Python environment for BigDL-LLM:
```bash
conda create -n llm python=3.9 # recommend to use Python 3.9
conda activate llm

# below command will install intel_extension_for_pytorch==2.1.10+xpu as default
pip install --pre --upgrade bigdl-llm[xpu] -f https://developer.intel.com/ipex-whl-stable-xpu
```

### 2. Configures OneAPI environment variables
```bash
source /opt/intel/oneapi/setvars.sh
```

### 3. Run

For optimal performance on Arc, it is recommended to set several environment variables.

```bash
export USE_XETLA=OFF
export SYCL_PI_LEVEL_ZERO_USE_IMMEDIATE_COMMANDLISTS=1
```

```bash
python ./generate.py --prompt 'AI是什么？'
```

In the example, several arguments can be passed to satisfy your requirements:

- `--repo-id-or-model-path REPO_ID_OR_MODEL_PATH`: argument defining the huggingface repo id for the ChatGLM2 model to be downloaded, or the path to the huggingface checkpoint folder. It is default to be `'THUDM/chatglm2-6b'`.
- `--prompt PROMPT`: argument defining the prompt to be infered (with integrated prompt format for chat). It is default to be `'AI是什么？'`.
- `--n-predict N_PREDICT`: argument defining the max number of tokens to predict. It is default to be `32`.

#### 2.3 Sample Output
#### [THUDM/chatglm2-6b](https://huggingface.co/THUDM/chatglm2-6b)
```log
Inference time: xxxx s
-------------------- Output --------------------
问：AI是什么？

答： AI指的是人工智能,是一种能够通过学习和推理来执行任务的计算机程序。AI可以分为弱人工智能和强人工智能。

弱人工智能(也称为狭
```

```log
Inference time: xxxx s
-------------------- Output --------------------
问：What is AI?

答： Artificial Intelligence (AI) refers to the ability of a computer or machine to perform tasks that typically require human-like intelligence, such as understanding language, recognizing patterns
```

## Example 2: Stream Chat using `stream_chat()` API
In the example [streamchat.py](./streamchat.py), we show a basic use case for a ChatGLM2 model to stream chat, with BigDL-LLM INT4 optimizations.
### 1. Install
We suggest using conda to manage the Python environment. For more information about conda installation, please refer to [here](https://docs.conda.io/en/latest/miniconda.html#).

After installing conda, create a Python environment for BigDL-LLM:
```bash
conda create -n llm python=3.9 # recommend to use Python 3.9
conda activate llm

# below command will install intel_extension_for_pytorch==2.1.10+xpu as default
pip install --pre --upgrade bigdl-llm[xpu] -f https://developer.intel.com/ipex-whl-stable-xpu
```

### 2. Configures OneAPI environment variables
```bash
source /opt/intel/oneapi/setvars.sh
```

### 3. Run

For optimal performance on Arc, it is recommended to set several environment variables.

```bash
export USE_XETLA=OFF
export SYCL_PI_LEVEL_ZERO_USE_IMMEDIATE_COMMANDLISTS=1
```

**Stream Chat using `stream_chat()` API**:
```
python ./streamchat.py
```

**Chat using `chat()` API**:
```
python ./streamchat.py --disable-stream
```

In the example, several arguments can be passed to satisfy your requirements:

- `--repo-id-or-model-path REPO_ID_OR_MODEL_PATH`: argument defining the huggingface repo id for the ChatGLM2 model to be downloaded, or the path to the huggingface checkpoint folder. It is default to be `'THUDM/chatglm2-6b'`.
- `--question QUESTION`: argument defining the question to ask. It is default to be `"晚上睡不着应该怎么办"`.
- `--disable-stream`: argument defining whether to stream chat. If include `--disable-stream` when running the script, the stream chat is disabled and `chat()` API is used.