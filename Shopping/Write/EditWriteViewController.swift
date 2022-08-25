//
//  WriteViewController.swift
//  Shopping
//
//  Created by Carki on 2022/08/22.
//

import UIKit
import RealmSwift

class EditWriteViewController: BaseViewController {
    
    let mainView = WriteView()
    //var mainView:WriteView?
    let localRealm = try! Realm()
    
    var id: ObjectId?
    
    
    override func loadView() {
        self.view = mainView
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        naviSet(title: "쇼핑리스트 수정")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(cancelButton))
        
        let task = localRealm.objects(ShopList.self).where { $0.objectId == id!}.first
        mainView.title.text = task?.title
        mainView.todoList.text = task?.todoList
    }
    
    override func configure() {
        mainView.doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func doneButtonClicked() {
        let task = ShopList(title: mainView.title.text!, todoList: mainView.todoList.text!)
        try! localRealm.write({
            localRealm.add(task)
            print("Realm Succeed!")
            dismiss(animated: true)
        })
    }
    
    func naviSet(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.barTintColor = .systemMint
        
        let naviApperance = UINavigationBarAppearance()
        naviApperance.backgroundColor = .systemMint
        navigationController?.navigationBar.standardAppearance = naviApperance
        navigationController?.navigationBar.scrollEdgeAppearance = naviApperance
    }
    
    @objc func cancelButton() {
        dismiss(animated: true)
    }
}
