# Fine-Tunning-LLM
Generic script to fine tune LLM.

A walk through **building**, **running**, and **using** the Docker setup with **Unsloth**, **Hugging Face tools**, and **CUDA GPU acceleration**.

---

````markdown
# 🧠 LLM Fine-Tuning Environment (CUDA 12.8 + JupyterLab)

This Docker environment provides a ready-to-run GPU setup for fine-tuning large language models using **Unsloth**, **Transformers**, **PEFT**, **TRL**, and **BitsAndBytes** — all inside **JupyterLab**.

It’s based on:
- **Ubuntu 24.04**
- **CUDA 13.0 Runtime**
- **Python 3**
- **JupyterLab**
- **Transformers / TRL / PEFT / Accelerate / Datasets**
- **llama-cpp** (for GGUF/quantized model export)

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