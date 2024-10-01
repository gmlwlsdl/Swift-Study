//
//  TableController.swift
//  HelloWorld
//
//  Created by 희진 on 9/30/24.
//

import UIKit

class TableController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    var newsData :Array<Dictionary<String, Any>>?
    
    func getNews() {
        let task = URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/everything?q=apple&from=2024-09-29&to=2024-09-29&sortBy=popularity&apiKey=254cb254ac6845e3813ecb358251a378")!) { (data, response, error) in
            if let dataJson = data {
                
                // json parsing
                do {
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
                    let articles = json["articles"] as! Array<Dictionary<String, Any>>
                     
                    // 불필요한 데이터 필터링
                    self.newsData = articles.filter {
                        article in
                        if let title = article["title"] as? String {
                            return title != "[Removed]"
                        }
                        return true
                    }
                    
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                }
                catch {}
            }
        }
        
        task.resume()
    }
    
    func sendData(controller: NewsDetailController) {
        if let news = newsData {
            if let indexPath = tableview.indexPathForSelectedRow {
                let row = news[indexPath.row]
                
                if let r = row as? Dictionary<String, Any> {
                    
                    if let imgUrl = r["urlToImage"] as? String {
                        controller.imgUrl = imgUrl
                    }
                
                    if let desc = r["description"] as? String {
                        controller.desc = desc
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let news = newsData{
            return news.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        
        let idx = indexPath.row
        if let news = newsData {
            
            let row = news[idx]
            if let r = row as? Dictionary<String, Any> {
                if let title = r["title"]{
                    cell.label?.text = title as? String
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NewsDetailController") as! NewsDetailController
        
        sendData(controller: controller)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == "NewsDetail" {
            if let controller = segue.destination as? NewsDetailController {
                sendData(controller: controller)
            }
        } 
    }
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        
        getNews()
        
         }
}
