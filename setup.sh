#!/bin/bash

cd word_files

echo "Downloading word files ..."
# download a text file containing the 10000 most used English words
wget https://resources.oreilly.com/live-training/enhanced-machine-learning-for-cybersecurity/raw/master/Data/google-10000-english.txt

# download the rockyou password list
wget http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2
bunzip2 rockyou.txt.bz2
rm rockyou.txt.bz2

# create smaller versions of google's wordlist
head -n 1500 google-10000-english.txt > google-1500-english.txt
head -n 100 google-10000-english.txt > google-100-english.txt

cd ..

echo "Installing tools and drivers"
apt-get -y install git build-essential libssl-dev zlib1g-dev nvidia-opencl-dev nvidia-driver-545

echo "Downloading John The Ripper password cracker ..."
git clone https://github.com/openwall/john -b bleeding-jumbo john

echo "Compiling John The Ripper password cracker ..."
# compile John The Ripper
cd john/src
./configure && make -s clean
make -s

cd ../..

cp john.conf john/run

echo "Probing GPU for John The Ripper ..."
$(pwd)/john/run/john --list=opencl-devices
