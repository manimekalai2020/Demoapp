//
//  Webservice+EndPoints.swift
//  Pixalive
//
//  Created by Manish  on 22/07/19.
//  Copyright © 2019 Manish . All rights reserved.
//

import Foundation


let baseUrl = "https://api.pixalive.me/api/v2/user/"
let baseUrl_Otp = "https://api.pixalive.me/api/v2/user/"


extension WebServices {
    

    enum EndPoint : String {
        case ContactSync                 = "contact-synchronization"
        case listcity                     = "rapid/news/city/list"

        case updatesetting                 = "update-setting"
        case updatename                    = "UpdateName"
        case password                      = "password"
        case signup                        = "signup"
        case login                         = "login"
        case changepassword                = "change-password"
        case forgotpassword                = "forgot-password"
        case resendSignupOtp               = "resend-signup-otp"
        case resendSignupOtpemail          = "resend-Emailsignup-otp"
        case resendForgetOtp               = "resend-forget-otp"
        case resendForgetOtpemail          = "resend-forget-Emailotp"
        case viewProfile                   = "view-profile"
        case editProfile                   = "edit-profile"
        case resetpassword                 = "reset-password"
        case managefriends                 = "manage-friend"
        case socialExistance               = "social-existence"
        case logout
        case refresh
        case countrylist                   = "country-list"
        case stateList                     = "state-list"
        case cityList                      = "city-list"
        case buildProfile                  = "build-profile"
        case getNearByPost                 = "get-near-me-posts"
        case getNearByPostbyTag            = "fetch/related/post/by/hashtag"

        case listViewTrendingHashtag       = "list-view-trending-hashtag"
        case getTrendoftheweekContent       = "get-Trend-of-the-weekContent"
        case getTrendoftheweektitle       = "get-content-Title1"
        case getTrendofthechallengeContent  = "get-challenge-content"

        case trendingPerson                = "trending-person"
        case listViewTrendingMedia         = "list-view-trending-media"
        case listViewTrendingweek         = "trend-of-the-week"
        case listViewChallenges         = "challenge"

        case getFollowing                  = "get-following"
        case getForMe                      = "get-for-me"
        case commentListing                = "comment-listing"
        case addComment                    = "add-comment"
        case likeDislikeComments           = "like-dislike-comments"
        case viewCommentReply              = "view-reply"
        case viewProfilePost               = "view-post"
        case getFollowers                  = "get-followers"
        case blockUnblockPeople            = "block-unblock-people"
        case whoLikesShareSeen             = "who-likes-share-seen"
        case followUfollowPeople           = "follow-unfollow-people"
        case postActions                   = "post-actions"
        case getTerms                      = "get-terms"
        case getPrivacy                    = "get-privacy"
        case getAboutUs                    = "get-about-us"
        case viewStarPost                  = "view-star-post"
        case viewTagPost                   = "all/tagged/posts"
        case viewstory                     = "/get/users/display/image"
        case discoverSuggestedPeople       = "discover-suggested-people"
        case discoversearchPeople          = "discover/user/name/search"
        case discoverStarBoard             = "discover-star-board"
        case getFollowingPeople            = "get-following-people"
        case getFollowingHashtags          = "get-following-hashtags"
        case mapViewTrendingMedia          = "map-view-trending-media"
        case mapViewTrendingrecentmedia    = "get/all/fresh/posts"
        case trendingmediawinner        = "trending-media-winner"
        case mapViewTrendingHashtag        = "map-view-trending-hashtag"
        case trendingCountry               = "trending-country"
        case mapListViewTrendingCountry    = "map-list-view-trending-country"
        case getAnalyticsData              = "get-analytics-data"
        case hashtagDetails                = "hashtag-details"
        case createPost                    = "create-post"
        case getNotifications              = "get-notifications"
        case hashtagPostList               = "hashtag-post-list"
        case followUnfollowHashtag         = "follow-unfollow-hashtag"
        case reportOnPost                  = "report-on-post"
        case hidePost                      = "hide-post"
        case getBlockPeople                = "get-block-people"
        case deletePost                    = "delete-post"
        case deleteComment                 = "delete-comment"
        case editComment                   = "edit-comment"
        case trendingSearch                = "trending-search"
        case getPostDetails                = "get-post-details"
        case verifyotp                     = "verifyotp"
        case verifyotp_email               = "verifyEmailotp"
         case trendinghashtag              = "trending-hashtag"
        case getrules                      = "get-rules"
        case getTrendRules                 = "get-Trend-Rules"
        case getcontent                    = "get-content"
        case getcontentrules               = "get-content-rules"
        case getTrendposts                 = "trending-media"

        case UserExist                     = "channelize/user/exists"

        
        

        case empity   = ""

        var path : String {
            
            let url    = baseUrl
            return url + self.rawValue
        }
        var path1 : String {
                   
                   let url    = baseUrl_Otp
                   return url + self.rawValue
               }
    }
}
struct Webservicesmain {
    static let BaseUrl1 = "https://api.pixalive.me/api/v2/user/"

    static let BaseUrl = "https://api.pixalive.me/api/v2/user/"
    
    static var CreateChannel:String{
        return BaseUrl + "create/channel"
    }
 
    static var Catogorylist:String{
        return BaseUrl + "fetch/channel/category/list"
    }
    static var Newslist:String{
          return BaseUrl + "trending-hashtag"
      }
    static var peoplelist:String{
             return BaseUrl1 + "discover-Suggested-People"
         }
    static var Trendingmedia:String{
        return BaseUrl1 + "list-view-trending-media"
    }
    static var trendingallchannel:String{
        return BaseUrl + "fetch/all/trending/channel/list"
    }
}
