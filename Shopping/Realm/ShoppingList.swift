//
//  ShoppingList.swift
//  Shopping
//
//  Created by Carki on 2022/08/22.
//

import Foundation
import RealmSwift

class ShopList: Object {
    @Persisted var title: String //제목(필수)
    //@Persisted var content: String? //내용(옵션)
    //@Persisted var addDate = Date() //작성 날짜(필수)
    //@Persisted var regDate = Date() //등록 날짜(필수)
    @Persisted var favorite: Bool //즐겨찾기(필수)
    @Persisted var imageExist: Bool //사진 URLString(옵션)
    @Persisted var todoList: String //할 일 목록
    
    //1.이미지가 있는지 없는지
    //2.이미지여부 -> Bool타입
    //3.이미지 파일 저장할 URL
    
    //PK(필수): Int, String, UUID(권장), ObjectID(권장)
    @Persisted(primaryKey: true) var objectId: ObjectId

    convenience init(title: String, todoList: String) {
        self.init()
        self.title = title
        self.todoList = todoList
        self.favorite = false
        self.imageExist = false
    }
}
