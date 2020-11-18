//
//  Webservices.swift
//  Pixalive
//
//  Created by Manish  on 22/07/19.
//  Copyright © 2019 Manish . All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit

enum WebServices { }

extension NSError {
    
    convenience init(localizedDescription : String) {
        self.init(domain: "AppNetworkingError", code: 0, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
    
    convenience init(code : Int, localizedDescription : String) {
        self.init(domain: "AppNetworkingError", code: code, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
}

extension WebServices {
    
    // MARK:- Common POST API
    //=======================
    static func commonPostAPI(parameters: JSONDictionary,
                              endPoint: EndPoint,
                              loader: Bool = true,
                              success : @escaping SuccessResponse,
                              failure : @escaping FailureResponse) {
        
        let user = "pixalive"
        let password = "DAF87DSFDSFDSA98FSADKJE324KJL32HFD7FDSFB24343J49DSF"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)", "access_token": "Bearer \(AppUserDefaults.value(forKey: .accesstoken).stringValue)"]
        print(AppUserDefaults.value(forKey: .accesstoken).stringValue)
        print(headers)
        AppNetworking.POST(endPoint: endPoint.path, parameters: parameters, headers: headers, loader: loader, success: { (json) in
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
    
    
    static func createPostJSONAPI(parameters: JSONDictionary,
                                  endPoint: EndPoint,
                                  loader: Bool = true,
                                  success : @escaping SuccessResponse,
                                  failure : @escaping FailureResponse) {
        
        let user = "pixalive"
        let password = "DAF87DSFDSFDSA98FSADKJE324KJL32HFD7FDSFB24343J49DSF"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)", "access_token": "Bearer \(AppUserDefaults.value(forKey: .accesstoken).stringValue)","Content-Type" :"application/json"]
        print(headers)
        print(parameters)
        AppNetworking.POSTWITHJSON(endPoint: endPoint.path, parameters: parameters, headers: headers, loader: loader, success: { (json) in
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
    static func createPostJSONAPI_post(parameters: JSONDictionary,
                                  endPoint: EndPoint,
                                  loader: Bool = true,
                                  success : @escaping SuccessResponse,
                                  failure : @escaping FailureResponse) {
        
        let user = "pixalive"
        let password = "DAF87DSFDSFDSA98FSADKJE324KJL32HFD7FDSFB24343J49DSF"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)", "access_token": "Bearer \(AppUserDefaults.value(forKey: .accesstoken).stringValue)","Content-Type" :"application/json"]
        print(headers)
        
        AppNetworking.POST(endPoint: endPoint.path, parameters: parameters, headers: headers, loader: loader, success: { (json) in
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
    static func createPostJSONAPI_otp(parameters: JSONDictionary,
                                  endPoint: EndPoint,
                                  loader: Bool = true,
                                  success : @escaping SuccessResponse,
                                  failure : @escaping FailureResponse) {
        
        let user = "pixalive"
        let password = "DAF87DSFDSFDSA98FSADKJE324KJL32HFD7FDSFB24343J49DSF"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)", "access_token": "Bearer \(AppUserDefaults.value(forKey: .accesstoken).stringValue)","Content-Type" :"application/json"]
        print(headers)
        AppNetworking.POSTWITHJSON(endPoint: endPoint.path, parameters: parameters, headers: headers, loader: loader, success: { (json) in
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
    static func gameExistance(parameters: JSONDictionary,
                                success: @escaping SuccessResponse,
                                failure: @escaping FailureResponse) {
        
        self.commonPostAPI(parameters: parameters, endPoint: .empity, success: success, failure: failure)
    }
    // MARK:- Common GET API
    //=======================
    static func commonGetAPI(parameters: JSONDictionary,
                             endPoint: EndPoint,
                             loader: Bool = true,
                             success : @escaping SuccessResponse,
                             failure : @escaping FailureResponse) {
        
        let user = "pixalive"
        let password = "DAF87DSFDSFDSA98FSADKJE324KJL32HFD7FDSFB24343J49DSF"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)", "access_token": "Bearer \(AppUserDefaults.value(forKey: .accesstoken).stringValue)"]
        print("Bearer \(AppUserDefaults.value(forKey: .accesstoken).stringValue)")
        
        AppNetworking.GET(endPoint: endPoint.path, parameters: parameters, headers: headers, loader: loader, success: { (json) in
            print(json)
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
    
    // MARK:- Common DELETE API
    //=======================
    static func commonDeleteAPI(parameters: JSONDictionary,
                                endPoint: EndPoint,
                                loader: Bool = true,
                                success : @escaping SuccessResponse,
                                failure : @escaping FailureResponse) {
        
        let user = "pixalive"
        let password = "DAF87DSFDSFDSA98FSADKJE324KJL32HFD7FDSFB24343J49DSF"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)", "access_token": "Bearer \(AppUserDefaults.value(forKey: .accesstoken).stringValue)","Content-Type" :"application/x-www-form-urlencoded"]
        
        AppNetworking.DELETE(endPoint: endPoint.path, parameters: parameters, headers: headers, loader: loader, success: { (json) in
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
    
    // MARK:- Sign Up
    //===============
    static func signUp(parameters: JSONDictionary,
                       success: @escaping SuccessResponse,
                       failure: @escaping FailureResponse) {
        
        self.createPostJSONAPI_otp(parameters: parameters, endPoint: .signup, success: { (json) in
            print((json))
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func UpdateName(parameters: JSONDictionary,
                       success: @escaping SuccessResponse,
                       failure: @escaping FailureResponse) {
        
        self.createPostJSONAPI_otp(parameters: parameters, endPoint: .updatename, success: { (json) in
            print((json))
            success(json[ApiKey.RESULT])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func Update_password(parameters: JSONDictionary,
                       success: @escaping SuccessResponse,
                       failure: @escaping FailureResponse) {
        
        self.createPostJSONAPI_otp(parameters: parameters, endPoint: .password, success: { (json) in
            print((json))
            success(json[ApiKey.RESULT])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func Update_setting(parameters: JSONDictionary,
                       success: @escaping SuccessResponse,
                       failure: @escaping FailureResponse) {
        
        self.createPostJSONAPI_otp(parameters: parameters, endPoint: .updatesetting, success: { (json) in
            print((json))
            success(json[ApiKey.RESULT])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func contact_sync(parameters: JSONDictionary,
                         success: @escaping SuccessResponse,
                         failure: @escaping FailureResponse) {
          
          self.createPostJSONAPI(parameters: parameters, endPoint: .ContactSync, success: { (json) in
              print((json))
              success(json[ApiKey.RESULT])
          }) { (error) -> (Void) in
              failure(error)
          }
      }
    static func forgetpwotp(parameters: JSONDictionary,
                            
                            loader: Bool,
                            success: @escaping SuccessResponse,
                            failure: @escaping FailureResponse){
        self.createPostJSONAPI_otp(parameters: parameters, endPoint: .verifyotp, loader: loader,success: { (json) in
            print((json))
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func forgetpwotp_email(parameters: JSONDictionary,
                            
                            loader: Bool,
                            success: @escaping SuccessResponse,
                            failure: @escaping FailureResponse){
        self.createPostJSONAPI_otp(parameters: parameters, endPoint: .verifyotp_email, loader: loader,success: { (json) in
            print((json))
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func forgetpw(parameters: JSONDictionary,
                         
                         loader: Bool,
                         success: @escaping SuccessResponse,
                         failure: @escaping FailureResponse){
        self.createPostJSONAPI(parameters: parameters, endPoint: .forgotpassword, loader: loader,success: { (json) in
            print((json))
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
   static func resendforget_pw(parameters: JSONDictionary,
                               
                               loader: Bool,
                               success: @escaping SuccessResponse,
                               failure: @escaping FailureResponse){
        self.createPostJSONAPI(parameters: parameters, endPoint: .resendForgetOtp, loader: loader,success: { (json) in
            print((json))
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
        
        
        
    }
    static func resendforget_pw_email(parameters: JSONDictionary,
                                 
                                 loader: Bool,
                                 success: @escaping SuccessResponse,
                                 failure: @escaping FailureResponse){
          self.createPostJSONAPI(parameters: parameters, endPoint: .resendForgetOtpemail, loader: loader,success: { (json) in
              print((json))
              success(json["result"])
          }) { (error) -> (Void) in
              failure(error)
          }
          
          
          
      }
    
    
    static func resendforgetpw(parameters: JSONDictionary,
                               
                               loader: Bool,
                               success: @escaping SuccessResponse,
                               failure: @escaping FailureResponse){
        self.createPostJSONAPI(parameters: parameters, endPoint: .resendSignupOtp, loader: loader,success: { (json) in
            print((json))
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
        
        
        
    }
    static func resendforgetpw_email(parameters: JSONDictionary,
                                 
                                 loader: Bool,
                                 success: @escaping SuccessResponse,
                                 failure: @escaping FailureResponse){
          self.createPostJSONAPI(parameters: parameters, endPoint: .resendSignupOtpemail, loader: loader,success: { (json) in
              print((json))
              success(json["result"])
          }) { (error) -> (Void) in
              failure(error)
          }
          
          
          
      }
    // MARK:- Login
    //=============
    static func login(parameters: JSONDictionary,
                      success: @escaping SuccessResponse,
                      failure: @escaping FailureResponse) {
        
        self.createPostJSONAPI(parameters: parameters, endPoint: .login, success: { (json) in
            print((json))
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    // MARK:- Forgot Password
    //=======================
    static func forgotPassword(parameters: JSONDictionary,
                               success: @escaping SuccessResponse,
                               failure: @escaping FailureResponse) {
        
        self.commonPostAPI(parameters: parameters, endPoint: .forgotpassword, success:  { (json) in
            print((json))
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    // MARK:- Social Existance
    //=======================
    static func socialExistance(parameters: JSONDictionary,
                                success: @escaping SuccessResponse,
                                failure: @escaping FailureResponse) {
        
        self.commonPostAPI(parameters: parameters, endPoint: .socialExistance, success: { (json) in
            print((json))
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    // MARK:- Reset Password
    //=======================
    static func resetPassword(parameters: JSONDictionary,
                              success: @escaping SuccessResponse,
                              failure: @escaping FailureResponse) {
        
        self.commonPostAPI(parameters: parameters, endPoint: .resetpassword, success: { (json) in
            print((json))
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    //MARK:- Get Country List
    
    static func getCountryList(parameters: JSONDictionary,
                               success: @escaping SuccessResponse,
                               failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .countrylist, success: { (json) in
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    //MARK:- Get State List
    
    static func getStateList(parameters: JSONDictionary,
                             success: @escaping SuccessResponse,
                             failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .stateList, success: { (json) in
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    //MARK:- Get City List
    static func getCityList(parameters: JSONDictionary,
                            success: @escaping SuccessResponse,
                            failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .cityList, success: { (json) in
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    //MARK:- Build Profile
    static func buildProfile(parameters: JSONDictionary,
                             success: @escaping SuccessResponse,
                             failure: @escaping FailureResponse){
        
        self.commonPostAPI(parameters: parameters, endPoint: .editProfile, success: { (json) in
            success(json[ApiKey.result])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    //MARK:- Get Profile Details
    static func getProfileDetails(parameters: JSONDictionary,
                                  success: @escaping SuccessResponse,
                                  failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .viewProfile, success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    // MARK:- Logout User
    //===================
    static func logoutAPI(success: @escaping SuccessResponse,
                          failure: @escaping FailureResponse) {
        
        AppNetworking.PUT(endPoint: EndPoint.logout.path, success: { (json) in
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
    
    //MARK:- Get Near me post.
    static func getNearByPost(parameters: JSONDictionary,
                              loader: Bool,
                              success: @escaping SuccessResponse,
                              failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .getNearByPost,  loader: loader,success: { (json) in
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func getNearByPostbytag(parameters: JSONDictionary,
                              loader: Bool,
                              success: @escaping SuccessResponse,
                              failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .getNearByPostbyTag,  loader: loader,success: { (json) in
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func getTrendingPerson(parameters: JSONDictionary,
                                  loader: Bool,
                                  success: @escaping SuccessResponse,
                                  failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .trendingPerson, loader: loader, success: { (json) in
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func getListViewTrendingMedia(parameters: JSONDictionary,
                                         loader: Bool,
                                         success: @escaping SuccessResponse,
                                         failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .listViewTrendingMedia, loader: loader, success: { (json) in
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func getListViewTrendingweek(parameters: JSONDictionary,
                                         loader: Bool,
                                         success: @escaping SuccessResponse,
                                         failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .listViewTrendingweek, loader: loader, success: { (json) in
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func getListViewchallenge(parameters: JSONDictionary,
                                           loader: Bool,
                                           success: @escaping SuccessResponse,
                                           failure: @escaping FailureResponse){
          self.commonGetAPI(parameters: parameters, endPoint: .listViewChallenges, loader: loader, success: { (json) in
              success(json["result"])
          }) { (error) -> (Void) in
              failure(error)
          }
      }
    static func getListViewTrendingRecentMedia(parameters: JSONDictionary,
                                           loader: Bool,
                                           success: @escaping SuccessResponse,
                                           failure: @escaping FailureResponse){
          self.commonGetAPI(parameters: parameters, endPoint: .mapViewTrendingrecentmedia, loader: loader, success: { (json) in
            print(json)
              success(json["result"])
          }) { (error) -> (Void) in
              failure(error)
          }
      }
    static func getListViewTrendingMediapost(parameters: JSONDictionary,
                                             loader: Bool,
                                             success: @escaping SuccessResponse,
                                             failure: @escaping FailureResponse){
            self.commonGetAPI(parameters: parameters, endPoint: .getTrendposts, loader: loader, success: { (json) in
              print(json)
                success(json["result"])
            }) { (error) -> (Void) in
                failure(error)
            }
        }
      static func getListTrendingmediawinner(parameters: JSONDictionary,
                                                loader: Bool,
                                                success: @escaping SuccessResponse,
                                                failure: @escaping FailureResponse){
               self.commonGetAPI(parameters: parameters, endPoint: .trendingmediawinner, loader: loader, success: { (json) in
                 print(json)
                   success(json["result"])
               }) { (error) -> (Void) in
                   failure(error)
               }
           }
    static func getListViewTrendingHashtag(parameters: JSONDictionary,
                                           loader: Bool,
                                           success: @escaping SuccessResponse,
                                           failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .listViewTrendingHashtag, loader: loader, success: { (json) in
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func getListViewTrendingweek_content(parameters: JSONDictionary,
                                              loader: Bool,
                                              success: @escaping SuccessResponse,
                                              failure: @escaping FailureResponse){
           self.commonGetAPI(parameters: parameters, endPoint: .getTrendoftheweekContent, loader: loader, success: { (json) in
               success(json["result"])
           }) { (error) -> (Void) in
               failure(error)
           }
       }
    static func getListViewTrendingweek_title(parameters: JSONDictionary,
                                           loader: Bool,
                                           success: @escaping SuccessResponse,
                                           failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .getTrendoftheweektitle, loader: loader, success: { (json) in
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
       static func getListViewTrendingweek_challenge(parameters: JSONDictionary,
                                              loader: Bool,
                                              success: @escaping SuccessResponse,
                                              failure: @escaping FailureResponse){
           self.commonGetAPI(parameters: parameters, endPoint: .getTrendofthechallengeContent, loader: loader, success: { (json) in
               success(json["result"])
           }) { (error) -> (Void) in
               failure(error)
           }
       }
    static func getForMeList(parameters: JSONDictionary,
                             loader: Bool,
                             success: @escaping SuccessResponse,
                             failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .getForMe, loader: loader, success: { (json) in
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func getHomeFolloweList(parameters: JSONDictionary,
                                   success: @escaping SuccessResponse,
                                   failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .getFollowing, success: { (json) in
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func getCommentList(parameters: JSONDictionary,
                               success: @escaping SuccessResponse,
                               failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .commentListing, success: { (json) in
            print(json)
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    //MARK:-
    static func addComments(parameters: JSONDictionary,
                            loader: Bool,
                            success: @escaping SuccessResponse,
                            failure: @escaping FailureResponse){
        self.commonPostAPI(parameters: parameters, endPoint: .addComment, loader: loader,success: { (json) in
            
            
            success(json["result"])
           
            
        }) { (error) -> (Void) in
            failure(error)
        }
    }

    static func likeDislikeComment(parameters: JSONDictionary,
                                   loader: Bool,
                                   success:  @escaping SuccessResponse,
                                   failure: @escaping FailureResponse){
        self.commonPostAPI(parameters: parameters, endPoint: .likeDislikeComments, loader: loader,success: { (json) in
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func getCommentReplyList(parameters: JSONDictionary,
                                    success: @escaping (_ json : CommentListModel) -> (),
                                    failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .viewCommentReply, success: { (json) in
            print(json)
            let jsonString = """
            \(json["result"])
            """
            if let jsonData = jsonString.data(using: .utf8) {
                let decoder = JSONDecoder()
                
                do {
                    let dataModel = try decoder.decode(CommentListModel.self, from: jsonData)
                    success(dataModel)
                } catch {
                    failure(error)
                }
                
            } else {
                print("Respond to error")
            }
            
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    //
    static func getProfilePostList(parameters: JSONDictionary,
                                   success: @escaping (_ json : PostDataModel) -> (),
                                   failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .viewProfilePost, success: { (json) in
            
            print(json)
            
            let dataModel = PostDataModel(dictionary: json["result"])
            success(dataModel)
            
            
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    
    static func getFollowersList(parameters: JSONDictionary,
                                 loader: Bool,
                                 success: @escaping (_ json : TrendingPeopleModel) -> (),
                                 failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .getFollowers, loader: loader,success: { (json) in
            
            let dataModel = TrendingPeopleModel(dictionary: json["result"])
            success(dataModel)
            
            
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func blockUnblockUser(parameters: JSONDictionary,
                                 loader: Bool,
                                 success: @escaping SuccessResponse,
                                 failure: @escaping FailureResponse){
        self.commonPostAPI(parameters: parameters, endPoint: . blockUnblockPeople, loader: loader,success: { (json) in
            success(json)
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    
    static func getWhoLikesShareSeen(parameters: JSONDictionary,
                                     loader: Bool,
                                     success: @escaping (_ json : TrendingPeopleModel) -> (),
                                     failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .whoLikesShareSeen, loader: loader,success: { (json) in
            let dataModel = TrendingPeopleModel(dictionary: json["result"])
            success(dataModel)
            
            
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func followUfollowPeople(parameters: JSONDictionary,
                                    loader: Bool,
                                    success: @escaping SuccessResponse,
                                    failure: @escaping FailureResponse){
        self.commonPostAPI(parameters: parameters, endPoint: .followUfollowPeople, loader: loader,success: { (json) in
            print(json)
            
            success(json["result"])
            
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func postActionsApi(parameters: JSONDictionary,
                               loader: Bool,
                               success: @escaping SuccessResponse,
                               failure: @escaping FailureResponse){
        self.commonPostAPI(parameters: parameters, endPoint: .postActions, loader: loader,success: { (json) in
            print(json)
            
            success(json["result"])
            
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func getTermPrivacyAbouUrl(parameters: JSONDictionary,
                                      endPoint:WebServices.EndPoint,
                                      loader: Bool,
                                      success: @escaping SuccessResponse,
                                      failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint:endPoint, loader: loader,success: { (json) in
            
            success(json)
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func getViewStarPostList(parameters: JSONDictionary,
                                    success: @escaping (_ json : PostDataModel) -> (),
                                    failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .viewStarPost, success: { (json) in
            print(json)
            
            let dataModel = PostDataModel(dictionary: json["result"])
            success(dataModel)
            
            
        }) { (error) -> (Void) in
            print(error)
            failure(error)
        }
    }
    static func getViewtagPostList(parameters: JSONDictionary,
                                    success: @escaping (_ json : PostDataModel) -> (),
                                    failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .viewTagPost, success: { (json) in
            print(json)
            
            let dataModel = PostDataModel(dictionary: json["result"])
            success(dataModel)
           
            
        }) { (error) -> (Void) in
            print(error)
            failure(error)
        }
    }
    
    
    static func getStaboardListApi(parameters: JSONDictionary,
                                   loader: Bool,
                                   success: @escaping SuccessResponse,
                                   failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .discoverStarBoard, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func getDiscoverSuggestedLisApi(parameters: JSONDictionary,
                                           loader: Bool,
                                           success: @escaping SuccessResponse,
                                           failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .discoversearchPeople, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func getDiscoversearchLisApi(parameters: JSONDictionary,
                                              loader: Bool,
                                              success: @escaping SuccessResponse,
                                              failure: @escaping FailureResponse){
           self.commonGetAPI(parameters: parameters, endPoint: .discoversearchPeople, loader: loader,success: { (json) in
               
               success(json["result"])
           }) { (error) -> (Void) in
               failure(error)
           }
       }
    static func getFollowingPeopleLisApi(parameters: JSONDictionary,
                                         loader: Bool,
                                         success: @escaping SuccessResponse,
                                         failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .getFollowingPeople, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func getstorystatus(parameters: JSONDictionary,
                                         loader: Bool,
                                         success: @escaping SuccessResponse,
                                         failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .viewstory, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func getFollowingHashtagsLisApi(parameters: JSONDictionary,
                                           loader: Bool,
                                           success: @escaping SuccessResponse,
                                           failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .getFollowingHashtags, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func userexist(parameters: JSONDictionary,
                                     success: @escaping SuccessResponse,
                                     failure: @escaping FailureResponse){
              self.commonPostAPI(parameters: parameters, endPoint: .UserExist, success: { (json) in
                  success(json["result"])
              }) { (error) -> (Void) in
               print(error)
                  failure(error)
              }
          }
    static func getMapViewTrendingMediaLisApi(parameters: JSONDictionary,
                                              endPoint:WebServices.EndPoint,
                                              loader: Bool,
                                              success: @escaping SuccessResponse,
                                              failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: endPoint, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func getstateMediaLisApi(parameters: JSONDictionary,
                                                 endPoint:WebServices.EndPoint,
                                                 loader: Bool,
                                                 success: @escaping SuccessResponse,
                                                 failure: @escaping FailureResponse){
           self.commonGetAPI(parameters: parameters, endPoint: endPoint, loader: loader,success: { (json) in
               
               success(json["result"])
           }) { (error) -> (Void) in
               failure(error)
           }
       }
    static func getTrendingCountryLisApi(parameters: JSONDictionary,
                                         
                                         loader: Bool,
                                         success: @escaping SuccessResponse,
                                         failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .trendingCountry, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func getAnalyticsDataApi(parameters: JSONDictionary,
                                    
                                    loader: Bool,
                                    success: @escaping SuccessResponse,
                                    failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .getAnalyticsData, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func getCameraSDKDataApi(parameters: JSONDictionary,
                                    
                                    loader: Bool,
                                    success: @escaping SuccessResponse,
                                    failure: @escaping FailureResponse){
        AppNetworking.GET(endPoint: "https://apis.argear.io/api/v3/431b43104d8abd33f3a7a334", parameters: parameters,  loader: loader, success: { (json) in
            let code = json[ApiKey.code].intValue
            let msg = json[ApiKey.message].stringValue
            switch code {
            case 0:
                success(json)
            default:
                failure(NSError(code: code, localizedDescription: msg))
            }
        }) { (error) in
            failure(error)
        }
    }
    
    static func getHashtagDetailsApi(parameters: JSONDictionary,
                                     
                                     loader: Bool,
                                     success: @escaping SuccessResponse,
                                     failure: @escaping FailureResponse){
        self.commonPostAPI(parameters: parameters, endPoint: .hashtagDetails, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func createPostApi(parameters: JSONDictionary,
                              
                              loader: Bool,
                              success: @escaping SuccessResponse,
                              failure: @escaping FailureResponse){
        self.createPostJSONAPI(parameters: parameters, endPoint: .createPost, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func editprofile(parameters: JSONDictionary,
                              
                              loader: Bool,
                              success: @escaping SuccessResponse,
                              failure: @escaping FailureResponse){
        self.commonPostAPI(parameters: parameters, endPoint: .editProfile, loader: loader,success: { (json) in
            print(json)
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func getNotificationLisApi(parameters: JSONDictionary,
                                      
                                      loader: Bool,
                                      success: @escaping SuccessResponse,
                                      failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .getNotifications, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    static func geHhashtagPostListApi(parameters: JSONDictionary,
                                      
                                      loader: Bool,
                                      success: @escaping SuccessResponse,
                                      failure: @escaping FailureResponse){
        self.commonPostAPI(parameters: parameters, endPoint: .hashtagPostList, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func followUnfollowHashtag(parameters: JSONDictionary,
                                      loader: Bool,
                                      success: @escaping SuccessResponse,
                                      failure: @escaping FailureResponse){
        self.commonPostAPI(parameters: parameters, endPoint: .followUnfollowHashtag, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func reportPostApi(parameters: JSONDictionary,
                              loader: Bool,
                              success: @escaping SuccessResponse,
                              failure: @escaping FailureResponse){
        self.commonPostAPI(parameters: parameters, endPoint: .reportOnPost, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func hidePostApi(parameters: JSONDictionary,
                            loader: Bool,
                            success: @escaping SuccessResponse,
                            failure: @escaping FailureResponse){
        self.commonPostAPI(parameters: parameters, endPoint: .hidePost, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func getBlockPeopleLisApi(parameters: JSONDictionary,
                                     
                                     loader: Bool,
                                     success: @escaping SuccessResponse,
                                     failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .getBlockPeople, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func deletePostApi(parameters: JSONDictionary,
                              
                              loader: Bool,
                              success: @escaping SuccessResponse,
                              failure: @escaping FailureResponse){
        self.commonDeleteAPI(parameters: parameters, endPoint: .deletePost, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func deleteCommentApi(parameters: JSONDictionary,
                                 loader: Bool,
                                 success: @escaping SuccessResponse,
                                 failure: @escaping FailureResponse){
        self.commonPostAPI(parameters: parameters, endPoint: .deleteComment, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func editCommentApi(parameters: JSONDictionary,
                               loader: Bool,
                               success: @escaping SuccessResponse,
                               failure: @escaping FailureResponse){
        self.commonPostAPI(parameters: parameters, endPoint: .editComment, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func getTrendingSearchListApi(parameters: JSONDictionary,
                                         
                                         loader: Bool,
                                         success: @escaping SuccessResponse,
                                         failure: @escaping FailureResponse){
        SearchNetworkingClass.shared.searchGetAPI(parameters: parameters, endPoint: .trendingSearch, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
    static func getPostDetailsApi(parameters: JSONDictionary,
                                  
                                  loader: Bool,
                                  success: @escaping SuccessResponse,
                                  failure: @escaping FailureResponse){
        self.commonGetAPI(parameters: parameters, endPoint: .getPostDetails, loader: loader,success: { (json) in
            
            success(json["result"])
        }) { (error) -> (Void) in
            failure(error)
        }
    }
    
}



