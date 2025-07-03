


import UIKit
import SwiftUI
import LocalAuthentication
import TipKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//    @State private var unlocked = false
//    @State private var text = "LOCKED"
    var window: UIWindow?
    
    var coreDataStack = CoreDataStack(containerName: "TrackMoney")

    override init() {
       // try? Tips.resetDatastore()
        try? Tips.configure()
        }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let contentView = LottieViewModel()
            .environment(\.managedObjectContext, coreDataStack.viewContext)
            //.onAppear(perform: authenticate)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
            
        }
    }

    
    
    
}

