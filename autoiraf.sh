#!/bin/bash

#Copyright (C) 2021  Bambi A. McCole
#email msbam@msbam.space
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Download Miniconda2 with Python2. to Downloads directory
wget https://repo.anaconda.com/miniconda/Miniconda2-py27_4.8.3-Linux-x86_64.sh -P ~/Downloads/

# Change to Downloads directory
cd ~/Downloads

# Execute the installer
bash ./Miniconda2-py27_4.8.3-Linux-x86_64.sh

# Add miniconda to your PATH, if necessary
searchString="~/miniconda2/bin:$PATH"
searchFile="~/.bash_profile"
if ! grep -q "$searchString" $searchFile; then
	echo 'export PATH="~/miniconda2/bin:$PATH"' >>~/.bash_profile
	source ~/.bash_profile
fi

# Configure Conda to use Astroconda channel
conda config --add channels http://ssb.stsci.edu/astroconda

# Install IRAF, PyRAF, and STScI
sudo apt update
sudo apt install libc6:i386 libz1:i386 libncurses5:i386 libbz2-1.0:i386 libuuid1:i386 libxcb1:i386 libxmu6:i386
conda create -n iraf27 python=2.7 iraf-all pyraf-all stsci

# Create IRAF shortcut script
printf '#!/bin/bash\n \n module load miniconda2\n \n source activate iraf27\n \n ds9 &\n \n xgterm -bg black -fg green -sb -title "IRAF" -e "ecl" &' > ~/iraf

# Change to home directory
cd ~/

# Make IRAF script executable
sudo chmod u+x ~/iraf

# Set up new IRAF
source activate iraf27
mkdir iraf
cd iraf
mkiraf
# Enter 'xgterm' for terminal type.
cl