import Foundation
import CoreLocation
import LocalAuthentication
import UIKit

// MARK: - LocalAuthentication extension
extension AppDelegate {
	func authenticateUser() {
		let context = LAContext()
		var error: NSError?
		
		if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
			let reason = "Authenticate with Touch ID"
			context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason, reply:
				{(success, error) in
					if success {
						self.alertUser("You have successfully logged in!", "Touch ID Authentication Succeeded")
					}
					else {
						self.alertUser("You have failed logging in with Touch ID!", "Touch ID Authentication Failed")
					}
			})
		}
		else {
			self.alertUser("Your device does not support Touch ID!", "Touch ID is not available")
		}
	}
	
	func alertUser(_ message: String, _ title: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default, handler: nil)
		alert.addAction(action)
		DispatchQueue.main.async {
			self.window?.rootViewController?.present(alert, animated: true, completion: nil)
		}
	}
}

// MARK: - Core Location Delegate extension
extension AppDelegate {
	func setupLocationManager() {
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.startUpdatingLocation()
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .denied:
		self.alertUser("Please turn on location services to get the best experience", "Turn on location services")
		case .notDetermined:
		self.alertUser("For some reason we cannot determine location usage. App may not function normally in this state.", "Location usage not determined")
		case .restricted:
		self.alertUser("Location usage is restricted right not. App may not function normally in this state.", "Location usage is restricted")
		default:
		break
		}
	}
}
