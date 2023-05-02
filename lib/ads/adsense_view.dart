import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
Widget adsenseAdsView() {
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
      'adViewType',
          (int viewID) => IFrameElement()
        ..width = '50%'
        ..height = '100'
        ..src = '''
        <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-5946802346170399"
        crossorigin="anonymous"></script>
<!-- side bar -->
<ins class="adsbygoogle"
     style="display:inline-block;width:336px;height:280px"
     data-ad-client="ca-pub-5946802346170399"
     data-ad-slot="7539562269"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>
        '''
        ..style.border = 'none',);

  return const Expanded(
    child: HtmlElementView(
      viewType: 'adViewType',
    ),
  );
}