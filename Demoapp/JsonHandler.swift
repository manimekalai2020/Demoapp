//
//  JsonHandler.swift
//  SmartSuperMarket
//
//  Created by Bala Mac on 09/08/18.
//  Copyright © 2018 Smarther. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SystemConfiguration
import SVProgressHUD

class JsonHandler: NSObject {
      static func StartRequest3(_ strURL : String,method:HTTPMethod, params : [String: AnyObject], headers : [String : String]?,ShowIt:Bool,setview:UIView, success:@escaping (JSON) -> Void,EmptyData:@escaping (String) -> Void, failure:@escaping (Error) -> Void)
        {
            if Reachability.isConnectedToNetwork(){
                
                
                let manager = Alamofire.SessionManager.default
                manager.session.configuration.timeoutIntervalForRequest = 120
                print(strURL)
                print(headers)

                 print("paramssassssssssss", params)
                
                  manager.request(strURL, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
                    
                    if responseObject.result.isSuccess {
                        
                    
                        let resJson = JSON(responseObject.result.value!)
                        
                        print(resJson["statusCode"].intValue)
                        
                        if resJson["statusCode"].intValue == 200 ||  resJson["statusCode"].intValue == 0
                        {
                            print("Global Response ----->",resJson)
                            success(resJson)
                        }else{
                            EmptyData(resJson["message"].stringValue)
                            print("dataempty--->",resJson)
                        }
                        
                    }
                    
                    if responseObject.result.isFailure {
                        let error : Error = responseObject.result.error!
                        failure(error)
                         ///ToastMessage.showit(title: "Error", Submessage: "Service Failure", theme: .info)
                        print(error.localizedDescription)
                        
                    }
                }
                
            }else{
                
                
            }
        }
    static func StartRequest(_ strURL : String,method:HTTPMethod, params : [String : String]?, headers : [String : String]?,ShowIt:Bool,setview:UIView, success:@escaping (JSON) -> Void,EmptyData:@escaping (String) -> Void, failure:@escaping (Error) -> Void)
    {
        if Reachability.isConnectedToNetwork(){
            
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 120
            print(strURL)
            print(headers)

             print("paramssassssssssss", params)
            
              manager.request(strURL, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
                
                if responseObject.result.isSuccess {
                    
                
                    let resJson = JSON(responseObject.result.value!)
                    
                    print(resJson["statusCode"].intValue)
                    
                    if resJson["statusCode"].intValue == 200 ||  resJson["statusCode"].intValue == 0
                    {
                        print("Global Response ----->",resJson)
                        success(resJson)
                    }else{
                        EmptyData(resJson["message"].stringValue)
                        print("dataempty--->",resJson)
                    }
                    
                }
                
                if responseObject.result.isFailure {
                    let error : Error = responseObject.result.error!
                    failure(error)
                     ///ToastMessage.showit(title: "Error", Submessage: "Service Failure", theme: .info)
                    print(error.localizedDescription)
                    
                }
            }
            
        }else{
            
            
        }
    }

