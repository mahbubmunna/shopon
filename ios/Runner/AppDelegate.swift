import UIKit
import Flutter
import GoogleMaps

// Change this key to a valid key registered with the demo app bundle id.
let mapsAPIKey = "AIzaSyB47znSzgNH60kXP4lSPvP7SuWhLlwuDIk"

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    if mapsAPIKey.isEmpty {
     fatalError("Please provide an API Key using mapsAPIKey")
    }
    GMSServices.provideAPIKey("AIzaSyA3QP4RoE11k6vz39CrM5QySo-yNOY4eL4")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
