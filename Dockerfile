ARG BASE_IMG=oliversssf1/python-cuda:poetry-conda-tensorrt-python-cuda11.4.0

FROM ${BASE_IMG} as base

ENV TZ="Asia/Macau"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update -y && \
    apt install -y gcc g++ cmake protobuf-compiler libopencv-dev

# COPY setup.py setup.py
COPY requirements.txt requirements.txt

RUN eval "$($HOME/miniconda/bin/conda shell.bash hook)" && \
  conda create --name yolox python=3.9.12 && \
  conda activate yolox && \
  pip3 install -r requirements.txt