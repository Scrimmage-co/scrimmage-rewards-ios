import SwiftUI
import WebKit

struct ContentView: View {
  @State private var token: String? = nil
  @State private var message: String? = nil

  var body: some View {
    VStack {
        if let message = message {
          Text("Received Message: \(message)")
        }
      // WebView to display the website with the generated token
      if let token = token {
        WebView(
            url: "https://coinflip.apps.scrimmage.co/?token=\(token)",
            message: $message
        )
      } else {
        // Loading indicator while fetching the token
        Text("Loading...")
          .onAppear {
            fetchToken()
          }
      }

    }
  }

  func fetchToken() {
    guard let url = URL(string: "https://us-central1-bright-practice-331514.cloudfunctions.net/requestGenerateAuthInfo") else { return }

    URLSession.shared.dataTask(with: url) { data, _, error in
      if let data = data, error == nil {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let token = json["token"] as? String {
          DispatchQueue.main.async {
            self.token = token
          }
        }
      }
    }.resume()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct WebView: UIViewRepresentable {
  let url: String
  @Binding var message: String?

  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    if let url = URL(string: url) {
      webView.load(URLRequest(url: url))
    }
    if #available(iOS 16.4, *) {
      webView.isInspectable = true
    }
    webView.configuration.userContentController.add(context.coordinator, name: "messageHandler")
    return webView
  }

  func updateUIView(_ uiView: WKWebView, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
    var parent: WebView

    init(_ parent: WebView) {
      self.parent = parent
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
      if message.name == "messageHandler", let body = message.body as? String {
        parent.message = body
        print("Received message from WebView: \(body)")
      }
    }
  }
}
