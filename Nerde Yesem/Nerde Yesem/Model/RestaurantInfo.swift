import Foundation

// MARK: - Welcome
struct Welcome: Decodable {
	var location: WelcomeLocation
	var popularity: Popularity
	var link: String
	var nearbyRestaurants: [NearbyRestaurant]
	
	enum CodingKeys: String, CodingKey {
		case location, popularity, link
		case nearbyRestaurants = "nearby_restaurants"
	}
	
	init() {
		location = WelcomeLocation()
		popularity = Popularity()
		link = ""
		nearbyRestaurants = []
	}
}

// MARK: - WelcomeLocation
struct WelcomeLocation: Decodable {
	var entityType: String
	var entityID: Int
	var title, latitude, longitude: String
	var cityID: Int
	var cityName: String
	var countryID: Int
	var countryName: String
	
	enum CodingKeys: String, CodingKey {
		case entityType = "entity_type"
		case entityID = "entity_id"
		case title, latitude, longitude
		case cityID = "city_id"
		case cityName = "city_name"
		case countryID = "country_id"
		case countryName = "country_name"
	}
	
	init() {
		entityID = 0
		entityType = ""
		title = ""
		latitude = ""
		longitude = ""
		cityID = 0
		cityName = ""
		countryID = 0
		countryName = ""
	}
}

// MARK: - NearbyRestaurant
struct NearbyRestaurant: Decodable {
	var restaurant: Restaurant
}

// MARK: - Restaurant
struct Restaurant: Decodable {
	var r: R
	var apikey, id, name: String
	var url: String?
	var location: RestaurantLocation
	var switchToOrderMenu: Int
	var cuisines: String
	var averageCostForTwo, priceRange: Int
	var currency: String
	var offers: [JSONAny]
	var opentableSupport, isZomatoBookRes: Int
	var mezzoProvider: String
	var isBookFormWebView: Int
	var bookFormWebViewURL, bookAgainURL, thumb: String
	var userRating: UserRating
	var photosURL, menuURL: String
	var featuredImage: String
	var hasOnlineDelivery, isDeliveringNow: Int
	var includeBogoOffers: Bool
	var deeplink: String
	var isTableReservationSupported, hasTableBooking: Int
	var eventsURL: String
	
	enum CodingKeys: String, CodingKey {
		case r = "R"
		case apikey, id, name, url, location
		case switchToOrderMenu = "switch_to_order_menu"
		case cuisines
		case averageCostForTwo = "average_cost_for_two"
		case priceRange = "price_range"
		case currency, offers
		case opentableSupport = "opentable_support"
		case isZomatoBookRes = "is_zomato_book_res"
		case mezzoProvider = "mezzo_provider"
		case isBookFormWebView = "is_book_form_web_view"
		case bookFormWebViewURL = "book_form_web_view_url"
		case bookAgainURL = "book_again_url"
		case thumb
		case userRating = "user_rating"
		case photosURL = "photos_url"
		case menuURL = "menu_url"
		case featuredImage = "featured_image"
		case hasOnlineDelivery = "has_online_delivery"
		case isDeliveringNow = "is_delivering_now"
		case includeBogoOffers = "include_bogo_offers"
		case deeplink
		case isTableReservationSupported = "is_table_reservation_supported"
		case hasTableBooking = "has_table_booking"
		case eventsURL = "events_url"
	}
}

// MARK: - RestaurantLocation
struct RestaurantLocation: Decodable {
	var address, locality, city: String
	var cityID: Int
	var latitude, longitude, zipcode: String
	var countryID: Int
	var localityVerbose: String
	
	enum CodingKeys: String, CodingKey {
		case address, locality, city
		case cityID = "city_id"
		case latitude, longitude, zipcode
		case countryID = "country_id"
		case localityVerbose = "locality_verbose"
	}
}


// MARK: - R
struct R: Decodable {
	var hasMenuStatus: HasMenuStatus
	var resID: Int
	
	enum CodingKeys: String, CodingKey {
		case hasMenuStatus = "has_menu_status"
		case resID = "res_id"
	}
}


// MARK: - HasMenuStatus
struct HasMenuStatus: Decodable {
	var delivery, takeaway: Int
}

// MARK: - UserRating
struct UserRating: Decodable {
	var aggregateRating: AggregateRating
	var ratingText, ratingColor: String
	var ratingObj: RatingObj
	var votes: AggregateRating
	
	enum CodingKeys: String, CodingKey {
		case aggregateRating = "aggregate_rating"
		case ratingText = "rating_text"
		case ratingColor = "rating_color"
		case ratingObj = "rating_obj"
		case votes
	}
}

enum AggregateRating: Decodable {
	case integer(Int)
	case string(String)
	
	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if let x = try? container.decode(Int.self) {
			self = .integer(x)
			return
		}
		if let x = try? container.decode(String.self) {
			self = .string(x)
			return
		}
		throw DecodingError.typeMismatch(AggregateRating.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AggregateRating"))
	}
}
// MARK: - RatingObj
struct RatingObj: Decodable {
	var title: Title
	var bgColor: BgColor
	
	enum CodingKeys: String, CodingKey {
		case title
		case bgColor = "bg_color"
	}
}

// MARK: - BgColor
struct BgColor: Decodable {
	var type, tint: String
}

// MARK: - Title
struct Title: Decodable {
	var text: String
}

// MARK: - Popularity
struct Popularity: Decodable {
	var popularity: String?
	var nightlifeIndex: String?
	var nearbyRes: [String]?
	var topCuisines: [String]
	var popularityRes, nightlifeRes, subzone: String
	var subzoneID: Int
	var city: String
	
