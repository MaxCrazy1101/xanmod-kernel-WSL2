#
# Download kernel source code and apply dxgkrnl patch
#
git clone https://github.com/xanmod/linux.git -b 5.16 --depth 1 linux
pushd linux
git apply ../0001-5.16.y-dxgkrnl-patch.patch

#
# generate .config
#
cp ../wsl2_defconfig ./arch/x86/configs/wsl2_defconfig
make LLVM=1 LLVM_IAS=1 wsl2_defconfig
scripts/config -e LTO_CLANG_THIN
scripts/config -e MSKYLAKE
scripts/config -e PERF_EVENTS_INTEL_UNCORE

#
# Compile
#
make LLVM=1 LLVM_IAS=1 -j$(nproc)

popd