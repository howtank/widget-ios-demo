//
//  ViewController.swift
//  Howtank Widget Sample
//
//  Created by Damien Dorizy on 26/01/2018.
//  Copyright © 2018 Howtank. All rights reserved.
//

import UIKit
import HowtankWidgetSwift

class ViewController: UIViewController, HowtankWidgetDelegate {
    
    // Please replace by your HOST_ID (or HOST_MNEMONIC) here:
    private let hostId = "shire"
    private let sandbox = true
    private let verbose = true

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var actionsTextView: UITextView!
    @IBOutlet var infoLabels: [UILabel]!
    @IBOutlet weak var actionsStackView: UIStackView!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sample initialization
        actionsTextView.text = ""
        infoLabels.forEach { (label) in
            label.numberOfLines = 2
        }
        actionsStackView.isHidden = true
        
        initWidget()
    }
    
    
    // MARK: - Buttons actions

    /// Inits the widget. This has to be called before "setDiscreet". Usual behavior is to add this in the "AppDelegate" class file
    private func initWidget() {
        HowtankWidget.shared
            .verboseMode(verbose) // verbose mode (more debug logs) - default is false
            .usingSandboxPlatform(sandbox) // use sandbox platform or not (default is false)
//            .customFont(fontName: "My Font", boldFontName: nil) // set custom font if needed
//            .customImages(inactiveImage: UIImage(named: ""), activeImage: UIImage(named: "")) // custom bubble images
            .configure(hostId: hostId, delegate: self)
        appendText(text: "Widget is initialized for host id '\(hostId)' using sandbox: \(sandbox)")
    }
    
    /// Shows the widget at the default position. Typically, this method is called on each view controller
    @IBAction func showDefaultPosition(_ sender: Any) {
        HowtankWidget.shared.browse(show: true, pageName: "Page with default position", pageUrl: "https://c1.howtank.com/default")
    }
    
    /// Shows the widget at a custom position. Typically, this method is called on each view controller
    @IBAction func showCustomPosition(_ sender: Any) {
        // Position is a string with following margins: "top right bottom left". Always fill 2 margins and put "-" for others
        HowtankWidget.shared.browse(show: true, pageName: "Page with custom position", pageUrl: "https://c1.howtank.com/custom", position: "10 10 - -")
    }
    
    /// Hides the widget. Typically, this method is called on a new view controller
    @IBAction func hide(_ sender: Any) {
        // The widget won't be hidden if a conversation is already started
        HowtankWidget.shared.browse(show: false, pageName: "Page with hidden widget", pageUrl: "https://c1.howtank.com/hidden", position: "10 10 - -")
    }
    
    @IBAction func clearLogs(_ sender: Any) {
        actionsTextView.text = ""
    }
    
    @IBAction func openWidget(_ sender: Any) {
        // Forces the widget to open, wether it's hidden or displayed
        HowtankWidget.shared.open()
        
        // You can also call the "collapse" method to force close the widget window
//        HowtankWidget.shared.collapse()
        
        // Also, you can use the methods "disable" or "enable" to disable the widget
//        HowtankWidget.shared.disable()
    }
    
    /// This method must be triggered when a conversion is made on the app (purchase, action...). Purchase parameters are optional
    @IBAction func widgetConversion(_ sender: Any) {
        let purchaseParameters = PurchaseParameters(newBuyer: true, purchaseId: "123456", valueAmount: 12.3, valueCurrency: ValueCurrency.euro)
        
        HowtankWidget.shared.conversion(name: "purchase", purchaseParameters: purchaseParameters)
    }
    
    
    
    
    // MARK: - HowtankWidgetDelegate methods
    
    func widgetEvent(event: WidgetEventType, paramaters: [String : Any]?) {
        switch event {
            
        // Called when the user sends a first message in the widget
        case .calledInterlocutor:
            appendText(text: "A message has been sent - interlocutor called")
            
        // Called when the widget is not available. Most of the time, because there are not enough users connected on the platform
        case .unavailable:
            appendText(text: "Howtank widget is not available: \(paramaters)")
            
        case .initialized:
            appendText(text: "Widget is initialized")
            self.actionsStackView.isHidden = false
            
        case .opened:
            appendText(text: "Widget is opened")
            
        case .disabled:
            appendText(text: "Widget disabled")
            
        case .displayed:
            appendText(text: "Widget is displayed")
            
        case .hidden:
            appendText(text: "Widget is hidden")
            
        // Called when a link has been selected in the widget. Your application can handle the selected link (either with deep linking or by opening the browser
        case .linkSelected:
            appendText(text: "Link selected \(paramaters)")
            
        // Called when the chat widget has been closed
        case .closed:
            appendText(text: "Chat widget was closed by user. Conversation is closed? : \(paramaters)")
            
        case .scoringInterlocutor:
            appendText(text: "Score screen is prompted (for client service members)")
            
        case .scoredInterlocutor:
            appendText(text: "Interlocutor was scored with note \(paramaters)")
            
        case .thankingInterlocutor:
            appendText(text: "Thanks screen is prompted (for communiuty members)")
            
        case .thankedInterlocutor:
            appendText(text: "Interlocutor was thanked")
            
        }
    }
    
    func widgetShouldClose(message: String, closeCallback: @escaping () -> Void) -> Bool {
        let customAlert = UIAlertController(title: "Custom close alert", message: message, preferredStyle: .alert)
        customAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action) in
            // Calling 'closeCallback()' will close the chat widget
            closeCallback()
        }))
        customAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Alert has to be displayed in a new window since the widget is already on top
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.windowLevel = UIWindowLevelAlert + 1
        window.makeKeyAndVisible()
        window.rootViewController?.present(customAlert, animated: true, completion: nil)
        
        // Returning true mean this method has been implemented
        return true
    }
    
    
    // MARK: - Utility methods
    
    private func appendText(text: String) {
        actionsTextView.text = actionsTextView.text + "- " + text + "\n"
        let stringLength:Int = self.actionsTextView.text.count
        self.actionsTextView.scrollRangeToVisible(NSMakeRange(stringLength-1, 0))
    }
    
}

