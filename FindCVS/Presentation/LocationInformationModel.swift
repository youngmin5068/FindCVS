//
//  LocationInformationModel.swift
//  FindCVS
//
//  Created by 김영민 on 2022/01/10.
//

import Foundation
import RxSwift

struct LocationInformationModel {
    let localNetwork: LocalNetwork
  
    
    init(localNetwork: LocalNetwork = LocalNetwork()){
        self.localNetwork = localNetwork
    }
    
    
    func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData,URLError>> {
        return localNetwork.getLocation(by: mapPoint)
    }
    
    func documentToCellData(_ data: [KLDocument]) -> [DetailListCellData] {
        return data.map {
            let address = $0.roadAddressName.isEmpty ? $0.addressName : $0.roadAddressName
            let point = documentToMTMapPoint($0)
            return DetailListCellData(placeName: $0.placeName, address: address, distance: $0.distance, point: point)
        }
    }
    func documentToMTMapPoint(_ doc: KLDocument) -> MTMapPoint {
        let latitude = Double(doc.x) ?? 0
        let logitude = Double(doc.y) ?? 0
        return MTMapPoint(geoCoord: MTMapPointGeo(latitude: latitude, longitude: logitude))
    }
}
