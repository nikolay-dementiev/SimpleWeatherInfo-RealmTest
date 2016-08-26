//
//  WeatherCityMod.swift
//  SimpleWeatherInfo-RealmTest
//
//  Created by Nikolay Dementiev on 24.08.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import RealmSwift
import SwiftyJSON
import ObjectMapper

class WeatherCityMod: Object, Mappable {

//	var realmInstance:RealmUtil? = nil

	dynamic var _id: Int = 0
	dynamic var name: String? = ""
	dynamic var country: String? = ""
	let coordLon = RealmOptional<Double>()
	let coordLat = RealmOptional<Double>()


	//MARK: Create Realm Obj. from JSON
	class func createObject<T> (json: T) -> WeatherCityMod? {
		var valueToReturn: WeatherCityMod?
		//convert the JSON to a raw String // from SwiftyJSON

		var jsonString: String?

		if json is JSON {
				jsonString = (json as! JSON).rawString()
		} else if json is String {
			jsonString = json as? String
		} else {
			jsonString = ""
		}

		//if let jsonString = json.rawString() {
			valueToReturn = Mapper<WeatherCityMod>().map(jsonString)
		//}
		return valueToReturn
	}


	//MARK: Internal function of class

//	override static func ignoredProperties() -> [String] {
//		return ["realmInstance"]
//	}

	func primaryKey() -> String? {
		return "_id"
	}

	required convenience init?(_ map: Map) {
		self.init()
	}

	func mapping(map: Map) {
		_id							<- map["id"]
		name						<- map["name"]
		country					<- map["sys.country"]
		coordLon.value	<- map["coord.lon"]
		coordLat.value	<- map["coord.lat"]

//		realmInstance?.saveCurrentObject(self)
	}



}
