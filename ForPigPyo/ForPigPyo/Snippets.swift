// 사용법
// 1. mark 단위로 드래그 후 snippet 추가
// 2. completion 에 기호에 맞는 keyword 로 설정



    // MARK: - UIViewController
/*
import UIKit
import RxSwift
import RxCocoa
import RxOptional
 

class <#ClassName#>: BaseVC {
    private let <#ViewName#> = <#View#>()
    private var vm: <#ViewModel!#>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    private func setInputs() -> <#ViewModel#> {
        let inputs = <#ViewModel.inputs#>
        
        return <#ViewModel#>(inputs)
    }
    
    private func initialize() {
        vm = setInputs()
    }
    
    private func bind() {
        
    }
}
*/



    // MARK: - ViewModel
/*
import Foundation
import RxSwift
import RxCocoa


class <#ViewModel#>: BaseVM {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    let input: Input
    let output: Output
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        super.init()
        
    }
}
*/



    // MARK: - UIView
/*
import UIKit
import SnapKit
import Then


class <#ClassName#>: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        
    }
    
    private func setLayout() {
        
    }
}
*/


 
    // MARK: - UITableViewCell
/*
import UIKit

class <#ClassName#>: UITableViewCell {
    static let id: String = "\(String(describing: self))"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUP()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValue(_ value: <#Model#>) {
        
    }
    
    private func setUP() {
        
    }
    
    private func setLayout() {
        
    }
}
*/



    // MARK: - UICollectionViewCell
/*
import UIKit

class <#ClassName#>: UICollectionViewCell {
    static let id: String = "\(String(describing: self))"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValue(_ value: <#Model#>) {
        
    }
    
    private func setUP() {
        
    }
    
    private func setLayout() {
        
    }
}
*/
