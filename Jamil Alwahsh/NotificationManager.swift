import UserNotifications
import Foundation

class NotificationManager {
    
    // MARK: - Singleton
    static let shared = NotificationManager()
    
    private init() {}
    
    // MARK: - Permissions
    func requestPermission(duaas: [String]) {
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                print("Permission already granted. Scheduling notifications...")
                self.scheduleDuaasEveryTenMinutes(duaas: duaas)
            } else if settings.authorizationStatus == .notDetermined {
                center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                        print("Notification permission granted successfully. Scheduling...")
                        self.scheduleDuaasEveryTenMinutes(duaas: duaas)
                    } else if let error = error {
                        print("Error requesting authorization: \(error.localizedDescription)")
                    }
                }
            } else {
                print("Notifications denied in settings.")
            }
        }
    }

    // MARK: - Scheduling
    func scheduleDuaasEveryTenMinutes(duaas: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let shuffledDuaas = duaas.shuffled()
        let maxNotifications = 60
        
        for index in 0..<maxNotifications {
            let content = UNMutableNotificationContent()
            content.title = "دعاء لوالدي 🤍"
            
            print(duaas)
            let duaa = duaas[index % shuffledDuaas.count]
            content.body = duaa
            content.sound = .default

            let timeInterval = TimeInterval((index + 1) * 15 * 60)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            let request = UNNotificationRequest(identifier: "duaa_10min_\(index)", content: content, trigger: trigger)
            
            center.add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                }
            }
        }
        print("Successfully scheduled 60 notifications.")
    }
}
