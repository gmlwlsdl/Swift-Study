//
//  CollectionViewController.swift
//  HelloWorld
//
//  Created by 희진 on 10/1/24.
//

import UIKit

struct Category {
    let name: String
    let image: String
}

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let categories = [
        Category(name: "Business", image: "https://cdn.pixabay.com/photo/2018/01/15/20/38/city-3084746_1280.jpg"),
        Category(name: "Science", image: "https://cdn.pixabay.com/photo/2018/02/16/11/05/trace-3157431_1280.jpg"),
        Category(name: "Sports", image: "https://cdn.pixabay.com/photo/2017/08/07/23/50/climbing-2609319_1280.jpg"),
        Category(name: "Finance", image: "https://cdn.pixabay.com/photo/2017/08/10/08/28/money-2619993_1280.jpg"),
        Category(name: "Politics", image: "https://cdn.pixabay.com/photo/2017/08/03/11/05/people-2575608_1280.jpg")
    ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = categories[indexPath.row]
        
        cell.LabelView.text = category.name
        cell.ImageView.image = nil
        
        if let imgUrl = URL(string: category.image) {
            URLSession.shared.dataTask(with: imgUrl) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if let currentIndexPath = collectionView.indexPath(for: cell), currentIndexPath == indexPath {
                            cell.ImageView.image = image
                        }
                    }
                }
            }.resume()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        print("\(category.name) selected")
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let rowCount:CGFloat = 2
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (rowCount - 1)
        let padding = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let adjustSize = collectionViewWidth - spaceBetweenCells - padding
        let cellWidth = floor(adjustSize / rowCount)
        let cellHeight:CGFloat = 100
        
        return CGSize(width: cellWidth, height: cellHeight)
    }

}
