import Foundation
import UserNotifications

final class LocalNotificationsService {
    
    func requestPermission() {
        Task {
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        }
    }
    
    func isPermited() async -> Bool {
        return await UNUserNotificationCenter.current().notificationSettings().authorizationStatus == .authorized
    }
    
    func regiserForLatestUpdatesIfPossible() {
        Task {
            if await isPermited() {
                let content = UNMutableNotificationContent()
                content.title = "Reminder"
                content.body = "Check the latest updates"
                content.sound = UNNotificationSound.default
                
                var dateComponents = DateComponents()
                dateComponents.hour = 19
                dateComponents.minute = 0
                dateComponents.second = 0
                let triger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                //let triger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triger)
                
                try await UNUserNotificationCenter.current().add(request)
            }
        }
    }
}
