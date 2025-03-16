FROM rocm/pytorch:rocm6.3.4_ubuntu24.04_py3.12_pytorch_release_2.4.0

WORKDIR /dockerx

RUN apt update && apt full-upgrade -y && apt install -y bc google-perftools && apt autoclean -y
#RUN conda update conda
#RUN conda create -y --name sd python=3.10.6 
#RUN conda install -y -n sd -c conda-forge libstdcxx-ng=12.1.0 --no-deps 
#RUN conda install -y -n sd -c conda-forge insightface=0.7.3 --no-deps
RUN pip install libstdcxx-ng==12.1.0 libstdcxx-ng==12.1.0 
#RUN conda init bash && . ~/.bashrc && echo "conda activate sd" >> ~/.bashrc
#RUN rm -rf /dockerx/stable-diffusion-webui
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui && cd stable-diffusion-webui && git checkout tags/v1.10.1
#RUN conda run --no-capture-output -n sd pip cache purge
WORKDIR /dockerx/stable-diffusion-webui
ADD run.sh .
RUN chmod +x run.sh

ENTRYPOINT ["./run.sh"]
