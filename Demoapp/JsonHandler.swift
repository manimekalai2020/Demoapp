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
  
    static func StartRequest(_ strURL : String,method:HTTPMethod, params : [String : String]?,ShowIt:Bool,setview:UIView, success:@escaping (JSON) -> Void,EmptyData:@escaping (String) -> Void, failure:@escaping (Error) -> Void)
    {
        if Reachability.isConnectedToNetwork(){
            let manager = Alamofire.Session.default
            manager.session.configuration.timeoutIntervalForRequest = 120
            print(strURL)
           // print(headers)
             print("paramssassssssssss", params)
            
              manager.request(strURL, method: method, parameters: params, encoding: JSONEncoding.default).responseJSON { (responseObject) -> Void in
                
                switch responseObject.result {
                        
                        case .success(let value):
                            print(value)
                            let resJson = JSON(value)
                            success(resJson)
                            print("Alamo value: \(value)")
                            break
                        case .failure(let error):
                            EmptyData(error.localizedDescription)

                            print("Alamo error: \(error)")
                            break
                        }
              
            }
            
        }else{
            
            
        }
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





