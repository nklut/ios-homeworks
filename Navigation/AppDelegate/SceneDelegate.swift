import UIKit
import FirebaseAuth

extension NSNotification {
    static var sceneDidBecomeActive: NSNotification.Name {
        NSNotification.Name("sceneDidBecomeActive")
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationCoordinator: NavigationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        
        // Network Request
//        let appConfiguration = AppConfiguration.allCases.randomElement() ?? .planet1
//        let nwManager = NetworkManager()
        
//         Error: An SSL error has occurred and a secure connection to the server cannot be made.
//         NetworkManager().request(for: appConfiguration) { result in
//        
//         Chuck Norris works...
//        nwManager.request(for: .testURL) { result in
//            
//            switch result {
//            case .success(let messageText):
//                DispatchQueue.main.async {
//                    print(messageText)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//                break
//            }
//        }
        
        // Login View delegate setup
        let loginViewController = LogInViewController()
        let factory = MyLoginFactory()
        loginViewController.loginDelegate = factory.makeLoginInspector()
        
        // Init coordinator tree
        navigationCoordinator = NavigationCoordinator(window: window)
        navigationCoordinator?.start()
        
        window.makeKeyAndVisible()
        self.window = window
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
        signOutWithCompletion { success in
                print("Sign out completed: \(success)")
            }

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        NotificationCenter.default.post(name: NSNotification.sceneDidBecomeActive, object: nil)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


