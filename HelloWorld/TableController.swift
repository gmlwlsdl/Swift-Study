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
    var currentPage = 1
    var pageSize = 20
    var isLoading = false
    
    func getNews(page: Int, pageSize: Int) {
        guard !isLoading else { return }
        isLoading = true
        
        let task = URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/everything?q=apple&page=\(page)&pageSize=\(pageSize)&from=2024-09-29&to=2024-09-29&sortBy=popularity&apiKey=254cb254ac6845e3813ecb358251a378")!) { (data, response, error) in
            if let dataJson = data {
                
                // json parsing
                do {
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! [String: Any]
                    if let articles = json["articles"] as? [[String: Any]] {
                        
                        // 불필요한 데이터 필터링
                        let filteredArticles = articles.filter {
                            article in
                            if let title = article["title"] as? String {
                                return title != "[Removed]"
                            }
                            return true
                        }
                        
                        if self.newsData == nil {
                            self.newsData = filteredArticles
                        } else {
                            self.newsData?.append(contentsOf: filteredArticles)
                        }
                        
                        DispatchQueue.main.async {
                            self.tableview.reloadData()
                            self.isLoading = false
                        }
                    }
                }
                catch {
                    DispatchQueue.main.async{
                        self.isLoading = false
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            if !isLoading {
                currentPage += 1
                print(currentPage)
                getNews(page: currentPage, pageSize: pageSize)
            }
        }
    }
    
    func sendData(controller: NewsDetailController) {
        if let news = newsData {
            if let indexPath = tableview.indexPathForSelectedRow {
                let row = news[indexPath.row]
                
                if let r = row as? [String : Any] {
                    
                    if let title = r["title"] as? String {
                        controller.title = title
                    }
                    
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
            if let r = row as? [String : Any] {
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
        title = "Apple News"
        
        tableview.dataSource = self
        tableview.delegate = self
        
        getNews(page: currentPage, pageSize: pageSize)
        
         }
}
