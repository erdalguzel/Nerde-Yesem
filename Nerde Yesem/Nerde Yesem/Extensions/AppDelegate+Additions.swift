import Foundation
import CoreLocation
import LocalAuthentication
import UIKit

// MARK: Touch ID extension
extension AppDelegate {
	func authenticateUser() {
		let context = LAContext()
		var error: NSError?
		
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			let reason = "Authenticate with Touch ID"
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
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
	
	func setupLocationManager() {
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.startUpdatingLocation()
	}
}
