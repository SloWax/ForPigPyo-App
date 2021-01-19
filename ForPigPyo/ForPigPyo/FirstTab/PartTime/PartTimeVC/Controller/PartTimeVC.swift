//
//  PartTimeVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/05.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import SnapKit

class PartTimeVC: UIViewController {
    
    static let forkey: String = "PartTimeVC"
    
    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBackground
        
        return imageView
    }()
    lazy var partTimeView: PartTimeView = {
        let view = PartTimeView()
        [view.preButton, view.nexButton].forEach { (button) in
            button.addTarget(self, action: #selector(moveTable(_:)), for: .touchUpInside)
        }
        
        view.historyTable.delegate = self
        view.historyTable.dataSource = self
        view.historyTable.register(PartTimeCustomCell.self, forCellReuseIdentifier: PartTimeCustomCell.identifier)
        
        view.addButton.addTarget(self, action: #selector(addButton(_:)), for: .touchUpInside)
        
        return view
    }()
    private let yearFormat: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        
        return format
    }()
    private let monthFormat: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "MM"
        
        return format
    }()
    
    let model = PartTimeVCModel()
    let myModel = MyPageVCModel()
    var data: PayList?
    
    let tax: [String] = MyPageData.taxCategory
    lazy var taxIndex: Int = myModel.loadTax(forKey: MyPageData.MyPageVCTax) ?? 0
    
    private lazy var yearInt = Int(yearFormat.string(from: Date())) ?? 0
    private lazy var monthInt = Int(monthFormat.string(from: Date())) ?? 0
    var yearIndex: Int = 0
    var monthIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setView()
    }
    
    private func setDateIndex() {
        
        yearIndex = data?.years.lastIndex(where: { $0.year == yearInt}) ?? 0
        monthIndex = data?.years[yearIndex].months.lastIndex(where: { $0.month == monthInt }) ?? 0
    }
    private func setData() {
        
        var firstData: PayList? = PayList(years: [PayList.Year]())
        
        data = model.loadData() ?? model.appendYear(data: &firstData, yearIndex: -1, year: yearInt, month: monthInt)
        setDateIndex()
        
        data = model.checkDataTable(data: &data, yearIndex: yearIndex, monthIndex: monthIndex, yearInt: yearInt, monthInt: monthInt)
        setDateIndex()
    }
    private func setView() {
        
        view.addSubview(backImageView)
        
        backImageView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        partTimeView.setButtonTitle(title: tax[taxIndex])
        partTimeView.taxButton.addTarget(self, action: #selector(changeDeduction(_:)), for: .touchUpInside)
        view.addSubview(partTimeView)
        
        partTimeView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        loadPartTimeValue(deduction: taxIndex % tax.count)
    }
    
    func loadPartTimeValue(deduction: Int) {
        // partTimeView 상단 날짜와 월 예상 급여 set
        let date = data?.years[yearIndex]
        let year = date?.year ?? 0
        let month = date?.months[monthIndex].month ?? 0
        let total = model.setTotalPay(data: data, yearIndex: yearIndex, monthIndex: monthIndex, deduction: deduction)
        
        partTimeView.setValue(year: year, month: month, totalPay: total)
    }
    func presentTimeDataVC(isAdd: Bool, saveIndex: Int) {
        
        let timeDataVC = TimeDataVC()
        
        timeDataVC.data = data
        timeDataVC.yearIndex = yearIndex
        timeDataVC.monthIndex = monthIndex
        timeDataVC.timeDataView.dateView.label1.tag = yearInt
        timeDataVC.timeDataView.dateView.label2.tag = monthInt
        
        switch isAdd {
        case true:
            
            let format: DateFormatter = {
                let format = DateFormatter()
                format.dateFormat = "dd"
                
                return format
            }()
            let hourly = myModel.loadHourly(forKey: MyPageData.myPageVCHourly)
            
            timeDataVC.timeDataView.setValue(title: "근무 추가하기", date: format.string(from: Date()), hourly: hourly, saveIndex: saveIndex, value: nil)
        case false:
            
            timeDataVC.timeDataView.setValue(title: "근무 수정하기", date: nil, hourly: nil, saveIndex: saveIndex, value: data?.years[yearIndex].months[monthIndex].data[saveIndex])
        }
        
        timeDataVC.modalPresentationStyle = .fullScreen
        
        present(timeDataVC, animated: true)
    }
    
    @objc private func addButton(_ sender: UIButton) {
        
        presentTimeDataVC(isAdd: true, saveIndex: 0)
    }
    @objc private func moveTable(_ sender: UIButton) {
        // 년, 월 이동 시 저장된 데이터가 있으면 해당 데이터 load, else return
        switch sender {
        case partTimeView.preButton:
            
            if data?.years[yearIndex].months.startIndex != monthIndex {
                
                monthIndex -= 1
            } else if data?.years[yearIndex].months.startIndex == monthIndex, data?.years.startIndex != yearIndex {
                
                yearIndex -= 1
                monthIndex = (data?.years[yearIndex].months.endIndex ?? 1) - 1
            } else {
                
                return
            }
            
        case partTimeView.nexButton:
            
            if (data?.years[yearIndex].months.endIndex ?? 1) - 1 != monthIndex {
                
                monthIndex += 1
            } else if (data?.years[yearIndex].months.endIndex ?? 1) - 1 == monthIndex, (data?.years.endIndex ?? 1) - 1 != yearIndex {
                
                yearIndex += 1
                monthIndex = data?.years[yearIndex].months.startIndex ?? 0
            } else {
                
                return
            }
            
        default:
            fatalError()
        }
        
        loadPartTimeValue(deduction: taxIndex % tax.count)
        partTimeView.historyTable.reloadData()
    }
    @objc private func changeDeduction(_ sender: UIButton?) {
        // 예상 급여 우측 세금공제 button 터치 시 index를 변경하여 title 변경하고 model에 해당 index 넘겨주어 예상급여 재계산
        taxIndex += 1
        partTimeView.setButtonTitle(title: tax[taxIndex % tax.count])
        
        loadPartTimeValue(deduction: taxIndex % tax.count)
    }
}