#! /bin/sh
# Configure your paths and filenames
SOURCEBINPATH=.
SOURCEBIN=LAIR
SOURCERUN=lair-noindex
SOURCEDOC=README.md
SRCFOLDER=valair
DEBFOLDER=valair
DEBVERSION=$(date +%Y%m%d)

TOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $TOME

git pull origin master

DEBFOLDERNAME="../$DEBFOLDER-$DEBVERSION"

# Create your scripts source dir
mkdir $DEBFOLDERNAME

# Copy your script to the source dir
cp $TOME $DEBFOLDERNAME -R
cd $DEBFOLDERNAME

./build.sh

# Create the packaging skeleton (debian/*)
dh_make -s --indep --createorig 

mkdir -p debian/tmp
cp -R bin share debian/tmp

# Remove make calls
grep -v makefile debian/rules > debian/rules.new 
mv debian/rules.new debian/rules 

# debian/install must contain the list of scripts to install 
# as well as the target directory
echo bin/$SOURCEBIN usr/bin > debian/install 
echo bin/$SOURCERUN usr/bin >> debian/install 
echo etc/lairrc etc >> debian/install
echo $SOURCEDOC usr/share/doc/$DEBFOLDER >> debian/install

# Remove the example files
rm debian/*.ex

dpkg-source --commit

# Build the package.
# You  will get a lot of warnings and ../somescripts_0.1-1_i386.deb
debuild -us -uc > ../log 
