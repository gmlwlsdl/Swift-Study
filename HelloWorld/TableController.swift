//
//  TableController.swift
//  HelloWorld
//
//  Created by 희진 on 9/30/24.
//
import UIKit

class TableController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 몇개?
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 무엇? 반복하지 않을까 (위의 수만큼)
        // 셀 만들기는 2가지 방법이 있음
        
        // 방법 1. 임의의 셀 만들기 > 연습
        
        // let cell = UITableViewCell.init(style: .default, reuseIdentifier: "TableCellType1")
        // cell.textLabel?.text = "\(indexPath.row)"
        
        // 방법 2. 스토리보드 + id > 실전
        // as? as! - 부모 자식 친자확인
        let cell = tableView.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        
        cell.label?.text = "\(indexPath.row)"
        
        return cell
        
    }
    
    // 클릭
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) 번째 셀 클릭")
    }
    
    // 정갈하게 데이터를 보여주기 위함 ex) 전화번호부
    // 1. 데이터가 무엇인지
    // 2. 데이터가 몇 개인지
    // (옵션) 3. 행 눌렀을 때 액션
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        
         }
}
