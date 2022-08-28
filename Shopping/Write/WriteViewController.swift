//
//  WriteViewController.swift
//  Shopping
//
//  Created by Carki on 2022/08/22.
//

import UIKit
import RealmSwift

import FSCalendar

final class WriteViewController: BaseViewController {
    
    let mainView = WriteView()
    let localRealm = try! Realm()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mainView.title.delegate = self
        mainView.todoList.delegate = self
        
        naviSet(title: "쇼핑리스트 작성")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(cancelButton))
        
        
    }
    
    override func configure() {
        mainView.doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
        
        
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

extension WriteViewController: UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

