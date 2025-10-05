# Fine-Tunning-LLM
Generic script to fine tune LLM.

A walk through **building**, **running**, and **using** the Docker setup with **Unsloth**, **Hugging Face tools**, and **CUDA GPU acceleration**.

---

````markdown
# 🧠 LLM Fine-Tuning Environment (CUDA 12.8 + JupyterLab)

This Docker environment provides a ready-to-run GPU setup for fine-tuning large language models using **Unsloth**, **Transformers**, **PEFT**, **TRL**, and **BitsAndBytes** — all inside **JupyterLab**.

It’s based on:
- **Ubuntu 22.04**
- **CUDA 12.8 Runtime**
- **Python 3**
- **JupyterLab**
- **Unsloth + Unsloth Zoo**
- **Transformers / TRL / PEFT / Accelerate / Datasets**
- **llama-cpp-python** (for GGUF/quantized model export)

---

## 🚀 Prerequisites

1. **NVIDIA GPU Drivers** supporting CUDA 12.8  
   Verify:
   ```bash
   nvidia-smi
````

2. **Docker** installed:
   👉 [https://docs.docker.com/get-docker](https://docs.docker.com/get-docker)
3. **NVIDIA Container Toolkit** installed:
   👉 [https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

---

## 🧩 Project Structure

```
.
├── Dockerfile
├── docker-compose.yml
└── README.md
```

---

## 🏗️ Build the Docker Image

Run this once to build the image (tag: `llm-notebook`):

```bash
docker compose up --build
```

---

## ▶️ Launch JupyterLab

Start the container:

```bash
docker compose up
```

or in detached mode:

```bash
docker compose up -d
```

This will:

* Spin up the container with GPU access
* Launch **JupyterLab** on port **8888**
* Mount your current directory into `/workspace`

---

## 🔑 Access the Notebook

When the container starts, you’ll see output like:

```
http://127.0.0.1:8888/lab?token=xxxxxxxxxxxxxxxx
```

Copy that URL and open it in your browser.

---

## 📂 Mounted Workspace

Your current local directory (`.`) is mounted inside the container at:

```
/workspace
```

Any notebooks or scripts you edit here are automatically saved to your host machine.

---

## 🧠 Fine-Tuning Example (Unsloth + PEFT)

Create a new notebook in JupyterLab and try:

```python
from unsloth import FastLanguageModel
from datasets import load_dataset
import torch

print("CUDA available:", torch.cuda.is_available())

# Load model (example)
model, tokenizer = FastLanguageModel.from_pretrained(
    model_name="unsloth/llama-3-8b-bnb-4bit",
    max_seq_length=2048,
)

# Load a small dataset
dataset = load_dataset("Abirate/english_quotes", split="train[:100]")

# Example training configuration
model.train_model(
    dataset=dataset,
    text_column="quote",
    output_dir="outputs/llama3-finetuned",
    epochs=1,
    batch_size=2,
)

# Save GGUF / quantized model (optional)
model.save_quantized("outputs/llama3-finetuned.gguf", format="gguf")
```

---

## 🧰 Container Management

Stop the container:

```bash
docker compose down
```

Rebuild after editing Dockerfile:

```bash
docker compose build --no-cache
```

Attach to a running container shell:

```bash
docker exec -it llm-notebook bash
```

---

## ⚙️ Technical Notes

* Base image: `nvidia/cuda:12.8.0-runtime-ubuntu22.04`
* JupyterLab runs at `http://localhost:8888`
* All Python libraries are preinstalled inside the container:

  ```
  unsloth, unsloth_zoo, trl, peft, accelerate, bitsandbytes,
  datasets, sentencepiece, transformers, llama-cpp-python
  ```
* Compatible with **CUDA 12.8** GPUs (RTX 30xx, 40xx, etc.)

---

## 🧮 Troubleshooting

### 1. GPU not visible

Check:

```bash
docker run --rm --gpus all nvidia/cuda:12.8.0-runtime-ubuntu22.04 nvidia-smi
```

If this fails, reinstall the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html).

### 2. Jupyter not accessible

Ensure the port is exposed:

```bash
docker ps
```

Then visit `http://localhost:8888` in your browser.

---

### 3. Fine tune

Add fine tune material to workspace and then open in notebook.

---

## ✅ Done!

You now have a **fully GPU-accelerated fine-tuning lab** for Unsloth, Transformers, and GGUF model export.

Enjoy fast experiments and low-friction training with Docker + CUDA 12.8 🚀


