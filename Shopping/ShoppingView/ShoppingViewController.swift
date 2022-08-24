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
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton]
        sortButton.tintColor = .white
        filterButton.tintColor = .white
        
       
        
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    // MARK: - 정렬버튼, 필터버튼 클릭
    //정렬버튼 -> 액션시트
    @objc func sortButtonClicked() {
        //액션시트
        let sortActionSheet = UIAlertController(title: "정렬기준", message: nil, preferredStyle: .actionSheet)
        let actionName = UIAlertAction(title: "이름순", style: .default) { UIAlertAction in
            self.nameSortButtonClicked()
        }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        sortActionSheet.addAction(actionName)
        sortActionSheet.addAction(cancelButton)
        
        self.present(sortActionSheet, animated: true)
    }
    
    func nameSortButtonClicked() {
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
    
    func fatchRealm() {
        tasks = localRealm.objects(ShopList.self).sorted(byKeyPath: "title", ascending: true)
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
        if tasks[indexPath.row].favorite {
            cell.imageView?.image = UIImage(systemName: "star.fill")
        } else {
            cell.imageView?.image = UIImage(systemName: "star")
        }
        cell.imageView?.tintColor = .black
        
        
        return cell
    }
    
    // MARK: - 2022.08.24
    //셀 삭제
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
    
    //즐겨찾기
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            
            //realm data update
            try! self.localRealm.write {
                //하나의 레코드에서 특정 컬럼 하나만 변경
                self.tasks[indexPath.row].favorite = !self.tasks[indexPath.row].favorite
                
                print("realm upddate succeed, reloadRows 필요")
            }
            
            //1. 스와이프한 셀 하나만 reloadrows구현
            //2. 데이터가 변경됐으니 다시 realm에서 데이터를 가지고오기 => didset 일관적 형태로 갱신
            self.fatchRealm()
        }
        
        //realm 데이터 기준
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star" //즐겨찾기 등록여부
        favorite.image = UIImage(systemName: image)
        
//        if favorite.image == UIImage(systemName: "star.fill") {
//            let string = tasks[indexPath.row].diaryTitle
//            let attribute = [NSAttributedString.Key.backgroundColor: UIColor.red]
//            string.att
//        }
        favorite.backgroundColor = .systemMint
        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    
}
