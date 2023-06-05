import SwiftUI
import WebKit

struct ContentView: View {
    @State private var token: String? = nil
    
    var body: some View {
        VStack {
            // WebView to display the website with the generated token
            if let token = token {
                            WebView(url: "https://coinflip.apps.scrimmage.co/?token=\(token)")
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

            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }

                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let token = json["token"] as? String {
                    DispatchQueue.main.async {
                        self.token = token
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

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
