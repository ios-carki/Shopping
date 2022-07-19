//
//  ShoppingTableViewController.swift
//  Shopping
//
//  Created by Carki on 2022/07/19.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    
    @IBOutlet weak var userTextField: UITextField!
    
    var shoppingList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //섹션의 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //셀의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppedTableViewCell") as! ShoppedTableViewCell
        
        cell.shopedLabel.text = shoppingList[indexPath.row]
        cell.shopedLabel.font = .boldSystemFont(ofSize: 18) //15 > 13
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            return 400
        }else {
            return 44
        }
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        shoppingList.append(userTextField.text!)
    }
    
}
