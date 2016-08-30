//
//  RealmUtil.swift
//  SimpleWeatherInfo-RealmTest
//
//  Created by Nikolay Dementiev on 26.08.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import RealmSwift

//MARK: REALM save file

class RealmUtil {

	//Singleton pattern
	static let sharedInstance = RealmUtil()

	let realm: Realm?

	private init() {
		// Create realm pointing to default file
		realm = try! Realm()

		//		try! realm!.write {
		//			realm!.deleteAll()
		//		}
	}

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

	class func saveRealmObject (realmIn: Realm?, object: Object?) {

		guard object != nil else { return }

		//		do {
		//
		//			let realm: Realm
		//
		//			if realmIn == nil {
		//				realm = try Realm()
		//			} else {
		//				realm = realmIn!
		//			}
		if let tmpRealm = RealmUtil.getRealmObj(realmIn) {

			try! tmpRealm.write {
				tmpRealm.add(object!, update: true)
			}
		}
		//
		//
		//		} catch let error as NSError {
		//			// Обработать ошибку
		//			print("Error with REALM data : \(error)")
		//		}

	}

	class func getRealmObj (realmIn: Realm?) -> Realm? {

		var realm: Realm?

		do {

			if realmIn == nil {
				realm = try Realm()
			} else {
				realm = realmIn!
			}

			//return realm

		} catch let error as NSError {
			// Обработать ошибку
			print("Error with REALM data : \(error)")
		}
		
		return realm
	}
	
}
