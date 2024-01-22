project "GameNetworkingSockets"
    kind "StaticLib"
    language "C++"
    cppdialect "C++20"
    staticruntime "off"
    
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    vcpkg_lib_debug = "vcpkg_installed/x64-windows-static-md/debug/lib/"
    vcpkg_lib = "vcpkg_installed/x64-windows-static-md/lib/"

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

        "vcpkg_installed/x64-windows-static-md/include",
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

    defines
    {
        "STEAMNETWORKINGSOCKETS_STATIC_LINK",
        "STEAMDATAGRAMLIB_STATIC_LINK",
        "WEBRTC_WIN",
        "NOMINMAX",
        "VALVE_CRYPTO_ENABLE_25519",
        "VALVE_CRYPTO_25519_OPENSSLEVP",
        "VALVE_CRYPTO_OPENSSL",
        "_WINDOWS",
        "protobuf_BUILD_SHARED_LIBS",
    }

    links {
        "crypt32.lib", -- windows only, probably need to link against something else on linux...
        "absl",
    }
    
    filter "system:windows"
        systemversion "latest"

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

        links {
            vcpkg_lib_debug .. "libcrypto.lib",
            vcpkg_lib_debug .. "libprotobufd.lib",
            vcpkg_lib_debug .. "libprotobuf-lited.lib",
            vcpkg_lib_debug .. "libprotocd.lib",
            vcpkg_lib_debug .. "libssl.lib",
        }

    filter "configurations:Release"
        runtime "Release"
        optimize "on"
        --staticruntime "on"

        links {
            vcpkg_lib .. "libcrypto.lib",
            vcpkg_lib .. "libprotobuf.lib",
            vcpkg_lib .. "libprotobuf-lite.lib",
            vcpkg_lib .. "libprotoc.lib",
            vcpkg_lib .. "libssl.lib",
        }