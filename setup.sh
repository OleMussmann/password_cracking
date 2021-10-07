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

echo "Downloading John The Ripper password cracker ..."
# download John The Ripper password cracker
wget https://www.openwall.com/john/k/john-1.9.0-jumbo-1.tar.xz
tar xf john-1.9.0-jumbo-1.tar.xz
rm john-1.9.0-jumbo-1.tar.xz

echo "Compiling John The Ripper password cracker ..."
# compile John The Ripper
cd john-1.9.0-jumbo-1/src
./configure && make

cd ../..

cp john.conf john-1.9.0-jumbo-1/run

echo "Probing GPU for John The Ripper ..."
$(pwd)/john-1.9.0-jumbo-1/run/john --list=opencl-devices
