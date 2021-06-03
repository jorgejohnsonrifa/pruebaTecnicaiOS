//
//  ErrorUtil.swift
//  IOS-Flux
//
//  Created by Alex Cachiguango on 5/3/18.
//  Copyright © 2018 Kruger Corporation. All rights reserved.
//

import Foundation
import Alamofire
class ErrorUtil {
    
    /** Obtiene mensaje de error*/
    static func errorValue (_ value: AFDataResponse<Data>?) -> String? {
        if let response = value?.response {
            let status = response.statusCode
            debugPrint("Error: \(status.description)")
            if let url = response.url {
                debugPrint(url.description)
            }
            return errorCode(status)
        } else if let error = value?.error?.localizedDescription {
            if let request = value?.request {
                debugPrint("Error: \(request.description)")
                debugPrint("\(error)")
                
            }
            let msg = error.replacingOccurrences(of: "URLSessionTask failed with error: ", with: "")
            switch msg {
                case "cancelado", "cancelled":
                    return nil
                case "Se agotó el tiempo de espera.", "The request timed out.":
                    return StringResource.errorServiceUnavailable
                case "Se presentó un error de SSL y no puede establecerse una conexión segura con el servidor.":
                    return StringResource.errorServiceUnavailable
                case "The Internet connection appears to be offline.":
                    return "La conexión a Internet parece estar desactivada."
                case "URLSessionTask failed with error: Could not connect to the server.":
                    return StringResource.errorServiceUnavailable
                default:
                    break
            }
            
            return msg
        }
        return "No se pudo acceder al servidor desde su conexión actual."
    }
    
    static func errorCode(_ code: Int?) -> String? {
        switch code {
            case HTTPStatusCode.ok.rawValue:
                return nil
            case HTTPStatusCode.unauthorized.rawValue, HTTPStatusCode.badRequest.rawValue:
                debugPrint("UNAUTHORIZED")
                return "401"
            case HTTPStatusCode.forbidden.rawValue:
                return "Acceso denegado."
            case HTTPStatusCode.notFound.rawValue:
                return StringResource.errorServiceUnavailable
            case HTTPStatusCode.serviceUnavailable.rawValue:
                return StringResource.errorServiceUnavailable
            case HTTPStatusCode.internalServerError.rawValue:
                debugPrint("INTERNAL SERVER ERROR")
                return "No se pudo obtener los datos."
            case HTTPStatusCode.requestTimeout.rawValue, HTTPStatusCode.gatewayTimeout.rawValue,
                 HTTPStatusCode.badGateway.rawValue:
                return StringResource.errorServiceUnavailable
            default:
                return "No se pudo obtener los datos."
        }
    }
    
    
}
