//
//  ViewController.swift
//  SampleApps
//
//  Created by Tushar Sarkar on 15/09/22.
//

import UIKit
import WebKit
import MessageUI
import SafariServices

class ViewController: UIViewController, WKNavigationDelegate, SFSafariViewControllerDelegate {

    @IBOutlet weak var txtEnterUrl: UITextField!
    @IBOutlet weak var wkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wkWebView.navigationDelegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func onWebViewBtnPressed() {
        let urlStr : String = txtEnterUrl.text ?? "";
        guard let url = URL(string: urlStr) else { return }
        wkWebView.load(URLRequest(url: url))
    }
    
    @IBAction func onSafariViewBtnPressed() {
        launchSafariVC(urlString: txtEnterUrl.text!);
    }
    
    func launchSafariVC (urlString: String) {
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController.init(url: url)
            vc.delegate = self

            present(vc, animated: true)
        }
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard
                let url = navigationAction.request.url else {
                    decisionHandler(.cancel)
                    return
            }
            
            let string = url.absoluteString
            if (string.contains("mailto:")) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                decisionHandler(.cancel)
                return
            } else if (string.contains("https://avibra.app.link") || string.contains("https://avibra.test-app.link") || string.contains("https://avibra-alternate.test-app.link") || string.contains("https://avibra-alternate.app.link")) {
                if (UIApplication.shared.canOpenURL(url)) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                decisionHandler(.cancel)
            } else if (string.contains("https://apps.apple.com/us/app/avibra/id1449843334")) {
                if (UIApplication.shared.canOpenURL(url)) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                decisionHandler(.cancel)
            } else if (string.contains("https://apps.apple.com/us/app/avibra/id1449843334")) {
                let itunesURL = URL(string: "itms-apps://itunes.apple.com/app/id1449843334") ?? url;
                if (UIApplication.shared.canOpenURL(url)) {
                    UIApplication.shared.open(itunesURL, options: [:], completionHandler: nil)
                }
                decisionHandler(.cancel)
            }
            decisionHandler(.allow)
        }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Error",error);
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let url : URL = webView.url ?? URL(string: "")!
        let urlStr : String  = url.absoluteString
        if (urlStr.hasPrefix("https://avibra.app.link") || urlStr.hasPrefix("https://avibra.test-app.link")) {
            if (UIApplication.shared.canOpenURL(url)) {
                UIApplication.shared.open(url)
            }
            webView.goBack();
        } else if (urlStr.hasPrefix("https://avibra-alternate.test-app.link") || urlStr.hasPrefix("https://avibra-alternate.app.link")) {
            if (UIApplication.shared.canOpenURL(url)) {
                UIApplication.shared.open(url)
            }
        } else if (urlStr.hasPrefix("https://apps.apple.com/us/app/avibra/id1449843334")) {
            if let url = URL(string: "itms-apps://itunes.apple.com/app/id1449843334") {
                UIApplication.shared.open(url)
            }
        } else if (urlStr.hasPrefix("mailto:")) {
            let mc: MFMailComposeViewController = MFMailComposeViewController();
            self.present(mc, animated: true);
        }
    }
    
    
}

