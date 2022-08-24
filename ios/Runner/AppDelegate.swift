import UIKit
import Flutter
// import share

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // Handle Uninstalling font from Settings
        //         adds an observer of fontchange notification that will notify to the fontsChangedNotification() when there's a change.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(fontsChangedNotification(_:)),
            name: kCTFontManagerRegisteredFontsChangedNotification as NSNotification.Name,
            object: nil
        )
        
        //Creating the channel object on the native side taking binaryMessenger as the property of the RootViewController.
        // On android, it's the flutterView of the MainActivity.kt
        let controller: FlutterViewController = window!.rootViewController as! FlutterViewController
        let methodChannelObj = FlutterMethodChannel(name: "DDC.fontapp.com/installFont", binaryMessenger: controller.binaryMessenger)
        
        // The method that handles the invokeMethod() from the Flutter side
        methodChannelObj.setMethodCallHandler { (call: FlutterMethodCall, result: FlutterResult) -> Void in
            // This method is called on the UI Thread? Check Flutter docs.
            if (call.method == "installFont") {
                let fontFromFlutter = call.arguments as! String
                //print("The font variable from flutter is \(fontFromFlutter)")
                self.installFont(result: result, fontName: fontFromFlutter)
            } else if (call.method == "uninstallFont") {
                let fontToUninstall = call.arguments as! String
                //print("The font variable from flutter to uninstall is:  \(fontToUninstall)")
                self.uninstallFont(result: result, fontName: fontToUninstall)
            } else if (call.method == "getFonts") {
//                print("Getting Installed Fonts")
                let installedFonts = self.getInstalledFontsFromSystem()
                result(installedFonts);
            } else {
                result(FlutterMethodNotImplemented)
                return
            }
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // WHenever a font change happens, IOS listens to this event and returns a list of fonts currently installed.
    // The fontChangeNotificated calls this function as the handler.
    @objc func fontsChangedNotification(_ sender: Any) {
        // update font change notification
        //            print("Inside the objective-C function")
        
        // Using the reverse of MethodChannel - i.e From Native to Flutter
        let rootViewController : FlutterViewController = window!.rootViewController as! FlutterViewController
        let channelName = "com.ddc.font/Notification"
        let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: rootViewController.binaryMessenger)
        
        //            var result = [String]()
        
        DispatchQueue.main.async {
            //print("Sender is:\n\(sender)")
            //                guard let registeredDescriptors = CTFontManagerCopyRegisteredFontDescriptors(.persistent, true) as? [CTFontDescriptor]
            //                else { return }
            //
            //                //print("Registered Descriptors is : \(registeredDescriptors)")
            //
            //                for registeredDescriptor in registeredDescriptors {
            ////                    print("Inside the for loop")
            //                    //print("Each descriptor is: \(registeredDescriptor)")
            //
            //                    let fontAttributes = CTFontDescriptorCopyAttributes(registeredDescriptor)
            //                    let fontNativeDict = fontAttributes as? [String: AnyObject]
            //
            //                    //print("The font attribtes are: \(fontAttributes)")
            //                    let installedFont: String = fontNativeDict?["NSFontNameAttribute"] as! String
            ////                    print("The installed font is : \(installedFont)")
            //                    result.append(installedFont)
            //                }
            //
            //                //print("The final dictionary is: \(result)")
            //                let resultInString = result.joined(separator: "-")
            //                methodChannel.invokeMethod("fontInstallNotify", arguments: resultInString)
            
            let installedFonts = self.getInstalledFontsFromSystem();
            methodChannel.invokeMethod("fontInstallNotify", arguments: installedFonts);
            
        }
    }
    
    // Returns a list of fonts installed on the IOS System.
    func getInstalledFontsFromSystem() -> String {
        
        var result = [String]()
        
        guard let registeredDescriptors = CTFontManagerCopyRegisteredFontDescriptors(.persistent, true) as? [CTFontDescriptor]
        else { return "" }
        
        //print("Registered Descriptors is : \(registeredDescriptors)")
        
        for registeredDescriptor in registeredDescriptors {
            //                    print("Inside the for loop")
            //print("Each descriptor is: \(registeredDescriptor)")
            
            let fontAttributes = CTFontDescriptorCopyAttributes(registeredDescriptor)
            let fontNativeDict = fontAttributes as? [String: AnyObject]
            
            //print("The font attribtes are: \(fontAttributes)")
            let installedFont: String = fontNativeDict?["NSFontNameAttribute"] as! String
            //                    print("The installed font is : \(installedFont)")
            result.append(installedFont)
        }
        
        //print("The final dictionary is: \(result)")
        let resultInString = result.joined(separator: "-")
        
        
        return resultInString;
    }
    
    
    
    // This method is called from the methodCallHandler and calls the actual installation font function
    func installFont(result: FlutterResult, fontName: String) -> Void {
        if (installFont(of: fontName)) {
            result(true)
        } else {
            print("Error occurred while installing the font.")
        }
        
    }
    
    // called from methodCallHandler and calls actual uninstallation font func
    func uninstallFont(result: FlutterResult, fontName: String) -> Void {
        if (uninstallFont(of: fontName)) {
            result(true)
        } else {
            print("Error occurred while installing the font.")
        }
        
    }
    
    
    // The actual font installation helper function
    func installFont(of fontName: String) -> Bool {
        guard let fontToInstallUrl = Bundle.main.url(forResource: fontName, withExtension: "ttf") else {
            print("File Not Found")
            return false
        }
        
        let fontToInstallUrlArray = [fontToInstallUrl] as CFArray
        CTFontManagerRegisterFontURLs(fontToInstallUrlArray, .persistent, true, {(errors, done) -> Bool in
            if CFArrayGetCount(errors) > 0 {
                print(errors as Array)
                return false
            }
            
            if done {
                //print("Installation successful")
                return true
            }
            
            return true
        })
        
        return true
    }
    
    // Font uninstallation helper function
    func uninstallFont(of fontName: String) -> Bool {
        
        // Get the font resource URL
        guard let mainBundleUrl = Bundle.main.url(forResource: fontName, withExtension: "ttf") else {
            print("File Not Found")
            return false
        }
        
        //Prep for unregistering
        let fontToUninstall = [mainBundleUrl] as CFArray
        //Unregister the specified Font URL
        CTFontManagerUnregisterFontURLs(fontToUninstall, .persistent, {(errors, done) -> Bool in
            if CFArrayGetCount(errors) > 0 {
                print(errors as Array)
                return false
            }
            
            if done {
                //                print("Uninstall Successful la")
                return true
            }
            return true
        })
        return true
    }
}
