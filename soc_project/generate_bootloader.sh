#!/bin/bash

# The script should be placed in the root quartus directory

# save path of the script for reference
PATH_SCRIPT=`realpath $0`
PATH_TOP=`dirname $PATH_SCRIPT`

# 0. For some dome reason set up a really old compiler
# (1) Check if compiler is in the path if not, (2) check if compiler already downloaded else (3) 
# download the compiler and (4) set up the PATH variable
echo "**** SETING UP TOOLCHAIN"
cd "$PATH_TOP" \
&& echo $PATH | grep gcc-linaro \
|| [ ! -d "software/toolchain" ] \
&& mkdir -p "software/toolchain" \
&& cd "software/toolchain" \
&& wget https://releases.linaro.org/components/toolchain/binaries/7.5-2019.12/arm-linux-gnueabihf/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf.tar.xz && \
tar xf *.tar.xz \
&& rm *.tar.xz \
|| echo "ERROR: Failed to setup up compiler"


echo $PATH | grep gcc-linaro \
|| cd "$PATH_TOP"/software/toolchain/*linaro*/bin \
&& export PATH=`pwd`:$PATH \
|| echo "ERROR: Failed to setup up compiler"


# 1 Set up important enironmental variables
echo "**** SETING UP ENVIRONMENT"
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-


# 2. extracting BSP (Board Support Package) data/sources/settings from the Quartus handoff
echo "**** SETING UP BSP handoff"
cd "$PATH_TOP" && \
bsp-create-settings \
--type spl \
--bsp-dir software/bootloader \
--preloader-settings-dir hps_isw_handoff/soc_system_hps_0 \
--settings software/bootloader/settings.bsp \
|| echo "ERROR: Failed to extract BSP settings (Check if you are using EDS environment)"


# 3. pull uboot sources
echo "**** PULLING UBOOT SOURCES"
cd "$PATH_TOP" \
&& [ -d "software/bootloader/u-boot-socfpga" ] \
&& echo "BOOTLOADER directory exists, skipping" \
|| (echo "BOOTLOADER repository not present, pulling sources from github" \
&& cd software/bootloader \
&& git clone https://github.com/altera-opensource/u-boot-socfpga \
&& cd u-boot-socfpga \
&& git checkout -b custom_build -t origin/socfpga_v2020.04) \
|| echo "ERROR: Failed to pull sources from gitgub (Maybe git is not present in the PATH?)"


# 4. run qts_filter to format all the handoff info appropriately for the u-boot
echo "**** SETTING UP FORMATTED HANDOFF"
cd "$PATH_TOP/software/bootloader/u-boot-socfpga" \
&& ./arch/arm/mach-socfpga/qts-filter.sh cyclone5 ../../../ ../ ./board/altera/cyclone5-socdk/qts/ \
|| echo "ERROR: Failed to execute qts-filter script"


# 5. configure uboot using default configuration and build it
echo "**** CONFIGURING AND BUILDING UBOOT"
cd "$PATH_TOP/software/bootloader/u-boot-socfpga" \
&& make socfpga_cyclone5_defconfig \
&& make -j 4 \
|| echo "ERROR: Failed to build the uboot"
