//
//  sessionManager.swift
//  IOSSkillTest
//
//  Created by Catalina Sanchez Castaño on 1/30/16.
//  Copyright © 2016 Catalina Sanchez Castaño. All rights reserved.
//

import AFNetworking

class SessionManager: AFHTTPSessionManager {
	
	static let baseURL = "https://api.spotify.com/v1"
	
	class var sharedInstance: SessionManager {
		struct Static {
			static var onceToken: dispatch_once_t = 0
			static var instance: SessionManager? = nil
		}
		dispatch_once(&Static.onceToken) {
			let instance = SessionManager(baseURL: NSURL(string: baseURL))
			instance.requestSerializer = AFJSONRequestSerializer()
			instance.responseSerializer = AFJSONResponseSerializer()
			Static.instance = instance
		}
		
		return Static.instance!
	}
	
	

}
