//
//  ViewController.swift
//  AwesomeBrowser
//
//  Created by Gor Grigoryan on 10/21/19.
//  Copyright © 2019 Gor Grigoryan. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        urlTextField.delegate = self
        webView.navigationDelegate = self
        
        let homePage = "https://www.apple.com/"
        let url = URL(string: homePage)
        let request = URLRequest(url: url!)
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        
        urlTextField.text = homePage
    }


    @IBAction func backButtonTapped(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forwardButtonTapped(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = textField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        urlTextField.text = webView.url?.absoluteString
        
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}
