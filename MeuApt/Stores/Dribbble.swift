//
//  Dribbble.swift
//  MeuApt
//
//  Created by mac mini capgemini sp on 13/11/17.
//  Copyright © 2017 Domene. All rights reserved.
//

import Foundation
import Alamofire

class Dribble{
    static let sharedInstance = Dribble()
    private let baseUrl = "https://api.dribbble.com/v1"
    private let accessToken = "5452fcb062e021e062102ae94e15f3a6b5c728c8d9af2a5cb16a411c49bad99c"
    private let perPage = 30
    
    private init(){} //Prevents from creating an instance
    
    private func handleError(_ statusCode: Int?) -> CustomError?{
        var error : CustomError?
        if let status = statusCode, status != 200, status != 201 {
            if (status == 404){
                error = CustomError.notFound
            }else if(status == 500){
                error = CustomError.serverError
            }else{
                error = CustomError.undefined
            }
        }
        return error
    }
    
    public func getShots(page: Int, completion: @escaping(CustomError?, String?)->Void){
        let path = "/shots?page=\(page)&per_page=\(perPage)&access_token=\(accessToken)"
        let url = baseUrl+path
        
        Alamofire.request(url).responseJSON { response in
            print("\nRequest: \(String(describing: response.request))")   // original url request
            
            if let error = self.handleError(response.response?.statusCode){
                print("\nDebug: \(String(describing: response.response))")
                completion(error, nil)
            }
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                return completion(nil, "json")
            }
        }
        
    }
}
