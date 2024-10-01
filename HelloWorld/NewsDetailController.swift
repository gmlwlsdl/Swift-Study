//
//  NewsDetailController.swift
//  HelloWorld
//
//  Created by 희진 on 10/1/24.
//

import UIKit

class NewsDetailController: UIViewController {
    
    @IBOutlet weak var ImageMain: UIImageView!
    @IBOutlet weak var LabelMain: UILabel!
    
    var imgUrl: String?
    var desc: String?
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        
        if let img = imgUrl {
            if let data = try? Data(contentsOf: URL(string: img)!) {
                DispatchQueue.main.async {
                    self.ImageMain.image = UIImage(data: data)
                }
            }
        }
        
        if let d = desc {
            self.LabelMain.text = d
        }
        
         }
}
