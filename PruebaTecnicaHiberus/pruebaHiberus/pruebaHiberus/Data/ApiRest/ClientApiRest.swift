//
//  ClientApiRest.swift
//  pruebaHiberus
//
//  Created by Jorge Johnson Riffarachy Garrido on 6/1/21.
//
import Alamofire
import AlamofireImage

import Foundation

class ClientApiRest {
    static var manager: Session!
    static func getSessionManager() -> Session {
        if let manag = self.manager {
            return manag
        }
        return Session()
    
    }
    
    /** Call a webservice with POST and token **/
    static func requestTokenExecute(_ url: String, method: HTTPMethod = .post, parameters: Parameters? = [:],
                                                   httpHeaders: [String: String]? = nil,
                                                   success: @escaping (_ response: Data?) -> Void,
                                                   failure: @escaping (_ error: String?) -> Void) {
//        let headers = self.headers(httpHeaders, method: method)
        self.manager = self.getSessionManager()
        self.printJSONString(parameters, url)
        self.manager.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default,
                             headers: nil).responseData(completionHandler: { (response) in
                                if nil == response.error {
                                    if let status = response.response?.statusCode, status == HTTPStatusCode.ok.rawValue {
                                        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                                            debugPrint(url)
                                            debugPrint("RESPONSE: \(utf8Text)")
                                        }
                                        success(response.data)
                                    } else {
                                        let error = ErrorUtil.errorValue(response)
                                        failure(error)
                                    }
                                } else {
                                    if let error = ErrorUtil.errorValue(response) {
                                        failure(error)
                                    } else {
                                        success(nil)
                                    }
                                }
                             })
        
    }
    
    static func printJSONString(_ parameters:[String: Any]?, _ method :String){
        if parameters == nil { debugPrint(method); return}
        if let theJSONData = try? JSONSerialization.data(withJSONObject: parameters!, options: []) {
            let theJSONText = String(data: theJSONData,encoding: .ascii)
            debugPrint("\(method)")
            debugPrint("REQUEST = \(theJSONText!)")
        }
    }
    
    static func request<T:Codable>(_ url:String, method: HTTPMethod = .post,parameters:T,
                                   httpHeaders: [String: String]? = nil,
                                   success : @escaping (_ response: Data?)->Void,
                                   failure : @escaping (_ error : String?)->Void){
//        let headers = self.headers(httpHeaders, method: method)
        self.manager = self.getSessionManager()
        self.manager.request(url, method: method, parameters: parameters, encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: nil).responseData { (response) in
            if response.error == nil {
                if let status = response.response?.statusCode,
                   status == HTTPStatusCode.ok.rawValue {
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        debugPrint(url)
                        debugPrint("RESPONSE: \(utf8Text)")
                    }
                    success(response.data)
                } else {
                    let error = ErrorUtil.errorValue(response)
                    failure(error)
                }
            } else {
                if let error = ErrorUtil.errorValue(response) {
                    failure(error)
                } else {
                    success(nil)
                }
            }
        }
    }
    static func loadImage (_ url:String ){
        self.manager.request(url).responseImage { (response) in
            debugPrint(response)

            print(response.request)
            print(response.response)
            debugPrint(response.result)

            if case .success(let image) = response.result {
                print("image downloaded: \(image)")
            }
        }
//        AF.request(url).responseImage { response in
//            debugPrint(response)
//
//            print(response.request)
//            print(response.response)
//            debugPrint(response.result)
//
//            if case .success(let image) = response.result {
//                print("image downloaded: \(image)")
//            }
//        }
       
        
    }
    /*static private func headers(_ others: [String: String]? = nil, method: HTTPMethod = .post) -> HTTPHeaders {
        var headers: HTTPHeaders = ["OS": "IOS", "App-Credimax": "Credimax-iOS"]
        if HTTPMethod.post == method {
            headers["Content-Type"] = "application/json; charset=utf-8"
            headers["Accept"] = "application/json"
        }
        if let values = others, !values.isEmpty {
            for header in values {
                headers[header.key] = header.value
            }
        }
        return headers
    }*/
    
}
