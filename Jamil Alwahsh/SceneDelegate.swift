//
//  SceneDelegate.swift
//  Jamil Alwahsh
//
//  Created by Abdalqader Alwahsh on 26/07/2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // MARK: - Scene Life Cycle
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
            
        let window = UIWindow(windowScene: windowScene)
        let memorialVC = MemorialViewController()
        let navigationController = UINavigationController(rootViewController: memorialVC)
        
        navigationController.isNavigationBarHidden = true
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
//        let duaasList = [
//            "اللهم اغفر له وارحمه وعافه واعف عنه، وأكرم نزله ووسع مدخله.",
//            "اللهم أبدله داراً خيراً من داره، وأهلاً خيراً من أهله، وأدخله الجنة.",
//            "اللهم اجعل قبره روضة من رياض الجنة، ولا تجعله حفرة من حفر النار.",
//            "اللهم انقله من مواطن الدود وضيق اللحود إلى جنات الخلود.",
//            "اللهم آنسه في وحدته، وفي وحشته، وفي غربته.",
//            "اللهم يمن كتابه، ويسر حسابه، وثقل بالحسنات ميزانه.",
//            "اللهم اجعله في بطن القبر مطمئناً، وعند قيام الأشهاد آمناً."
//        ]
//        NotificationManager.shared.scheduleDuaasEveryTenMinutes(duaas: duaasList)
    }
}
