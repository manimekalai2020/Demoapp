//
//  SearchNetworkingClass.swift
//  Pixalive
//
//  Created by Mohd Sultan on 03/04/20.
//  Copyright © 2020 Manish . All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class SearchNetworkingClass{
    
    static var shared = SearchNetworkingClass()
    
    var timeOutInterval = TimeInterval(60)
    var dataTask: URLSessionTask?
    
    private init(){}
    
    
    private func executeRequest(_ request: NSMutableURLRequest, _ success: @escaping (JSON) -> Void, _ failure: @escaping (Error) -> Void) {
        let session = URLSession.shared
        
        session.configuration.timeoutIntervalForRequest = timeOutInterval
        
         dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if (error == nil) {
                
                do {
                    if let jsonData = data {
                        
                        if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                            
                            DispatchQueue.main.async(execute: { () -> Void in
                                
                                success(JSON(jsonDataDict))
                            })
                        }
                        
                    }else{
                        let error = NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"No data found"])
                        failure(error)
                    }
                } catch let err as NSError {
                    
                    let responseString = String(data: data!, encoding: .utf8)
                    print("responseString = \(responseString ?? "")")
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        failure(err)
                    })
                }
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse)
                }
                if let err = error {
                    DispatchQueue.main.async(execute: { () -> Void in
                        failure(err)
                    })
                }else{
                    let error = NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"Something went wrong"])
                    failure(error)
                }
            }
        })
        
        dataTask?.resume()
    }
    
    fileprivate func checkRefereshTokenAndExecute(_ request: NSMutableURLRequest, _ loader: Bool, _ success: @escaping (JSON) -> Void, _ failure: @escaping (Error) -> Void) {
        executeRequest(request, { (json) in
            let code = json[ApiKey.code].intValue
            if code == 499{
                AppUserDefaults.removeAllValues()
                let vc = PreLoginVC.instantiate(fromAppStoryboard: .Main)
                if let navigation = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController{
                    navigation.pushViewController(vc, animated: true)
                }
                
            }else{
                success(json)
            }
            
        }) { (err) in
            if let url = request.url{
                if NetworkReachabilityManager(host: "\(url)")?.isReachable == false{
                    CommonFunctions.showToastWithMessage("You are not connected with internet", controller: UIApplication.shared.keyWindow?.rootViewController ?? UIViewController())
                }
            }
            
            failure(err)
        }
    }
    
    private func REQUEST(withUrl url : URL?,method : String,postData : Data?,header : [String:String],loader : Bool, success : @escaping (JSON) -> Void, failure : @escaping (Error) -> Void) {
        
        guard let url = url else {
            let error = NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"Url or parameters not valid"])
            failure(error)
            return
        }
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 60.0)
        request.httpMethod = method
        
        let updatedHeaders = header
        
        
        
        request.allHTTPHeaderFields = updatedHeaders
        
        request.httpBody = postData
        
        checkRefereshTokenAndExecute(request, loader, success, failure)
    }
    
    func GET(endPoint : String,
                       parameters : [String : Any] = [:],
                       headers : HTTPHeaders = [:],
                       loader : Bool = true,
                       success : @escaping (JSON) -> Void,
                       failure : @escaping (Error) -> Void) {
           
           
           print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
           print("============ \n URL are =======> \n\n \(endPoint) \n =================")

        guard let urlString = (endPoint + "?" + AppNetworking.encodeParamaters(params: parameters)).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else{
               return
           }
           
           let uri = URL(string: urlString)
           
           REQUEST(withUrl: uri,
                   method: "GET",
                   postData : nil,
                   header: headers,
                   loader: loader,
                   success: success,
                   failure: failure)
           
       }
    
     func searchGetAPI(parameters: JSONDictionary,
                       endPoint: WebServices.EndPoint,
                             loader: Bool = true,
                             success : @escaping SuccessResponse,
                             failure : @escaping FailureResponse) {
        
        let user = "pixalive"
        let password = "DAF87DSFDSFDSA98FSADKJE324KJL32HFD7FDSFB24343J49DSF"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)", "access_token": "Bearer \(AppUserDefaults.value(forKey: .accesstoken).stringValue)"]
        
        
        GET(endPoint: endPoint.path, parameters: parameters, headers: headers, loader: loader, success: { (json) in
            let code = json[ApiKey.code].intValue
            let msg = json[ApiKey.message].stringValue
            switch code {
            case ApiCode.success: success(json)
            default: failure(NSError(code: code, localizedDescription: msg))
            }
        }) { (error) in
            failure(error)
        }
    }
}
