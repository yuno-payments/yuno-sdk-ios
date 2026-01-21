//
//  HeadlessWebView.swift
//  YunoSwiftUI
//
//  Created by Viviana Amezquita on 11/07/24.
//

import SwiftUI
import WebKit

struct HeadlessWebView: UIViewControllerRepresentable {
    
    let url: String
    
    /// Creates the UIViewController that will be used to display the web view
    /// - Parameter context: The context for the coordinator
    /// - Returns: A configured UIViewController with WKWebView
    func makeUIViewController(context: Context) -> WebViewController {
        return WebViewController(url: url)
    }
    
    /// Updates the UIViewController when SwiftUI state changes
    /// - Parameters:
    ///   - uiViewController: The view controller to update
    ///   - context: The context for the coordinator
    func updateUIViewController(_ uiViewController: WebViewController, context: Context) {
        // No updates needed
    }
}

class WebViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate {
    
    private var webView: WKWebView!
    private var url: String = ""
    private let configuration = WKWebViewConfiguration()
    
    /// Initializes the web view controller with a URL
    /// - Parameter url: The URL to load in the web view
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        webViewConfig()
    }
    
    /// Configures the web view with navigation bar and WKWebView
    func webViewConfig() {
        let navigationBar = UINavigationBar()
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let navItem = UINavigationItem()
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .label
        closeButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        navItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
        navigationBar.items = [navItem]
        
        let webpagePreferences = WKWebpagePreferences()
        webpagePreferences.allowsContentJavaScript = true
        configuration.defaultWebpagePreferences = webpagePreferences
        configuration.userContentController.add(self, name: "messageFromWeb")
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.navigationDelegate = self

        guard let url = URL(string: url) else {
            logger.error("Invalid URL: \(self.url)")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)

        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }

    /// Handles messages received from the web view
    /// - Parameters:
    ///   - userContentController: The user content controller
    ///   - message: The message received from the web view
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "messageFromWeb", let messageBody = message.body as? String {
            logger.info("Message from web: \(messageBody)")
            self.dismiss(animated: true)
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.configuration.userContentController.removeScriptMessageHandler(forName: "messageFromWeb")
    }
}
