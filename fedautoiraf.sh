#!/bin/bash

# Download Miniconda2 with Python2. to Downloads directory
wget https://repo.anaconda.com/miniconda/Miniconda2-py27_4.8.3-Linux-x86_64.sh -P ~/Downloads/

# Change to Downloads directory
cd ~/Downloads

# Execute the installer
bash ./Miniconda2-py27_4.8.3-Linux-x86_64.sh

# Add miniconda to your PATH, if necessary
echo 'export PATH="~/miniconda/bin:$PATH"' >>~/.bash_profile
source ~/.bash_profile

# Configure Conda to use Astroconda channel
conda config --add channels http://ssb.stsci.edu/astroconda

# Install IRAF, PyRAF, and STScI
sudo dnf update
sudo dnf install glibc.i686 zlib.i686 ncurses-libs.i686 bzip2-libs.i686 uuid.i686 libxcb.i686
conda create -n iraf27 python=2.7 iraf-all pyraf-all stsci

# Create iraf shortcut script
printf '#!/bin/bash\n \n module load miniconda2\n \n source activate iraf27\n \n ds9 &\n \n xgterm -bg black -fg green -sb -title "IRAF" -e "ecl" &' > ~/iraf

# Make iraf script executable
sudo chmod u+x ~/iraf
