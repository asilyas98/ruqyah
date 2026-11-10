import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        WebViewContainer()
            .ignoresSafeArea()
    }
}

struct WebViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()

        // Allow inline audio/video without requiring a user gesture
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        // Enable JavaScript
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        config.defaultWebpagePreferences = prefs

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.scrollView.bounces = false
        webView.isOpaque = true

        // Load the bundled index.html from the www/ folder
        if let url = Bundle.main.url(
            forResource: "index",
            withExtension: "html",
            subdirectory: "www"
        ) {
            webView.loadFileURL(
                url,
                allowingReadAccessTo: url.deletingLastPathComponent()
            )
        }
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}
}