      static func StartRequest1(_ strURL : String,method:HTTPMethod, params : [String : String]?, headers : [String : String]?,ShowIt:Bool,setview:UIView, success:@escaping (JSON) -> Void,EmptyData:@escaping (String) -> Void, failure:@escaping (Error) -> Void)
        {
            if Reachability.isConnectedToNetwork(){
                
                
                let manager = Alamofire.SessionManager.default
                manager.session.configuration.timeoutIntervalForRequest = 120
                print(strURL)
                print("paramssassssssssss", params)
                print(headers)
                manager.request(strURL, method: method, parameters: params, encoding: URLEncoding.default, headers: headers!).responseJSON { (responseObject) -> Void in
                    
                    if responseObject.result.isSuccess {
                        
                    
                        let resJson = JSON(responseObject.result.value!)
                        
                        print(resJson["statusCode"].intValue)
                        
                        if resJson["statusCode"].intValue == 200 ||  resJson["statusCode"].intValue == 0
                        {
                            print("Global Response ----->",resJson)
                            success(resJson)
                        }else{
                            EmptyData(resJson["message"].stringValue)
                            print("dataempty--->",resJson)
                        }
                        
                    }
                    
                    if responseObject.result.isFailure {
                        let error : Error = responseObject.result.error!
                        failure(error)
                        print(error.localizedDescription)
                        
                    }
                }
                
            }else{
                
                
            }
        }
//MARK: Multipart Service

static func multiPartData(params : [String: AnyObject], mediaParamsName : String, serviceURL : String, mediaData : Data, filename : String, mimeType : String, setView: UIView, shoeIt: Bool, success : @escaping (JSON) -> Void,EmptyData:@escaping (String) -> Void, failure : @escaping (Error) -> Void) {
    
    var dummyData = Data()
    
    if mediaData.isEmpty{
        
    }else{
        dummyData.append(mediaData)
    }
    
    if Reachability.isConnectedToNetwork(){
        if shoeIt == true {
            SVProgressHUD.show()
        }else{
            
        }
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        print("asdfsfds>>>>>>>>>>>>>>>>>>>>..>",dummyData)
        
        manager.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(dummyData, withName: mediaParamsName,fileName: filename, mimeType: mimeType)
            
            print(params)
            
            for (key, value) in params {
                
                print("KEY>>>>>>>>>  ",key)
                print("value>>>>>>>>>  ",value)
                
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        },
                       to:serviceURL)
        { (result) in
            switch result
            {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    
                    print("uploaded \(response)")
                    
                    let resJson = JSON(response.result.value ?? "")
                    
                    if resJson["status"].intValue == 1
                    {
                        print("Global Response ----->",resJson)
                        success(resJson)
                    }else{
                        EmptyData(resJson["message"].stringValue)
                        print("dataempty1--->",resJson)
                    }
                    
                    SVProgressHUD.dismiss()
                    
                    
                    if let err = response.error{
                        
                        failure(err)
                        
                        SVProgressHUD.dismiss()
                        
                        
                        return
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
                
                SVProgressHUD.dismiss()
                
            }
        }
    }else{
        
    }
}

static func multiPartDataVideo(params : [String: AnyObject], mediaParamsName : String, serviceURL : String, mediaData : Data,Thumbnaildata : Data,MediaThumbname : String ,filename : String,Thumbfilename : String, mimeType : String,ThumbMimeType : String, setView: UIView, shoeIt: Bool,progress:@escaping (Progress) -> Void, success : @escaping (JSON) -> Void, failure : @escaping (Error) -> Void) {
    
    if Reachability.isConnectedToNetwork(){
        if shoeIt == true {
            SVProgressHUD.show()
        }else{
            
        }
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.upload(multipartFormData: { multipartFormData in
            
            multipartFormData.append(Thumbnaildata, withName: MediaThumbname,fileName: Thumbfilename, mimeType: ThumbMimeType)
            
            multipartFormData.append(mediaData, withName: mediaParamsName,fileName: filename, mimeType: mimeType)
            
            for (key, value) in params {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key )
            }
        },
                       to:serviceURL)
        { (result) in
            switch result
            {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (ProgressId) in
                    
                    progress(ProgressId)
                    
                    SVProgressHUD.showProgress(Float(ProgressId.fractionCompleted))
                })
                
                
                upload.responseJSON { response in
                    
                    print("uploaded \(response)")
                    
                    let resJson = JSON(response.result.value ?? "")
                    
                    success(resJson)
                    
                    SVProgressHUD.dismiss()
                    
                    
                    if let err = response.error{
                        
                        failure(err)
                        
                        SVProgressHUD.dismiss()
                        
                        
                        return
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
                
                SVProgressHUD.dismiss()
                
            }
        }
    }else{
        
    }
 }
}


func multiPartDataWithThumb(params : [String: AnyObject], mediaParamsName : String, serviceURL : String, mediaData : Data,ThumbData : Data ,filename : String, mimeType : String, setView: UIView, shoeIt: Bool, success : @escaping (JSON) -> Void, failure : @escaping (Error) -> Void) {
    
    if Reachability.isConnectedToNetwork(){
        if shoeIt == true {
            SVProgressHUD.show()
        }else{
            
        }
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(mediaData, withName: mediaParamsName,fileName: filename, mimeType: mimeType)
            
            for (key, value) in params {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key )
            }
            
            multipartFormData.append(ThumbData, withName: "preview_image", fileName: "image.jpg", mimeType: "image/jpeg")
        },
                       to:serviceURL)
        { (result) in
            switch result
            {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    
                    print("Upload Progress: \(Progress.fractionCompleted)")
                    
                    
                })
                
                
                upload.responseJSON { response in
                    
                    print("uploaded \(response)")
                    
                    let resJson = JSON(response.result.value ?? "")
                    
                    success(resJson)
                    
                    SVProgressHUD.dismiss()
                    
                    
                    if let err = response.error{
                        
                        failure(err)
                        
                        SVProgressHUD.dismiss()
                        
                        
                        return
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
                
                SVProgressHUD.dismiss()
                
            }
        }
    }else{
        
    }
}


public class Reachability {
    
    class func isConnectedToNetwork() -> Bool
    {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
    
}




