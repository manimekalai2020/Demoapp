

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
        
       
    }
    
    
    static func createPostJSONAPI(parameters: JSONDictionary,
                                  endPoint: EndPoint,
                                  loader: Bool = true,
                                  success : @escaping SuccessResponse,
                                  failure : @escaping FailureResponse) {
        
      
    }
    static func createPostJSONAPI_post(parameters: JSONDictionary,
                                  endPoint: EndPoint,
                                  loader: Bool = true,
                                  success : @escaping SuccessResponse,
                                  failure : @escaping FailureResponse) {
        
        
    }
    static func createPostJSONAPI_otp(parameters: JSONDictionary,
                                  endPoint: EndPoint,
                                  loader: Bool = true,
                                  success : @escaping SuccessResponse,
                                  failure : @escaping FailureResponse) {
        
        
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
        
       
    }
    
    // MARK:- Common DELETE API
    //=======================
    static func commonDeleteAPI(parameters: JSONDictionary,
                                endPoint: EndPoint,
                                loader: Bool = true,
                                success : @escaping SuccessResponse,
                                failure : @escaping FailureResponse) {
        
        
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
    
}
