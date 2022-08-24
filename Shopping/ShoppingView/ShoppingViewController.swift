//
//  ShoppingViewController.swift
//  Shopping
//
//  Created by Carki on 2022/08/22.
//

import UIKit

import RealmSwift
import SnapKit
import Toast

class ShoppingViewController: BaseViewController {
    
    let localRealm = try! Realm()
    
    let tableView: UITableView = {
       let view = UITableView()
        view.backgroundColor = .white
        return view
    }()
    
    var tasks: Results<ShopList>! {
        didSet {
            tableView.reloadData()
            print("Task Changed!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tasks = localRealm.objects(ShopList.self).sorted(byKeyPath: "title", ascending: false)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .white
        naviSet(title: "쇼핑리스트")
        
        // 정렬버튼
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sorButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton]
        sortButton.tintColor = .white
        filterButton.tintColor = .white
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    // MARK: - 정렬버튼, 필터버튼 클릭
    //정렬
    @objc func sorButtonClicked() {
        tasks = localRealm.objects(ShopList.self).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    //필터
    @objc func filterButtonClicked() {
        tasks = localRealm.objects(ShopList.self).filter("title CONTAINS '구매'")
    }
    // MARK: -
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tasks = localRealm.objects(ShopList.self).sorted(byKeyPath: "title", ascending: false)
        tableView.reloadData()
    }
    
    @objc func plusButtonClicked() {
        let vc = WriteViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen //풀스크린 모달방식
        
        self.present(nav, animated: true)

    }
    
    func naviSet(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.barTintColor = .systemMint
        let naviApperance = UINavigationBarAppearance()
        naviApperance.backgroundColor = .systemMint
        navigationController?.navigationBar.standardAppearance = naviApperance
        navigationController?.navigationBar.scrollEdgeAppearance = naviApperance
        
        
    }
    
}

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tasks[indexPath.row].title
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteRow = tasks?[indexPath.row]
            try! localRealm.write {
                localRealm.delete(deleteRow!)
                self.view.makeToast("해당 일정이 삭제되었습니다.")
            }
            tableView.reloadData()
        }
    }
    
    
}
