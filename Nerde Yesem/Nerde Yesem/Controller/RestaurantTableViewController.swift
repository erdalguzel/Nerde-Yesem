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
