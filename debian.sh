#! /bin/sh
# Configure your paths and filenames
SOURCEBINPATH=.
SOURCEBIN=LAIR
SOURCEDOC=README.md
SRCFOLDER=vaLAIR
DEBFOLDER=valair
DEBVERSION=$(date +%Y%m%d)

cd $SRCFOLDER

git pull origin master

DEBFOLDERNAME="../$DEBFOLDER-$DEBVERSION"

# Create your scripts source dir
mkdir $DEBFOLDERNAME

# Copy your script to the source dir
cp $SOURCEBINPATH $DEBFOLDERNAME -R
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
for d in share/lair/*; do
    if [ -d $d ]; then
        for e in $d/*; do
            echo $e >> debian/install
        done
    else
        echo $d >> debian/install
    fi
done
echo $SOURCEDOC usr/share/doc/$DEBFOLDER >> debian/install

# Remove the example files
rm debian/*.ex

dpkg-source --commit

# Build the package.
# You  will get a lot of warnings and ../somescripts_0.1-1_i386.deb
debuild -us -uc > ../log 
