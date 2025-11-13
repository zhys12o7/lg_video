// ignore: avoid_web_libraries_in_flutter
import 'dart:js_util' as js_util;
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:js/js.dart';

import 'volume_service_interface.dart';
import 'volume_service_stub.dart' as fallback;

VolumeService getVolumeService() => _WebOSVolumeService();

class _WebOSVolumeService implements VolumeService {
  _WebOSVolumeService();

  static final VolumeService _fallbackService = fallback.getVolumeService();

  @override
  Future<bool> volumeUp() {
    if (!_hasWebOS) {
      debugPrint('[volume] webOS API unavailable, using fallback volumeUp');
      return _fallbackService.volumeUp();
    }
    return _invoke(method: 'volumeUp');
  }

  @override
  Future<bool> volumeDown() {
    if (!_hasWebOS) {
      debugPrint('[volume] webOS API unavailable, using fallback volumeDown');
      return _fallbackService.volumeDown();
    }
    return _invoke(method: 'volumeDown');
  }

  @override
  Future<bool> setMuted(bool muted) {
    if (!_hasWebOS) {
      debugPrint('[volume] webOS API unavailable, using fallback setMuted');
      return _fallbackService.setMuted(muted);
    }
    final parameters = js_util.newObject();
    js_util.setProperty(parameters, 'muted', muted);
    return _invoke(method: 'setMuted', parameters: parameters);
  }

  Future<bool> _invoke({required String method, Object? parameters}) {
    final completer = Completer<bool>();
    final service = js_util.getProperty(_webOS!, 'service');
    final options = js_util.newObject();
    js_util.setProperty(options, 'method', method);
    if (parameters != null) {
      js_util.setProperty(options, 'parameters', parameters);
    }

    js_util.setProperty(
      options,
      'onSuccess',
      allowInterop((dynamic _) {
        completer.complete(true);
      }),
    );
    js_util.setProperty(
      options,
      'onFailure',
      allowInterop((dynamic error) {
        final code = js_util.hasProperty(error, 'errorCode')
            ? js_util.getProperty(error, 'errorCode')
            : 'unknown';
        final text = js_util.hasProperty(error, 'errorText')
            ? js_util.getProperty(error, 'errorText')
            : 'unknown';
        debugPrint('[volume] $method failed: [$code] $text');
        completer.complete(false);
      }),
    );

    try {
      js_util.callMethod(service, 'request', [
        'luna://com.webos.audio',
        options,
      ]);
    } catch (error) {
      debugPrint('[volume] $method request threw: $error');
      completer.complete(false);
    }

    return completer.future;
  }
}

Object? get _webOS => js_util.hasProperty(js_util.globalThis, 'webOS')
    ? js_util.getProperty(js_util.globalThis, 'webOS')
    : null;

bool get _hasWebOS => _webOS != null;

