set -e

install_copack()
{
    cd /tmp && rm -rf ColPack
    git clone https://github.com/CSCsw/ColPack.git
    cd ColPack
    cd build/automake
    autoreconf -vif
    mkdir mywork
    cd mywork
    ../configure --prefix=/usr/local
    make -j8
    sudo make install
}

install_adolc()
{
    echo "adolc"
    cd /tmp
    wget https://www.coin-or.org/download/source/ADOL-C/ADOL-C-2.6.3.zip -O ADOL-C-2.6.3.zip
    unzip ADOL-C-2.6.3.zip
    cd ADOL-C-2.6.3
    ./configure --prefix="/usr/local" --enable-sparse --enable-addexa --enable-static --with-openmp-flag="-fopenmp" --with-colpack="/usr/local" ADD_CXXFLAGS="-fPIC" ADD_CFLAGS="-fPIC" ADD_FFLAGS="-fPIC"
    sudo make -j8 all
    sudo make install
    echo "/usr/local/lib64" > libadolc.conf
    sudo mv libadolc.conf /etc/ld.so.conf.d/
    sudo ldconfig
}

install_copack
install_adolc
