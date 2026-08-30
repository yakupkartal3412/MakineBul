import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const KepceApp());
}

class KepceApp extends StatelessWidget {
  const KepceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KepçeBurada',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF59E0B),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const WebViewPage(),
    );
  }
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF0f172a))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            if (mounted) setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            if (mounted) setState(() => _isLoading = false);
          },
          onWebResourceError: (error) {
            debugPrint('WebResourceError: ${error.description}');
            if (mounted) setState(() => _isLoading = false);
          },
          onNavigationRequest: (request) {
            // WhatsApp ve telefon linklerini sisteme yönlendir
            final url = request.url;
            if (url.startsWith('tel:') ||
                url.startsWith('whatsapp:') ||
                url.contains('wa.me')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadFlutterAsset('index.html');

    // Güvenlik zamanlayıcısı: 2 saniye sonra yükleme ekranını her durumda kaldır
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted && _isLoading) {
        setState(() => _isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f172a),
      body: SafeArea(
        child: Stack(
          children: [
            // Ana WebView
            WebViewWidget(controller: _controller),

            // Yükleniyor ekranı
            if (_isLoading)
              Container(
                color: const Color(0xFF0f172a),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '🚜',
                        style: TextStyle(fontSize: 72),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'KepçeBurada',
                        style: TextStyle(
                          color: Color(0xFFF59E0B),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Yükleniyor...',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 30),
                      CircularProgressIndicator(
                        color: Color(0xFFF59E0B),
                        strokeWidth: 2,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Geri butonu: WebView geçmişinde geri git
  Future<bool> _onWillPop() async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
      return false;
    }
    return true;
  }
}
