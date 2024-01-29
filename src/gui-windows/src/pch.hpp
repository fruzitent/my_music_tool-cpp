#ifndef MYMUSICTOOL_PCH_HPP_
#define MYMUSICTOOL_PCH_HPP_

#define WIN32_LEAN_AND_MEAN
#include <Windows.h>

#ifdef GetCurrentTime
#undef GetCurrentTime
#endif

#include <MddBootstrap.h>
#include <WindowsAppSDK-VersionInfo.h>

#include <winrt/Microsoft.UI.Xaml.h>

#endif // MYMUSICTOOL_PCH_HPP_
