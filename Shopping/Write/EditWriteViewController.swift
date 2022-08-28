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
    //데이터베이스 데이터 업데이트
//    try? localRealm.write {
//        localRealm.add(data, update:.modified)
//    }
    
    var id: ObjectId?
    var receiveTitle: String?
    var receiveTodoList: String?
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //받아온 데이터 데이터 수정뷰에 보여주기
        mainView.title.text = receiveTitle
        mainView.todoList.text = receiveTodoList
        
        naviSet(title: "쇼핑리스트 수정")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(cancelButton))
        
        //상세페이지
        let task = localRealm.objects(ShopList.self).where { $0.objectId == id! }.first
        
        
//        task?.title = mainView.title.text!
//        task?.todoList = mainView.todoList.text!
        
        //받아온 데이터를 여기서 보여주고 수정하기
        //수정뷰에서 작성한 내용을 램 데이터에 저장하기
        try! localRealm.write {
//            let task = localRealm.objects(ShopList.self).where { $0.objectId == id!}.first
            task?.title = mainView.title.text!
            task?.todoList = mainView.todoList.text!
            print("Realm Success load Data!")

            //업데이트
//            let updateRealm = ShopList(value: ["objectId": id, "title": mainView.title.text, "todoList": mainView.todoList.text])
//            localRealm.create(ShopList.self, value: ["objectId": id, "title": mainView.title.text, "todoList": mainView.todoList.text], update: .modified)
        }
        
        try! localRealm.write {
            localRealm.create(ShopList.self, value: ["objectId": id, "title": mainView.title.text, "todoList": mainView.todoList.text], update: .modified)
            print("Realm Update Success")
        }
        
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
