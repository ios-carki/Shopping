//
//  WriteView.swift
//  Shopping
//
//  Created by Carki on 2022/08/22.
//

import UIKit

class WriteView: BaseView {
    
    let title: WriteTextField = {
        let view = WriteTextField()
        view.placeholder = "제목을 입력해주세요"
        view.setPlaceholder(color: .black)
        return view
    }()
    
    let todoList: WriteTextField = {
        let view = WriteTextField()
        view.placeholder = "할일을 입력해주세요"
        view.setPlaceholder(color: .black)
        return view
    }()
    
    let doneButton: UIButton = {
        let view = UIButton()
        view.setTitle("완료", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 20, weight: .heavy)
        view.setTitleColor(UIColor.white, for: .normal)
        view.backgroundColor = .systemMint
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    override func configureUI() {
        [title, todoList, doneButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        title.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
        
        todoList.snp.makeConstraints { make in
            make.top.equalTo(title).offset(70)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(150)
        }
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
    }
}
