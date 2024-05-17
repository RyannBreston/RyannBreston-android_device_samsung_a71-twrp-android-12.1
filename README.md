
export ALLOW_MISSING_DEPENDENCIES=true
. build/envsetup.sh
lunch twrp_a71-eng
make -j$(nproc) recoveryimage

