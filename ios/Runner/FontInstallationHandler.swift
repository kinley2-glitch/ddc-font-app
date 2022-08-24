import Foundation

// Handles sending events.
// the class must implement a stream controller interface consisting of
// onListen - called the first time a stream registered to listen to the stream's events
// this function gives you the eventSink variable
// which we will store in a property to use later when sending the events.
// onCancel - called when the last listener is deregistered from the Stream.


class FontInstallationHandler: NSObject, FlutterStreamHandler {
    private var _eventSink: FlutterEventSink?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        _eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        _eventSink = nil
        return nil
    }
    
    func fontInstallHandler() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(fontsChangedNotification(_:)),
            name: kCTFontManagerRegisteredFontsChangedNotification as NSNotification.Name,
            object: nil
        )
    }
    
    @objc func fontsChangedNotification(_ sender: Any) {
        // update font change notification
        print("Inside the objective-C function")
        DispatchQueue.main.async {
            //            print("Sender is:\n\(sender)")
            guard let registeredDescriptors = CTFontManagerCopyRegisteredFontDescriptors(.persistent, true) as? [CTFontDescriptor]
            else { return }
            
            //            print("Registered Descriptors is : \(registeredDescriptors)")
            
            for registeredDescriptor in registeredDescriptors {
                print("Inside the for loop")
                //                print("Each descriptor is: \(registeredDescriptor)")
                
                let fontAttributes = CTFontDescriptorCopyAttributes(registeredDescriptor)
                let fontNativeDict = fontAttributes as? [String: AnyObject]
                
                //                print("The font attribtes are: \(fontAttributes)")
                let installedFont: String = fontNativeDict?["NSFontNameAttribute"] as! String
                print("The installed font is : \(installedFont)")
                
            }
        }
        
    }
    
}
