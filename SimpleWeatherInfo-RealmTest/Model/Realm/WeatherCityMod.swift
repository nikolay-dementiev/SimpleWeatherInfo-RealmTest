////
////  WeatherCityMod.swift
////  SimpleWeatherInfo-RealmTest
////
////  Created by Nikolay Dementiev on 24.08.16.
////  Copyright © 2016 mc373. All rights reserved.
////
//
//import RealmSwift
//import SwiftyJSON
//import ObjectMapper
//
//class WeatherCityMod: Object, Mappable {
//
////	var realmInstance:RealmUtil? = nil
//
//	dynamic var uuid: String? = ""
//	dynamic var id: Int = 0
//	dynamic var name: String? = ""
//	dynamic var country: String? = ""
//	let coordLon = RealmOptional<Double>()
//	let coordLat = RealmOptional<Double>()
//	dynamic var dateOfCreation: NSDate?
//
//
//	//MARK: Create Realm Obj. from JSON
//	class func createObject<T> (json: T) -> WeatherCityMod? {
//		var valueToReturn: WeatherCityMod?
//		//convert the JSON to a raw String // from SwiftyJSON
//
//		var jsonString: String?
//
//		if json is JSON {
//				jsonString = (json as! JSON).rawString()
//		} else if json is String {
//			jsonString = json as? String
//		} else {
//			jsonString = ""
//		}
//
//		//if let jsonString = json.rawString() {
//			valueToReturn = Mapper<WeatherCityMod>().map(jsonString)
//		//}
//		return valueToReturn
//	}
//
//
//	//MARK: Internal function of class
//
//	override static func primaryKey() -> String? {
//		return "id"
//	}
//
//	override static func indexedProperties() -> [String] {
//		return ["uuid,id,dateOfCreation"]
//	}
//
//	required convenience init?(_ map: Map) {
//		self.init()
//	}
//
//	func mapping(map: Map) {
//		id							<- map["id"]
//		dateOfCreation	= NSDate()
//		name						<- map["name"]
//		country					<- map["sys.country"]
//		coordLon.value	<- map["coord.lon"]
//		coordLat.value	<- map["coord.lat"]
//
//		uuid						= NSUUID().UUIDString
//
////		realmInstance?.saveCurrentObject(self)
////		RealmUtil.saveRealmObject(realmInstance?.realm, object: self)
//	}
//
//}
