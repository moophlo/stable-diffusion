#!/bin/bash -x



if [ -n "$COMMANDLINE_ARGS" ]; then
	echo "export COMMANDLINE_ARGS=\"$COMMANDLINE_ARGS\""  >> /dockerx/stable-diffusion-webui/webui-user.sh
else
	echo 'export COMMANDLINE_ARGS="--listen --device-id=0 --precision full --no-half --medvram --skip-version-check --api --gradio-auth-path auth --enable-insecure-extension-access --opt-sub-quad-attention"' >> /dockerx/stable-diffusion-webui/webui-user.sh
fi

if [ -n "$WEBUI_USER" ] && [ -n "$WEBUI_PASSWORD" ]; then
	echo "$WEBUI_USER:$WEBUI_PASSWORD" > /dockerx/stable-diffusion-webui/auth
else
	echo 'admin:ThisIsMySuperSecurePassword.123' > /dockerx/stable-diffusion-webui/auth
fi

echo 'export TORCH_COMMAND="pip install https://repo.radeon.com/rocm/manylinux/rocm-rel-6.3.4/torch-2.4.0%2Brocm6.3.4.git7cecbf6d-cp312-cp312-linux_x86_64.whl https://repo.radeon.com/rocm/manylinux/rocm-rel-6.3.4/torchvision-0.19.0%2Brocm6.3.4.gitfab84886-cp312-cp312-linux_x86_64.whl https://repo.radeon.com/rocm/manylinux/rocm-rel-6.3.4/pytorch_triton_rocm-3.0.0%2Brocm6.3.4.git75cc27c2-cp312-cp312-linux_x86_64.whl https://repo.radeon.com/rocm/manylinux/rocm-rel-6.3.4/torchaudio-2.4.0%2Brocm6.3.4.git69d40773-cp312-cp312-linux_x86_64.whl"' >> /dockerx/stable-diffusion-webui/webui-user.sh

#mv /dockerx/stable-diffusion-webui/venv/lib/python3.10/site-packages/torch/lib/libMIOpen.so /dockerx/stable-diffusion-webui/venv/lib/python3.10/site-packages/torch/lib/libMIOpen.so_ORIG
#cp /opt/rocm/lib/libMIOpen.so.1.0.50200.nvv5.ms1 /dockerx/stable-diffusion-webui/venv/lib/python3.10/site-packages/torch/lib/libMIOpen.so

sed -i 's|^can_run_as_root.*|can_run_as_root=1|g' /dockerx/stable-diffusion-webui/webui.sh

./webui.sh




