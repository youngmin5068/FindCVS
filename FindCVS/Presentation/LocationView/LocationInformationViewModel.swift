//
//  LocationInformationViewModel.swift
//  FindCVS
//
//  Created by 김영민 on 2022/01/10.
//


import UIKit
import RxSwift
import RxCocoa

struct LocationInformationViewModel {
    let disposeBag = DisposeBag()
    
    //subViewModels
    let detailListBackgroundViewModel = DetailBackgroundViewModel()
    
    //viewModel -> view
    
    let setMapCenter: Signal<MTMapPoint>
    let errorMessage: Signal<String>
    let detailListCellData : Driver<[DetailListCellData]>
    let scrollToSelectedLocation: Signal<Int>
    
    //view -> viewModel
    
    let currentLocation = PublishRelay<MTMapPoint>()
    let mapCenterPoint = PublishRelay<MTMapPoint>()
    let selectPOIItem = PublishRelay<MTMapPOIItem>()
    let mapViewError = PublishRelay<String>()
    let currentLocationButtonTapped = PublishRelay<Void>()
    let detailListItemSelected = PublishRelay<Int>()
    
    private let documentData = PublishSubject<[KLDocument]>()
    
    
    init(model: LocationInformationModel = LocationInformationModel()) {
        //MARK: 네트워크 통신으로 데이터 불러오기
        
        let cvsLocationDataResult = mapCenterPoint
            .flatMapLatest(model.getLocation)
            .share()
        
        let cvsLocationDataValue = cvsLocationDataResult
            .compactMap{ data -> LocationData? in
                guard case let .success(value) = data else {
                    return nil
                }
                return value
            }
        let cvsLocationDataErrorMessage = cvsLocationDataResult
            .compactMap{ data -> String? in
                switch data {
                case let .success(data) where data.documents.isEmpty:
                    return """
                        500m 근처에 이용할 수 있는 편의점이 없어요.
                        지도 위치를 옮겨서 재검색해주세요.
                        """
                case let .failure(error):
                    return error.localizedDescription
                default:
                    return nil
                }
            }
        
        cvsLocationDataValue
            .map{ $0.documents}
            .bind(to:documentData)
            .disposed(by: disposeBag)
        
        
        
        //MARK: 지도 중심점 설정
        
        //TableView의 편의점 리스트 중 하나 고름
        let selectDetailListItem = detailListItemSelected
            .withLatestFrom(documentData) { $1[$0] }
            .map(model.documentToMTMapPoint)
        //-> 이해 완료
        
        
        let moveToCurrentLocation = currentLocationButtonTapped
            .withLatestFrom(currentLocation)
        //currentLocation을 받은 이후에 현재 위치로 이동할 수 있음
        //withLatestFrom()은 괄호 안의 값이 나온 이후에 currentLocationButtonTapped이 실행 되도록 함
        
        let currentMapCenter = Observable
            .merge(
                selectDetailListItem,
                currentLocation.take(1),
                moveToCurrentLocation
            )
        
        setMapCenter = currentMapCenter
            .asSignal(onErrorSignalWith: .empty())
        
        errorMessage = Observable
            .merge(
                cvsLocationDataErrorMessage,
                mapViewError.asObservable()
            )
            .asSignal(onErrorJustReturn: "잠시 후 다시 시도해주세요")
        
        detailListCellData = documentData
            .map(model.documentToCellData)
            .asDriver(onErrorDriveWith: .empty())
        
        documentData
            .map{ !$0.isEmpty }
            .bind(to: detailListBackgroundViewModel.shouldHideStatusLabel)
            .disposed(by: disposeBag)
        
        scrollToSelectedLocation = selectPOIItem
            .map{$0.tag}
            .asSignal(onErrorJustReturn: 0)
    }
}
