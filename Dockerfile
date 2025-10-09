# Use NVIDIA CUDA 13 + Python 3.12
FROM nvidia/cuda:13.0.0-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive

# ---- Set working directory ----
WORKDIR /workspace

# ---- Install dependencies ----
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl wget ca-certificates \
    build-essential g++ \
    python3 python3-pip python3-venv python3-dev \
    cmake pkg-config \
    libc6-dev libffi-dev \
    libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

# ---- Create and activate venv ----
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# ---- Upgrade pip safely ----
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# ---- Install PyTorch nightly (CUDA 13) ----
RUN pip install --no-cache-dir --pre torch torchvision \
    --index-url https://download.pytorch.org/whl/nightly/cu130 \
    --timeout 300 --retries 5

# Copy and install main project Python dependencies (including torch, jupyter)
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt

# ---- Install JupyterLab ----
RUN pip install --no-cache-dir jupyterlab

# ---- Expose port ----
EXPOSE 8888

# ---- Default command: start Jupyter in /workspace ----
CMD ["jupyter", "lab", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--allow-root", \
     "--ServerApp.root_dir=/workspace", \
     "--ServerApp.token=", \
     "--ServerApp.password="]