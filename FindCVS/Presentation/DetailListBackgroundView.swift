//
//  DetailListBackgroundView.swift
//  FindCVS
//
//  Created by 김영민 on 2022/01/10.
//

import RxSwift
import RxCocoa


class DetailListBackgroundView : UIView {
    let disposeBag = DisposeBag()
    let statusLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func bind(_ viewModel: DetailBackgroundViewModel) {
        viewModel.isStatusLabelHidden
            .emit(to:statusLabel.rx.isHidden)
            .disposed(by: disposeBag )
    }
    
    private func attribute() {
        backgroundColor = .white
        statusLabel.text = "편의점"
        statusLabel.textAlignment = .center
    }
    
    private func layout() {
        addSubview(statusLabel)
        
        statusLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
