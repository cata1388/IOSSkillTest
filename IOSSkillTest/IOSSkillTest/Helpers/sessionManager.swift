//
//  sessionManager.swift
//  IOSSkillTest
//
//  Created by Catalina Sanchez Castaño on 1/30/16.
//  Copyright © 2016 Catalina Sanchez Castaño. All rights reserved.
//

import AFNetworking

class sessionManager: AFHTTPSessionManager {
	
	static let baseURL = "https://developer.spotify.com/web-api/console/"
	
	class var sharedInstance: sessionManager {
		struct Static {
			static var onceToken: dispatch_once_t = 0
			static var instance: sessionManager? = nil
		}
		dispatch_once(&Static.onceToken) {
			let instance = sessionManager(baseURL: NSURL(string: baseURL))
			instance.requestSerializer = AFJSONRequestSerializer()
			instance.responseSerializer = AFJSONResponseSerializer()
			Static.instance = instance
		}
		
		return Static.instance!
	}
	
	

}
