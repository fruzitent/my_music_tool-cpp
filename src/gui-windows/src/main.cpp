#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#ifdef GetCurrentTime
#undef GetCurrentTime
#endif

#include <MddBootstrap.h>

#include <WindowsAppSDK-VersionInfo.h>
using Microsoft::WindowsAppSDK::Release::MajorMinor;
using Microsoft::WindowsAppSDK::Release::VersionTag;
using Microsoft::WindowsAppSDK::Runtime::Version::UInt64;

#include <winrt/base.h>

#include <winrt/Microsoft.UI.Xaml.h>
using winrt::Microsoft::UI::Xaml::Application;
using winrt::Microsoft::UI::Xaml::ApplicationT;
using winrt::Microsoft::UI::Xaml::LaunchActivatedEventArgs;
using winrt::Microsoft::UI::Xaml::Window;

class App : public ApplicationT<App> {
public:
  static auto OnLaunched(const LaunchActivatedEventArgs & /*unused*/) -> void {
    Window window;
    window.Activate();
  }
};

auto main() -> int try {
  winrt::init_apartment(winrt::apartment_type::single_threaded);

  if (FAILED(MddBootstrapInitialize(MajorMinor, VersionTag, PACKAGE_VERSION{UInt64}))) {
    return 1;
  }

  Application::Start([](auto &&) { winrt::make<App>(); });

  MddBootstrapShutdown();
  return 0;
} catch (...) {
  return 1;
}
