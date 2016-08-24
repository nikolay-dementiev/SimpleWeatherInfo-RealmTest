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

	dynamic var _id: Int = 0
	dynamic var name: String? = ""
	dynamic var country: String? = ""
	let coordLon = RealmOptional<Double>()
	let coordLat = RealmOptional<Double>()


	//MARK: Create Realm Obj. from JSON
	class func createObject (json: JSON) -> WeatherCityMod? {
		var valueToReturn: WeatherCityMod?
		//convert the JSON to a raw String // from SwiftyJSON
		if let jsonString = json.rawString() {
			valueToReturn = Mapper<WeatherCityMod>().map(jsonString)
		}
		return valueToReturn
	}

	//MARK: Internal function of class

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
	}

}
