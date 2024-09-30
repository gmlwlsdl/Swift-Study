//
//  ViewController.swift
//  HelloWorld
//
//  Created by 희진 on 9/30/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func clickmove(_ sender: Any) {
        
        // storyboard에서 컨트롤러 찾기
        // optional binding
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailController") {
            
            // 컨트롤러로 이동하기
            self.navigationController?.pushViewController(controller, animated: true)

        }
        
        
    }
    
    @IBAction func movetable(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "TableController"){
            
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

