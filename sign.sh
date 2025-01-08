sign9() {
    cd recovery
    ../magiskboot unpack -n recovery.img
    cd ../boot
    ../magiskboot unpack -n boot.img
    cp -f ../recovery/ramdisk.cpio ./
    ../magiskboot repack -n boot.img
    rm boot.img
    mv new-boot.img boot.img
    ../magiskboot cleanup
    ./boot_patch_9.sh
    cd ../vbmeta
    python avbtool add_hash_footer --image ../boot/patched.img --partition_name boot --partition_size 36700160 --key rsa4096_boot.pem --algorithm SHA256_RSA4096
    cd ..
}

cd work

if [ -f "splloader.bin" ]; then
    ./get-raw-image "splloader.bin"
    RETVAL=$?
    if [ $RETVAL -eq 0 ]; then
        mv splloader.bin u-boot-spl-16k.bin
    else
        exit 1
    fi
fi

if [ -f "uboot.bin" ]; then
    ./get-raw-image "uboot.bin"
    RETVAL=$?
    if [ $RETVAL -eq 0 ]; then
        mv uboot.bin u-boot.bin
    else
        exit 1
    fi
fi

if [ -f "sml.bin" ]; then
    ./get-raw-image "sml.bin"
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        exit 1
    fi
fi

if [ -f "tos.bin" ]; then
    ./get-raw-image "tos.bin"
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        exit 1
    fi
elif [ -f "trustos.bin" ]; then
    ./get-raw-image "trustos.bin"
    RETVAL=$?
    if [ $RETVAL -eq 0 ]; then
        mv "trustos.bin" "tos.bin"
    else
        exit 1
    fi
fi

if [ ! -f "teecfg.bin" ]; then
    cd ..
    sign9
else
    ./get-raw-image "teecfg.bin"
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        rm teecfg.bin
        cd ..
        sign9
    else
        cd ../boot
        ./boot_patch_10.sh
        cd ../vbmeta
        python avbtool add_hash_footer --image ../boot/patched.img --partition_name boot --partition_size 36700160 --key rsa4096_boot.pem --algorithm SHA256_RSA4096 --prop com.android.build.boot.os_version:10
        cd ..
    fi
fi

cd vbmeta
python avbtool add_hash_footer --image ../recovery/recovery.img --partition_name recovery --partition_size 41943040 --key rsa4096_recovery.pem --algorithm SHA256_RSA4096
cd ..
