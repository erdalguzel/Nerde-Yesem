import Foundation
import UIKit
import CoreLocation

extension RestaurantTableViewController {
	// MARK: - Tableview delegate methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return nearby_restaurants.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
		cell.restaurantName.text = nearby_restaurants[indexPath.row].restaurant.name
		let rating = nearby_restaurants[indexPath.row].restaurant.userRating.ratingObj.title.text
		cell.restaurantRating.text = (rating == "-") ? "0.0" : rating
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let urlWebView = storyboard?.instantiateViewController(withIdentifier: "RestaurantInfoViewController") as! RestaurantInfoViewController
		let restaurantUrl = nearby_restaurants[indexPath.row].restaurant.url!
		let url = URL(string: restaurantUrl)
		guard let restaurantUrlString = url else {
			let alert = UIAlertController(title: "Restaurant link does not exist", message: "No associated link was found to redirect you to this restaurants web page", preferredStyle: .alert)
			let action = UIAlertAction(title: "OK", style: .default, handler: nil)
			alert.addAction(action)
			self.present(alert, animated: true, completion: nil)
			return
		}
		urlWebView.loadedUrl = restaurantUrlString
		self.present(urlWebView, animated: true, completion: nil)
	}
}

// MARK: - Core Location extension
extension RestaurantTableViewController {
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
	}
}
