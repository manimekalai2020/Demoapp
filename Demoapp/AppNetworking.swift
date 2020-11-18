//
//  AppNetworking.swift
//  Pixalive
//
//  Created by Manish  on 22/07/19.
//  Copyright © 2019 Manish . All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import Photos

typealias JSONDictionary = [String : Any]
typealias JSONDictionaryArray = [JSONDictionary]
typealias HTTPHeaders = [String:String]
typealias SuccessResponse = (_ json : JSON) -> ()
typealias FailureResponse = (Error) -> (Void)
typealias ResponseMessage = (_ message : String) -> ()
typealias DownloadData = (_ data : Data) -> ()
typealias UploadFileParameter = (fileName: String, key: String, data: Data, mimeType: String)

extension Notification.Name {
    static let NotConnectedToInternet = Notification.Name("NotConnectedToInternet")
}

enum AppNetworking {
    
    static var timeOutInterval = TimeInterval(60)
    
    private static func executeRequest(_ request: NSMutableURLRequest, _ success: @escaping (JSON) -> Void, _ failure: @escaping (Error) -> Void) {
        let session = URLSession.shared
        
        session.configuration.timeoutIntervalForRequest = timeOutInterval
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if (error == nil) {
                
                do {
                    if let jsonData = data {
                        
                        if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                            
                            DispatchQueue.main.async(execute: { () -> Void in
                                print(JSON(jsonDataDict))
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
        
        dataTask.resume()
    }
    
    fileprivate static func checkRefereshTokenAndExecute(_ request: NSMutableURLRequest, _ loader: Bool, _ success: @escaping (JSON) -> Void, _ failure: @escaping (Error) -> Void) {
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
    
    private static func REQUEST(withUrl url : URL?,method : String,postData : Data?,header : [String:String],loader : Bool, success : @escaping (JSON) -> Void, failure : @escaping (Error) -> Void) {
        
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
    
    private static func REQUESTWITHJSON(withUrl url : URL?,method : String,postData : Data?,header : [String:String],loader : Bool, success : @escaping (JSON) -> Void, failure : @escaping (Error) -> Void) {
        
        guard let url = url else {
            let error = NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"Url or parameters not valid"])
            failure(error)
            return
        }
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 40.0)
        request.httpMethod = method
        
        let updatedHeaders = header
        
    
        request.allHTTPHeaderFields = updatedHeaders
        
        request.httpBody = postData

        
        checkRefereshTokenAndExecute(request, loader, success, failure)
    }
    
    static func GET(endPoint : String,
                    parameters : [String : Any] = [:],
                    headers : HTTPHeaders = [:],
                    loader : Bool = true,
                    success : @escaping (JSON) -> Void,
                    failure : @escaping (Error) -> Void) {
        
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        print("============ \n URL are =======> \n\n \(endPoint) \n =================")

        guard let urlString = (endPoint + "?" + encodeParamaters(params: parameters)).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else{
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
    
    static func POST(endPoint : String,
                     parameters : [String : Any] = [:],
                     headers : HTTPHeaders = [:],
                     loader : Bool = true,
                     success : @escaping (JSON) -> Void,
                     failure : @escaping (Error) -> Void) {
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        print("============ \n URL are =======> \n\n \(endPoint) \n =================")

        let uri = URL(string: endPoint)
        
        let postData = encodeParamaters(params: parameters).data(using: String.Encoding.utf8)
        if let json = try? JSON(data: postData!) {
                                     print(json)
                                                        
                                
                                      }
        
        REQUEST(withUrl: uri,
                method: "POST",
                postData : postData,
                header: headers,
                loader: loader,
                success: success,
                failure: failure)
        
    }
    static func POST1(endPoint : String,
                        parameters : String,
                        headers : HTTPHeaders = [:],
                        loader : Bool = true,
                        success : @escaping (JSON) -> Void,
                        failure : @escaping (Error) -> Void) {
           
           print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
           print("============ \n URL are =======> \n\n \(endPoint) \n =================")

           let uri = URL(string: endPoint)
           
        let postData = Data(parameters.utf8)
 
           
           REQUEST(withUrl: uri,
                   method: "POST",
                   postData : postData,
                   header: headers,
                   loader: loader,
                   success: success,
                   failure: failure)
           
       }
    static func POSTWITHJSON(endPoint : String,
                     parameters : [String : Any] = [:],
                     headers : HTTPHeaders = [:],
                     loader : Bool = true,
                     success : @escaping (JSON) -> Void,
                     failure : @escaping (Error) -> Void) {
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        print("============ \n URL are =======> \n\n \(endPoint) \n =================")
        
        let uri = URL(string: endPoint)
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        print(postData)
        if let json = try? JSON(data: postData) {
                               print(json)
                                                  
                          
                                }
       
        REQUESTWITHJSON(withUrl: uri,
                method: "POST",
                postData : postData,
                header: headers,
                loader: loader,
                success: success,
                failure: failure)
        
    }
    
    static func POSTWithImage(endPoint : String,
                              parameters : [String : Any] = [:],
                              image : [String : UIImage] = [:],
                              headers : HTTPHeaders = [:],
                              loader : Bool = true,
                              success : @escaping (JSON) -> Void,
                              failure : @escaping (Error) -> Void) {
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        
        let uri = URL(string: endPoint)
        
        let boundary = generateBoundary()
        let postData = createDataBody(withParameters: parameters, media: image, boundary: boundary)
        var updatedHeader = headers
        
        updatedHeader["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
        
        REQUEST(withUrl: uri,
                method: "POST",
                postData : postData,
                header: updatedHeader,
                loader: loader,
                success: success,
                failure: failure)
        
    }
    static func PUT(endPoint : String,
                    parameters : [String : Any] = [:],
                    headers : HTTPHeaders = [:],
                    loader : Bool = true,
                    success : @escaping (JSON) -> Void,
                    failure : @escaping (Error) -> Void) {
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        
        let uri = URL(string: endPoint)
        
        let postData = encodeParamaters(params: parameters).data(using: String.Encoding.utf8)
        
        REQUEST(withUrl: uri,
                method: "PUT",
                postData : postData,
                header: headers,
                loader: loader,
                success: success,
                failure: failure)
        
    }
    
    static func DELETE(endPoint : String,
                       parameters : [String : Any] = [:],
                       headers : HTTPHeaders = [:],
                       loader : Bool = true,
                       success : @escaping (JSON) -> Void,
                       failure : @escaping (Error) -> Void) {
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        
        let uri = URL(string: endPoint)
        
        let postData = encodeParamaters(params: parameters).data(using: String.Encoding.utf8)
        
        REQUEST(withUrl: uri,
                method: "DELETE",
                postData : postData,
                header: headers,
                loader: loader,
                success: success,
                failure: failure)
        
    }
    
    static func encodeParamaters(params : [String : Any]) -> String {
        
        var result = ""
        
        for key in params.keys {
            
            result.append(key+"=\(params[key] ?? "")&")
            
        }
        
        if !result.isEmpty {
            result.remove(at: result.index(before: result.endIndex))
        }
        
        return result
    }
    
    static func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    static func createDataBody(withParameters params: [String:Any]?, media: [String:UIImage]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value)\(lineBreak)")
            }
        }
        
        if let media = media {
            for photo in media.keys {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo)\"; filename=\" image.jpg\"\(lineBreak)")
                body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
                
                let data = media[photo]!.jpegData(compressionQuality: 0.7)
                body.append(data!)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
}


extension Data {
    
    /// Append string to NSMutableData
    ///
    /// Rather than littering my code with calls to `dataUsingEncoding` to convert strings to NSData, and then add that data to the NSMutableData, this wraps it in a nice convenient little extension to NSMutableData. This converts using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `NSMutableData`.
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
