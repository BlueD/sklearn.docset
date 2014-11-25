#!/usr/bin/bash
wget http://repo.continuum.io/miniconda/Miniconda-3.7.0-Linux-x86_64.sh -O miniconda.sh
bash ./miniconda.sh -b
export PATH=/home/travis/miniconda/bin:$PATH
conda update --yes conda
conda install --yes mkl

conda install --yes numpy scipy matplotlib scikit-learn sphinx pil

mkdir cache
pip install --download=cache/ scikit-learn
cd cache/
tar xf $(ls scikit-learn*.tar.gz)
cd scikit-learn*/doc/
echo Making html . . .
make -j4 html 1>/dev/null
echo Optimizeing pngs . . . 
make -j4 optipng 1>/dev/null
cd ../..
