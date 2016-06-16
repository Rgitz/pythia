#!/bin/bash

# Create conda environments with needful packages readied
if [ "$(conda info -e 2>/dev/null | grep -o '^ *py3-pythia')" = "py3-pythia" ]; then
    echo "Environment exists, installing original configuration..."
    source activate py3-pythia && conda install python=3.4 scikit-learn beautifulsoup4 lxml jupyter
else
    echo "Creating new environment..."
    conda create --name py3-pythia python=3.4 scikit-learn beautifulsoup4 lxml jupyter
fi

# install tensorflow (CPU) and tflearn
source activate py3-pythia && \
    pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.8.0-cp34-cp34m-linux_x86_64.whl && \
    pip install --upgrade tflearn

# install theano and keras
source activate py3-pythia && \
    pip install --upgrade nose-parameterized Theano keras

# install Jupyter kernel
source activate py3-pythia && \
    pip install ipykernel && \
    path_info=$(python -m ipykernel install --user --name py3-pythia --display-name 'Python 3 (Pythia)') && \
    # Now add environment information on the second line of kernel.json
    kernel_path=$(echo $path_info | python -c "import re; print(re.sub(r'^.*?(/[^ ]+py3-pythia).*$', r'\\1', '$path_info'))") && \
    echo $kernel_path/kernel.json && cat "$kernel_path/kernel.json" && \
    sed -i '2i  "env" : { "PYTHONPATH" : "'"$PYTHIA_ROOT"'" },' "$kernel_path/kernel.json"
