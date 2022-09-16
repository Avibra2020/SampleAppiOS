//
//  ViewController.swift
//  SampleApps
//
//  Created by Tushar Sarkar on 15/09/22.
//

import UIKit
import WebKit
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
        }
    }
    
    
}

