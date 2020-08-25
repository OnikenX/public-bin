#!/bin/sh
WINE=${WINE:-wine}
WINEPREFIX=${WINEPREFIX:-$HOME/.local/share/wineprefixes/psdkwin7}
export WINEPREFIX
PROGRAMFILES="c:\Program Files"
WSDK="$PROGRAMFILES\Microsoft Visual Studio 9.0"
WPSDK="$PROGRAMFILES\Microsoft SDKs\Windows\v7.0"
WDXSDK="$PROGRAMFILES\Microsoft DirectX SDK (August 2006)"
export WINEPATH="c:\windows;c:\windows\system32;$WSDK\Common7\IDE;$WSDK\VC\bin"
export INCLUDE="$WSDK\VC\include;$WPSDK\Include;$WDXSDK\Include"
export LIB="$WSDK\VC\lib;$WPSDK\Lib;$WDXSDK\Lib\x86"
$WINE cl.exe $@
