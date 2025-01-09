## resign

|                                               | android 9                                                    | android 10                                                   | android 11(+)   |
| --------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | --------------- |
| ums312/ums512/ud710 (not-fused or public key) | splloader+uboot+sml+trustos+vbmeta+recovery+boot             | splloader+uboot+sml+trustos+teecfg+vbmeta+recovery+boot      | not written yet |
| ums312/ums512/ud710 (fused)                   | uboot+sml+trustos+vbmeta+recovery+boot<br />splloader need manually process with [CVE-2022-38691](https://github.com/TomKing062/CVE-2022-38691_38692) | uboot+sml+trustos+teecfg+vbmeta+recovery+boot<br />splloader need manually process with [CVE-2022-38691](https://github.com/TomKing062/CVE-2022-38691_38692) | not written yet |
| other cpu (not-fused or public key)           | splloader+uboot+sml+trustos+vbmeta+recovery+boot             | splloader+uboot+sml+trustos+teecfg+vbmeta+recovery+boot      | not written yet |
| other cpu (fused)                             | UNSUPPORTED                                                  | UNSUPPORTED                                                  | UNSUPPORTED     |
