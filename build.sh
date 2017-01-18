KERNEL_DIR="/home/phantom_1402/PhanTom/kernel"
IMG="$KERNEL_DIR/arch/arm64/boot/Image"
DTBTOOL="/home/phantom_1402/PhanTom/tools/dtbToolCM"
DTIMG="$KERNEL_DIR/arch/arm64/boot/dt.img"
WLAN="$KERNEL_DIR/drivers/staging/prima/wlan.ko"
STRIP="/home/phantom_1402/PhanTom/toolchain/bin/aarch64-linux-android-strip"
OUT_DIR="/home/phantom_1402/PhanTom/out/tomato"
export LD_LIBRARY_PATH="/home/phantom_1402/PhanTom/toolchain/lib"
export CROSS_COMPILE="/home/phantom_1402/PhanTom/toolchain/bin/aarch64-linux-android-"
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="phantom_1402"
export KBUILD_BUILD_HOST="TheDaringMachine"
make clean
#rm -rf .*
rm -rf $zIMG
rm -rf $DTIMG
rm -rf $WLAN
rm -rf $OUT_DIR/zImage
rm -rf $OUT_DIR/dtb
rm -rf $OUT_DIR/modules/wlan.ko
rm -rf $OUT_DIR/*.zip
make lineageos_tomato_defconfig
make -j9
$DTBTOOL -2 -o $KERNEL_DIR/arch/arm64/boot/dt.img -s 2048 -p $KERNEL_DIR/scripts/dtc/ $KERNEL_DIR/arch/arm/boot/dts/
cd drivers/staging/prima
$STRIP --strip-unneeded *.ko
cp -a $DTIMG $OUT_DIR/dtb
cp -a $IMG $OUT_DIR/zImage
cp -a $WLAN $OUT_DIR/modules/wlan.ko
cd $OUT_DIR
zip -r PhanTom-KERNEL-BETA-$(date +"%Y-%m-%d")-tomato.zip *

