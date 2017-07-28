#!/bin/bash
#
# This script builds the application using the Coverity Scan build tool,
# and prepares the archive for uploading to the cloud static analyzer.
#


COVERITY_TOKEN=<Token>
SUBMITTER_EMAIL=<Your Email>

function die() { echo "$@" 1>&2; exit 1; }

rm -rf /tmp/cov-build/cov-int

export PATH=$PATH:~/Work/cov/cov-analysis-linux64-2017.07/bin
which cov-configure && which cov-build || die "Coverity Build Tool is not in PATH"


make host-tools
export PREBUILT_HOST_TOOLS=${ZEPHYR_BASE}/bin

cov-configure --comptype gcc --compiler i586-zephyr-elfiamcu-gcc --template
cov-build --dir /tmp/cov-build/cov-int sanitycheck -a x86 --all -b

cov-configure --comptype gcc --compiler arm-zephyr-eabi-gcc --template
cov-build --dir /tmp/cov-build/cov-int sanitycheck -a arm --all -b

cov-configure --comptype gcc --compiler arc-zephyr-elf-gcc --template
cov-build --dir /tmp/cov-build/cov-int sanitycheck -a arc --all -b

cov-configure --comptype gcc --compiler riscv32-zephyr-elf-gcc --template
cov-build --dir /tmp/cov-build/cov-int sanitycheck -a riscv32 --all -b

cov-configure --comptype gcc --compiler xtensa-zephyr-elf-gcc --template
cov-build --dir /tmp/cov-build/cov-int sanitycheck -a xtensa --all -b

cov-configure --comptype gcc --compiler nios2-zephyr-elf-gcc --template
cov-build --dir /tmp/cov-build/cov-int sanitycheck -a nios2 --all -b

VERSION=$(git describe)
cd /tmp/cov-build
tar czvf coverity.tgz cov-int

curl --form token=${COVERITY_TOKEN} \
  --form email=${SUBMITTER_EMAIL} \
  --form file=@coverity.tgz \
  --form version="${VERSION}" \
  --form description="Zephyr Project" \
  https://scan.coverity.com/builds?project=Zephyr
