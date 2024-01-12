# SSH Server with gpu support setup using docker

## Environment
1.  Windows 11 with wsl2 installed 
2.  RTX-3060 GPU

## Setup steps

1.  Install cuda and docker. \
    Recommended resource: https://developer.nvidia.com/cuda-downloads

2.  Verify the installation with 
    ```
    sudo docker run --rm --gpus all nvidia/cuda:12.3.1-runtime-ubuntu22.04 nvidia-smi
    ```
    The output should be similar to 
    ```
    Fri Jan 12 16:00:03 2024       
    +---------------------------------------------------------------------------------------+
    | NVIDIA-SMI 545.23.07              Driver Version: 546.12       CUDA Version: 12.3     |
    |-----------------------------------------+----------------------+----------------------+
    | GPU  Name                 Persistence-M | Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp   Perf          Pwr:Usage/Cap |         Memory-Usage | GPU-Util  Compute M. |
    |                                         |                      |               MIG M. |
    |=========================================+======================+======================|
    |   0  NVIDIA GeForce RTX 3060        On  | 00000000:01:00.0  On |                  N/A |
    |  0%   47C    P8              20W / 170W |   1001MiB / 12288MiB |      2%      Default |
    |                                         |                      |                  N/A |
    +-----------------------------------------+----------------------+----------------------+
                                                                                            
    +---------------------------------------------------------------------------------------+
    | Processes:                                                                            |
    |  GPU   GI   CI        PID   Type   Process name                            GPU Memory |
    |        ID   ID                                                             Usage      |
    |=======================================================================================|
    |  No running processes found                                                           |
    +---------------------------------------------------------------------------------------+
    ```

2.  Edit `Dockerfile` and `run.sh` to your ideal settings. \
    The default settings include user mark with root privilege and the password for both the root and mark is 0000.

3.  Run `bash run.sh`.

4.  To connect to the ssh server, run `ssh -p 2223 mark@localhost`. \
    Note that the 2223 is the port I used and can be changed in `run.sh`.

## Mounted directory

The default settings mounts the `/mnt` in the container to the current directory's `server`.