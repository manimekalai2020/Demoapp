//
//  Todo.swift
//  CodeSample
//
//  Created by Gina De La Rosa on 6/3/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//  Struct model for to do list from JSONPlaceholder API endpoint: /users/1/todos


import UIKit
import ObjectMapper

class Todo: NSObject  , Mappable{
       var id : Int?
       var userId : Int?
        var title : String?
       var body : String?
    required init?(map: Map) {
    }
    
     func mapping(map: Map) {
        id <- map["id"]
        userId <- map["userId"]
        title <- map["title"]
        body <- map["body"]
    }
}
