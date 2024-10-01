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
    
    var newstitle: String?
    var imgUrl: String?
    var desc: String?
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        
        if let title = newstitle {
            self.navigationItem.title = title
        }
        
        if let img = imgUrl {
            URLSession.shared.dataTask(with: URL(string: img)!) {data, response, error in
                if let data = try? Data(contentsOf: URL(string: img)!) {
                DispatchQueue.main.async {
                    self.ImageMain.image = UIImage(data: data)
                }
            }}.resume()

        }
        
        if let d = desc {
            self.LabelMain.text = d
        }
        
    }
}
