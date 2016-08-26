//
//  RealmUtil.swift
//  SimpleWeatherInfo-RealmTest
//
//  Created by Nikolay Dementiev on 26.08.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import RealmSwift

//MARK: REALM save file

//class RealmUtil {
//
//	//Singleton pattern
//	static let sharedInstance = RealmUtil()
//
//	let realm: Realm?
//
//	private init() {
//		// Create realm pointing to default file
//		realm = try! Realm()
//	}
//
//	func saveCurrentObject(T: Object) {
//
//		if let realmIns = realm {
//
//			try! realmIns.write {
//				realmIns.add(T)
//			}
//		}
//	}
//
//
//	func saveCurrentObject(T: [Object]) {
//
//		if let realmIns = realm {
//
//			// Save object
//			realmIns.beginWrite()
//			for itemT in T {
//				realmIns.add(itemT)
//			}
//			try! realmIns.commitWrite()
//			
//		}
//	}
//	
//}