	enum CodingKeys: String, CodingKey {
		case popularity = "popularity"
		case nightlifeIndex = "nightlife_index"
		case nearbyRes = "nearby_res"
		case topCuisines = "top_cuisines"
		case popularityRes = "popularity_res"
		case nightlifeRes = "nightlife_res"
		case subzone
		case subzoneID = "subzone_id"
		case city
	}
	
	init() {
		popularity = ""
		nightlifeRes = ""
		nightlifeIndex = ""
		nearbyRes = []
		topCuisines = []
		popularityRes = ""
		nightlifeRes = ""
		subzone = ""
		subzoneID = 0
		city = ""
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		if let value = try? container.decode(Int.self, forKey: .popularity) {
			popularity = String(value)
		} else {
			popularity = try container.decode(String.self, forKey: .popularity)
		}
		
		if let value = try? container.decode(Int.self, forKey: .nightlifeIndex) {
			nightlifeIndex = String(value)
		} else {
			nightlifeIndex = try container.decode(String.self, forKey: .nightlifeIndex)
		}
		nearbyRes = try container.decode([String].self, forKey: .nearbyRes)
		topCuisines = try container.decode([String].self, forKey: .topCuisines)
		popularityRes = try container.decode(String.self, forKey: .popularityRes)
		nightlifeRes = try container.decode(String.self, forKey: .nightlifeRes)
		subzone = try container.decode(String.self, forKey: .subzone)
		subzoneID = try container.decode(Int.self, forKey: .subzoneID)
		city = try container.decode(String.self, forKey: .city)
	}
}

// MARK: - Helper functions for creating decoder

func newJSONDecoder() -> JSONDecoder {
	let decoder = JSONDecoder()
	if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
		decoder.dateDecodingStrategy = .iso8601
	}
	return decoder
}


// MARK: - URLSession response handlers

extension URLSession {
	fileprivate func codableTask<T: Decodable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		return self.dataTask(with: url) { data, response, error in
			guard let data = data, error == nil else {
				completionHandler(nil, response, error)
				return
			}
			completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
		}
	}
	
	func welcomeTask(with url: URL, completionHandler: @escaping (Welcome?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		return self.codableTask(with: url, completionHandler: completionHandler)
	}
}

// MARK: - Encode/decode helpers

class JSONNull: Decodable, Hashable {
	
	public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
		return true
	}
	
	public var hashValue: Int {
		return 0
	}
	
	public init() {}
	
	public required init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if !container.decodeNil() {
			throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
		}
	}
}

class JSONCodingKey: CodingKey {
	let key: String
	
	required init?(intValue: Int) {
		return nil
	}
	
	required init?(stringValue: String) {
		key = stringValue
	}
	
	var intValue: Int? {
		return nil
	}
	
	var stringValue: String {
		return key
	}
}

class JSONAny: Decodable {
	
	let value: Any
	
	static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
		let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
		return DecodingError.typeMismatch(JSONAny.self, context)
	}
	
	
	static func decode(from container: SingleValueDecodingContainer) throws -> Any {
		if let value = try? container.decode(Bool.self) {
			return value
		}
		if let value = try? container.decode(Int64.self) {
			return value
		}
		if let value = try? container.decode(Double.self) {
			return value
		}
		if let value = try? container.decode(String.self) {
			return value
		}
		if container.decodeNil() {
			return JSONNull()
		}
		throw decodingError(forCodingPath: container.codingPath)
	}
	
	static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
		if let value = try? container.decode(Bool.self) {
			return value
		}
		if let value = try? container.decode(Int64.self) {
			return value
		}
		if let value = try? container.decode(Double.self) {
			return value
		}
		if let value = try? container.decode(String.self) {
			return value
		}
		if let value = try? container.decodeNil() {
			if value {
				return JSONNull()
			}
		}
		if var container = try? container.nestedUnkeyedContainer() {
			return try decodeArray(from: &container)
		}
		if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
			return try decodeDictionary(from: &container)
		}
		throw decodingError(forCodingPath: container.codingPath)
	}
	
	static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
		if let value = try? container.decode(Bool.self, forKey: key) {
			return value
		}
		if let value = try? container.decode(Int64.self, forKey: key) {
			return value
		}
		if let value = try? container.decode(Double.self, forKey: key) {
			return value
		}
		if let value = try? container.decode(String.self, forKey: key) {
			return value
		}
		if let value = try? container.decodeNil(forKey: key) {
			if value {
				return JSONNull()
			}
		}
		if var container = try? container.nestedUnkeyedContainer(forKey: key) {
			return try decodeArray(from: &container)
		}
		if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
			return try decodeDictionary(from: &container)
		}
		throw decodingError(forCodingPath: container.codingPath)
	}
	
	static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
		var arr: [Any] = []
		while !container.isAtEnd {
			let value = try decode(from: &container)
			arr.append(value)
		}
		return arr
	}
	
	static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
		var dict = [String: Any]()
		for key in container.allKeys {
			let value = try decode(from: &container, forKey: key)
			dict[key.stringValue] = value
		}
		return dict
	}
	
	public required init(from decoder: Decoder) throws {
		if var arrayContainer = try? decoder.unkeyedContainer() {
			self.value = try JSONAny.decodeArray(from: &arrayContainer)
		} else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
			self.value = try JSONAny.decodeDictionary(from: &container)
		} else {
			let container = try decoder.singleValueContainer()
			self.value = try JSONAny.decode(from: container)
		}
	}
}
