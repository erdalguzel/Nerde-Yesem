import UIKit
import WebKit

class RestaurantInfoViewController: UIViewController {
	
	// MARK: IBOutlet
	@IBOutlet weak var restaurantWebView: WKWebView!
	var loadedUrl: URL? = URL(string: "")
	
	// MARK: Lifecycle functions
	override func viewDidLoad() {
		super.viewDidLoad()
		let request = URLRequest(url: self.loadedUrl!)
		restaurantWebView.load(request)
	}
	
	@IBAction func shareMedia(_ sender: UIBarButtonItem) {
        	let activityVC = UIActivityViewController(activityItems: [loadedUrl!], applicationActivities: nil)
        	activityVC.popoverPresentationController?.sourceView = self.view
       		self.present(activityVC, animated: true, completion: nil)
    	}
}
