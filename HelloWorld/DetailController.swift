//
//  DetailController.swift
//  HelloWorld
//
//  Created by 희진 on 9/30/24.
//

import UIKit
import WebKit

class DetailController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // url 주소 찾기 > request로 > 보이기
        let urlString = "https://www.google.com"
        if let url = URL(string: urlString) { // unwrap
            let urlReq = URLRequest(url: url)
            webview.load(urlReq)
        }
    }
    
}
