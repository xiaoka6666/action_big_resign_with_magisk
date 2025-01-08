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

if [ -f "work/splloader.bin" ]; then
    work/get-raw-image "work/splloader.bin"
    sync
    sleep 1
    RETVAL=$?
    if [ $RETVAL -eq 0 ]; then
        mv splloader.bin u-boot-spl-16k.bin
    else
        exit 1
    fi
fi

if [ -f "work/uboot.bin" ]; then
    work/get-raw-image "work/uboot.bin"
    sync
    sleep 1
    RETVAL=$?
    if [ $RETVAL -eq 0 ]; then
        mv uboot.bin u-boot.bin
    else
        exit 1
    fi
fi

if [ -f "work/sml.bin" ]; then
    work/get-raw-image "work/sml.bin"
    sync
    sleep 1
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        exit 1
    fi
fi

if [ -f "work/tos.bin" ]; then
    work/get-raw-image "work/tos.bin"
    sync
    sleep 1
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        exit 1
    fi
elif [ -f "work/trustos.bin" ]; then
    work/get-raw-image "work/trustos.bin"
    sync
    sleep 1
    RETVAL=$?
    if [ $RETVAL -eq 0 ]; then
        mv "work/trustos.bin" "work/tos.bin"
    else
        exit 1
    fi
fi

if [ ! -f "work/teecfg.bin" ]; then
    sign9
else
    work/get-raw-image "work/teecfg.bin"
    sync
    sleep 1
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        rm work/teecfg.bin
        sign9
    else
        cd boot
        ./boot_patch_10.sh
        cd ../vbmeta
        python avbtool add_hash_footer --image ../boot/patched.img --partition_name boot --partition_size 36700160 --key rsa4096_boot.pem --algorithm SHA256_RSA4096 --prop com.android.build.boot.os_version:10
        cd ..
    fi
fi

cd vbmeta
python avbtool add_hash_footer --image ../recovery/recovery.img --partition_name recovery --partition_size 41943040 --key rsa4096_recovery.pem --algorithm SHA256_RSA4096
cd ..
