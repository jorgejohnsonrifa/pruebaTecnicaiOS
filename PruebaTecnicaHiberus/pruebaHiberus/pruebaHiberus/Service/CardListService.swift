//
//  CardListService.swift
//  pruebaHiberus
//
//  Created by Jorge Johnson Riffarachy Garrido on 6/2/21.
//

import Foundation

class CardListService {
    
    func getCardList(_ callback: @escaping (_ response: CardResponse?, _ error: String?) -> Void) {
        
        let url = "https://api.magicthegathering.io/v1/cards"
        ClientApiRest.requestTokenExecute(url, method: .get, parameters: nil, httpHeaders: nil) { (response) in
            if let jsonResponse = JsonUtil.decode(response, myStruct: CardResponse.self) as? CardResponse {
                callback(jsonResponse, nil)
            } else {
                callback(nil,"No existen datos para mostrar")
            }
        } failure: { (error) in
            callback(nil,error)
        }
    }
    
}
