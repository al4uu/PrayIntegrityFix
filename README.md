# Pray Integrity Fix a.k.a Play Integrity Fix

This module attempts to fix Play Integrity and SafetyNet verdicts to obtain a valid attestation.

## NOTE

This module is designed specifically to help pass the Play Integrity tests and ensure your device is certified. It does not hide root access or bypass detection mechanisms in any third-party apps. Please note that this module is focused solely on Google’s Play Integrity API. Any issues regarding compatibility with non-Google apps will be closed, as they fall outside the scope of this project. Use at your own risk and ensure you understand the limitations of this module.

## Tutorial

You will need root and Zygisk, so you must choose ONE of this three setups:

- [**Magisk**](https://github.com/topjohnwu/Magisk) with Zygisk enabled or use the [**ZygiskNext**](https://github.com/Dr-TSNG/ZygiskNext) module installed.
- [**KernelSU**](https://github.com/tiann/KernelSU) with [**ZygiskNext**](https://github.com/Dr-TSNG/ZygiskNext) module installed.
- [**APatch**](https://github.com/bmax121/APatch) with [**ZygiskNext**](https://github.com/Dr-TSNG/ZygiskNext) module installed.

After flashing and reboot your device, [**you can check PI and SN using this apps**](https://play.google.com/store/apps/details?id=com.henrikherzig.playintegritychecker)

NOTE: SafetyNet is obsolete, [**more info here**](https://developer.android.com/privacy-and-security/safetynet/deprecation-timeline)

Also, if you are using custom rom or custom kernel, be sure that your kernel name isn't blacklisted, you can check it running `uname -r` command. [**This is a list of banned strings**](https://xdaforums.com/t/module-play-integrity-fix-safetynet-fix.4607985/post-89308909)

## Verdicts

After requesting an attestation, you should get this result:

- MEETS_BASIC_INTEGRITY   ✅
- MEETS_DEVICE_INTEGRITY  ✅
- MEETS_STRONG_INTEGRITY  ❌
- MEETS_VIRTUAL_INTEGRITY ❌ (this is for emulators only)

NOTE: If you want a strong verdict on a device with an unlocked bootloader, use the [**Tricky Store**](https://github.com/5ec1cff/TrickyStore) module and a valid keybox that can provide strong integrity. **PLEASE NOTE, NEVER PURCHASE A KEYBOX FROM ONLINE STORES, IT IS 100% A SCAM!**

You can know more about verdicts in this post: https://xdaforums.com/t/info-play-integrity-api-replacement-for-safetynet.4479337/

And in SafetyNet you should get this:

- `basicIntegrity`:  **true**
- `ctsProfileMatch`: **true**
- `evaluationType`:  **BASIC**

## Acknowledgments
- [**kdrag0n**](https://github.com/kdrag0n/safetynet-fix) & [**Displax**](https://github.com/Displax/safetynet-fix) for the original idea.
- [**osm0sis**](https://github.com/osm0sis) for his original [**autopif2.sh**](https://github.com/osm0sis/PlayIntegrityFork/blob/main/module/autopif2.sh) script.
- [**backslashxx**](https://github.com/backslashxx) & [**KOWX712**](https://github.com/KOWX712) for improving it ([**action.sh**](https://github.com/al4uu/PrayIntegrityFix/blob/main/module/action.sh)).

## FAQ
- [**XDA Forums**](https://xdaforums.com/t/pif-faq.4653307/)

## Download
- [**Release Pages**](https://github.com/al4uu/PrayIntegrityFix/releases/latest)

## Donations
- [**PayPal**](https://www.paypal.com/paypalme/chiteroman0)
