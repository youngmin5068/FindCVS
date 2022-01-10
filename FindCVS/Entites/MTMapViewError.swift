//
//  MTMapViewError.swift
//  FindCVS
//
//  Created by 김영민 on 2022/01/10.
//

import Foundation

enum MTMapViewError: Error {
    case failedUpdatingCurrentLocation
    case locationAUthorizationDenied
    
    var errorDescripton: String {
        switch self {
        case .failedUpdatingCurrentLocation:
            return "현재 위치를 불러오지 못했어요. 잠시 후 다시 시도해주세요."
        case  .locationAUthorizationDenied:
            return "위치 정보를 비활성화하면 사용자의 현재 위츠를 알 수 없습니다."
        }
        
    }
}
