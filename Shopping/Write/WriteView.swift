//
//  WriteView.swift
//  Shopping
//
//  Created by Carki on 2022/08/22.
//

import UIKit

import FSCalendar

final class WriteView: BaseView {
    
    let title: WriteTextField = {
        let view = WriteTextField()
        view.placeholder = "제목을 입력해주세요"
        view.textColor = .black
        view.setPlaceholder(color: .black)
        return view
    }()
    
    let todoList: WriteTextField = {
        let view = WriteTextField()
        view.placeholder = "할일을 입력해주세요"
        view.textColor = .black
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
    
    let dateLabel: UILabel = {
        
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        
        let convertDate = dateFormatter.string(from: nowDate)

        let view = UILabel()
        view.text = "선택된 날짜: \(convertDate)"
        view.textColor = .black
        view.textAlignment = .center
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
//    lazy var tapGesture: UITapGestureRecognizer = {
//        let view = UITapGestureRecognizer()
//        view.delegate = self
//        return view
//    }()
    
    lazy var calendar: FSCalendar = {
        let view = FSCalendar()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        view.appearance.selectionColor = .systemMint
        view.appearance.todayColor = .red
        
        
        view.appearance.headerDateFormat = "YYYY년 MM월"
        view.appearance.headerTitleColor = .black
        view.appearance.titleDefaultColor = .black
        view.appearance.titleWeekendColor = .red
        view.locale = Locale(identifier: "ko_KR")
        
//        view.calendarWeekdayView.weekdayLabels[0].text = "일"
//        view.calendarWeekdayView.weekdayLabels[1].text = "월"
//        view.calendarWeekdayView.weekdayLabels[2].text = "화"
//        view.calendarWeekdayView.weekdayLabels[3].text = "수"
//        view.calendarWeekdayView.weekdayLabels[4].text = "목"
//        view.calendarWeekdayView.weekdayLabels[5].text = "금"
//        view.calendarWeekdayView.weekdayLabels[6].text = "토"
        
        
        return view
    }()
    
    override func configureUI() {
        [title, todoList, doneButton, calendar, dateLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        let sideMargin = 20
        
        title.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(safeAreaLayoutGuide).offset(sideMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-sideMargin)
            make.height.equalTo(50)
        }
        
        todoList.snp.makeConstraints { make in
            make.top.equalTo(title).offset(70)
            make.leading.equalTo(safeAreaLayoutGuide).offset(sideMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-sideMargin)
            make.height.equalTo(50)
        }
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(sideMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-sideMargin)
            make.height.equalTo(50)
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(todoList.snp.bottom).offset(40)
            make.leading.equalTo(safeAreaLayoutGuide).offset(sideMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-sideMargin)
            make.bottom.equalTo(dateLabel.snp.top).offset(-40)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(sideMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-sideMargin)
            make.bottom.equalTo(doneButton.snp.top).offset(-40)
            make.height.equalTo(50)
        }
    }
}

extension WriteView: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let nowDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        
        let convertDate = dateFormatter.string(from: nowDate)

        dateLabel.text = "선택된 날짜: \(convertDate)"
        
        print(date)
    }
    
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        // 날짜 3개까지만 선택되도록
        if calendar.selectedDates.count > 2 {
            return false
        } else {
            return true
        }
    }
    
    //선택해제
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false // 선택해제 불가능
        //return true // 선택해제 가능
    }
        
}
