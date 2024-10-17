import 'dart:ffi';  // For FFI
import 'dart:io';

import 'package:ffi/ffi.dart';   // For platform-specific library loading

// Load the appropriate shared library based on the platform
final DynamicLibrary nativeLib = Platform.isLinux || Platform.isAndroid
    ? DynamicLibrary.open('libeval.so')
    : Platform.isWindows
        ? DynamicLibrary.open('eval.dll')
        : Platform.isMacOS
            ? DynamicLibrary.open('libeval.dylib')
            : throw UnsupportedError('Unsupported platform');

// Define the native function signature (C: double eval(const char*))
typedef EvalNative = Double Function(Pointer<Utf8> expr);

// Define a Dart function with the same signature
typedef EvalDart = double Function(Pointer<Utf8> expr);

// Look up the 'eval' function and convert it to a Dart function
final EvalDart eval = nativeLib
    .lookup<NativeFunction<EvalNative>>('eval')
    .asFunction<EvalDart>();
