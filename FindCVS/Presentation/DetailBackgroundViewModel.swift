//
//  DetailBackgroundViewModel.swift
//  FindCVS
//
//  Created by 김영민 on 2022/01/10.
//

import UIKit
import RxSwift
import RxCocoa

struct DetailBackgroundViewModel {
    
    //viewModel -> view
    let isStatusLabelHidden: Signal <Bool>
    
    
    
    //외부에서 전달받을 값
    let shouldHideStatusLabel = PublishSubject<Bool>()
    
    init() {
        isStatusLabelHidden = shouldHideStatusLabel
            .asSignal(onErrorJustReturn: true)
    }
}
