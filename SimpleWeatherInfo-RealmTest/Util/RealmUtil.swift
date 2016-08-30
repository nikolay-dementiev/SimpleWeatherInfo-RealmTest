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
	}

	class func saveRealmObject (realmIn: Realm?, object: Object?) {

		guard object != nil else { return }

		if let tmpRealm = RealmUtil.getRealmObj(realmIn) {

			try! tmpRealm.write {
				tmpRealm.add(object!, update: true)
			}
		}
	}

	class func getRealmObj (realmIn: Realm?) -> Realm? {

		var realm: Realm?

		do {

			if realmIn == nil {
				realm = try Realm()
			} else {
				realm = realmIn!
			}

		} catch let error as NSError {

			print("Error with REALM: \(error)")
		}

		return realm
	}

}
