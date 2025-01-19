## resign

|                                               | android 9                                                    | android 10(+)                                                |
| --------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ums312/ums512/ud710 (not-fused or public key) | splloader+uboot+sml+trustos+vbmeta+recovery+boot             | splloader+uboot+sml+trustos+teecfg+vbmeta+recovery+boot      |
| ums312/ums512/ud710 (fused)                   | uboot+sml+trustos+vbmeta+recovery+boot<br />splloader need manually process with [CVE-2022-38691](https://github.com/TomKing062/CVE-2022-38691_38692) | uboot+sml+trustos+teecfg+vbmeta+recovery+boot<br />splloader need manually process with [CVE-2022-38691](https://github.com/TomKing062/CVE-2022-38691_38692) |
| other cpu (not-fused or public key)           | splloader+uboot+sml+trustos+vbmeta+recovery+boot             | splloader+uboot+sml+trustos+teecfg+vbmeta+recovery+boot      |
| other cpu (fused)                             | UNSUPPORTED                                                  | UNSUPPORTED                                                  |

## Note

1. This method works with both unlocked and locked BL, but wiping userdata might be still needed. (vmbeta change will affect data encryption?)
2. ums312/ums512/ud710: on android 11(+), you can use [gen_spl-unlock](https://raw.githubusercontent.com/TomKing062/CVE-2022-38694_unlock_bootloader/info/gen_spl-unlock.c) with [CVE-2022-38691](https://github.com/TomKing062/CVE-2022-38691_38692)
