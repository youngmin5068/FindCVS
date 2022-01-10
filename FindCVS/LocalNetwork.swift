//
//  LocalNetwork.swift
//  FindCVS
//
//  Created by 김영민 on 2022/01/10.
//

import RxSwift

class LocalNetwork {
    private let session : URLSession
    let api = LocalAPI()
    
    init(session: URLSession = .shared){
        self.session = session
    }
    
    func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData,URLError>> {
        guard let url = api.getLocation(by: mapPoint).url else {
            return .just(.failure(URLError(.badURL)))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK 1d04c42b9cd9c011aac09bfaeabc989a", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request as URLRequest)
            .map{ data in
                do {
                    let locationData = try JSONDecoder().decode(LocationData.self,from: data)
                    return .success(locationData)
                }catch {
                    return .failure(URLError(.cannotParseResponse))
                }
            }
            .catch{_ in .just(Result.failure(URLError(.cannotLoadFromNetwork)))}
            .asSingle()
    }
}
