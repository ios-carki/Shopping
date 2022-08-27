//
//  WriteViewController.swift
//  Shopping
//
//  Created by Carki on 2022/08/22.
//

import UIKit
import RealmSwift

final class EditWriteViewController: BaseViewController {
    
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
        
        //상세페이지
        let task = localRealm.objects(ShopList.self).where { $0.objectId == id! }.first
        var edittedTitle = mainView.title.text
        var edittedTodoList = mainView.todoList.text
        
//        edittedTitle = task?.title
//        edittedTodoList = task?.todoList
//
        let editTask = ShopList(title: edittedTitle!, todoList: edittedTodoList!, regDate: Date())
        try! localRealm.write({
            localRealm.add(editTask)
            print("Realm Succed!")
        })
        
//        let taskToUpdate = tasks[indexPath.row]
//
//        try! localRealm.write {
//            taskToUpdate.content = "수정한 내용"
//            taskToUpdate.diaryTitle = "수정한 제목"
//            tableView.reloadData()
//        }
        
//        let task = ShopList(title: mainView.title.text!, todoList: mainView.todoList.text!, imageURL: nil)
//        try! localRealm.write({
//            localRealm.add(task)
//            print("Realm Succeed!")
//            dismiss(animated: true)
//        })
    }
    
    override func configure() {
        mainView.doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
            
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        mainView.addGestureRecognizer(tapGestureRecognizer)
    }
        
    //텝 제스쳐
    @objc func tapGesture() {
        view.endEditing(true)
    }
    
    @objc func doneButtonClicked() {
        let task = ShopList(title: mainView.title.text!, todoList: mainView.todoList.text!, regDate: Date())
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
