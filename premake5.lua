project "GameNetworkingSockets"
    kind "StaticLib"
    language "C++"
    cppdialect "C++20"
    staticruntime "off"
    
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    vcpkg_lib = "vcpkg_installed/x64-windows/lib/"

    files {
        "include/**.h",
        "src/**.cpp",
        "src/**.h",
        "src/**.c",
        "src/**.cc",
    }

    includedirs {
        "include",
        "src",
        "src/public",
        "src/common",

        "vcpkg_installed/x64-windows/include",
        "src/external/abseil",
        "src/external/curve25519-donna",
        "src/external/ed25519-donna",
        "src/external/picojson",
        "src/external/sha1-wpa",
        "src/external/steamwebrtc",
        "src/external/webrtc",
    }

    removefiles {
        "src/external/picojson/picotest/picotest.h",
        "src/external/picojson/picotest/picotest.c",
        "src/external/picojson/examples/**.cc",
        "src/external/picojson/test.cc",
        
        "src/external/webrtc/rtc_tools/**.h",
        "src/external/webrtc/rtc_tools/**.cpp",

        "src/external/abseil/absl/**.h",
        "src/external/abseil/absl/**.cc",
        "src/external/abseil/CMake/**.cc",

        "src/external/webrtc/**.h",
        "src/external/webrtc/**.cpp",
        "src/external/webrtc/**.c",
        "src/external/webrtc/**.cc",
        
        "src/common/crypto_libsodium.cpp",

    }

    links {
        vcpkg_lib .. "libcrypto.lib",
        vcpkg_lib .. "libprotobuf.lib",
        vcpkg_lib .. "libprotobuf-lite.lib",
        vcpkg_lib .. "libprotoc.lib",
        vcpkg_lib .. "libssl.lib",

        "absl",
    }

    defines
    {
        "STEAMNETWORKINGSOCKETS_FOREXPORT",
        "WEBRTC_WIN",
        "NOMINMAX",
        "VALVE_CRYPTO_ENABLE_25519",
        "_WINDOWS",
    }
    
    filter "system:windows"
        systemversion "latest"

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"
        --staticruntime "on"