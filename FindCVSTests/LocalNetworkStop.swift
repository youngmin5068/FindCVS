//
//  LocalNetworkStop.swift
//  FindCVSTests
//
//  Created by 김영민 on 2022/01/11.
//

import Foundation
import RxSwift
import Stubber // 찾아보기

@testable import FindCVS

class LocalNetworkStub: LocalNetwork {
    override func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        return Stubber.invoke(getLocation, args: mapPoint)
    }
}


