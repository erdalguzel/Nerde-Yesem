import UIKit
import Foundation
import CoreLocation

class RestaurantTableViewController: UITableViewController, CLLocationManagerDelegate {
	
	// MARK: - Variables
	
	let apiKey: String = "e06745d59aa6170842e9760500129d63"
	let cellIdentifier: String = "restaurantCell"
	var restaurantImages: [URL] = []
	var locationManager = CLLocationManager()
	var restInfoVC = RestaurantInfoViewController()
	var nearby_restaurants = [NearbyRestaurant]()
	
	// MARK: - Lifecycle methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		
		let urlString = """
		https://developers.zomato.com/api/v2.1/geocode?lat=\(Double((locationManager.location?.coordinate.latitude)!))&lon=\(Double((locationManager.location?.coordinate.longitude)!))
		"""
		let url = URL(string: urlString)
		
		
		if url != nil {
			var request = URLRequest(url: url!)
			request.httpMethod = "GET"
			request.addValue("application/json", forHTTPHeaderField: "Accept")
			request.addValue(apiKey, forHTTPHeaderField: "user-key")
			
			URLSession.shared.dataTask(with: request) { (data, response, error) in
				guard let data = data, error == nil else { return }
				let httpResponse = response as! HTTPURLResponse
				
				if httpResponse.statusCode == 200 {
					do {
						let decoder = JSONDecoder()
						let welcome = try decoder.decode(Welcome.self, from: data)
						self.nearby_restaurants = welcome.nearbyRestaurants
						DispatchQueue.main.async {
							self.tableView.reloadData()
						}
					} catch {
						print("Error is: \(error)")
					}
				}
			}.resume()
		}
	}
	
	// MARK: - Segue methods
	@IBAction func showRestaurants(_ sender: UIBarButtonItem) {
		self.performSegue(withIdentifier: "showRestaurants", sender: self)
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let restaurantTableVC = segue.destination as? RestaurantTableViewController {
			self.present(restaurantTableVC, animated: true, completion: nil)
		}
	}
}

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

// MARK: Core Location extension
extension RestaurantTableViewController {
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
	}
}
