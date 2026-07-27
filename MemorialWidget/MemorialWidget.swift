import WidgetKit
import SwiftUI

// 1. هيكل البيانات (البيانات اللي رح نعرضها)
struct SimpleEntry: TimelineEntry {
    let date: Date
    let daysPassed: Int
    let currentDuaa: String
}

// 2. مزود البيانات (كيف ومتى نجلب البيانات من الجسر)
struct Provider: TimelineProvider {
    
    // ⚠️ حط اسم الـ App Group تبعك هون
    let sharedDefaults = UserDefaults(suiteName: "group.com.wahsh.MemorialApp")
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), daysPassed: 11, currentDuaa: "اللهم اغفر له وارحمه.")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), daysPassed: 11, currentDuaa: "اللهم اغفر له وارحمه.")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        // قراءة البيانات من الجسر اللي عملناه بالتطبيق الأساسي
        let days = sharedDefaults?.integer(forKey: "sharedDaysPassed") ?? 0
        let duaa = sharedDefaults?.string(forKey: "sharedCurrentDuaa") ?? "اللهم اغفر له وارحمه، وعافه واعف عنه."
        
        print(days)
        print(duaa)
        
        let entry = SimpleEntry(date: Date(), daysPassed: days, currentDuaa: duaa)
        
        // نطلب من النظام تحديث الـ Widget كل ساعة مثلاً
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}

// 3. تصميم واجهة الـ Widget بـ SwiftUI
// 3. تصميم واجهة الـ Widget بـ SwiftUI
// 3. تصميم واجهة الـ Widget بـ SwiftUI
struct MemorialWidgetEntryView : View {
    var entry: Provider.Entry
    
    // 🚀 السطر السحري لمعرفة مكان عرض الـ Widget
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        
        // 1. تصميم شاشة القفل (المستطيل)
        case .accessoryRectangular:
            VStack(alignment: .leading, spacing: 4) {
                Text("دعاء لوالدي 🤍")
                    .font(.headline)
                Text(entry.currentDuaa)
                    .font(.caption)
                    .lineLimit(2)
            }
            // شاشة القفل تحتاج خلفية شفافة
            .containerBackground(for: .widget) { Color.clear }
            
        // 2. تصميم شاشة القفل (الدائري)
        case .accessoryCircular:
            VStack {
                Text("\(entry.daysPassed)")
                    .font(.headline)
                Text("يوماً")
                    .font(.caption2)
            }
            .containerBackground(for: .widget) { Color.clear }

        // 3. تصميم الشاشة الرئيسية (نفس تصميمك الأساسي)
        default:
            VStack(alignment: .center, spacing: 12) {
                HStack(spacing: 10) {
                    Image("father_photo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white.opacity(0.3), lineWidth: 1))
                    
                    Text("\(entry.daysPassed) يوماً في رحاب الله")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.cyan.opacity(0.9))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                }
                
                Divider().background(Color.white.opacity(0.2))
                
                Text(entry.currentDuaa)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.7)
                    .frame(maxHeight: .infinity)
            }
            .padding()
            .containerBackground(for: .widget) {
                LinearGradient(gradient: Gradient(colors: [
                    Color(red: 0.03, green: 0.06, blue: 0.12),
                    Color(red: 0.07, green: 0.10, blue: 0.18)
                ]), startPoint: .top, endPoint: .bottom)
            }
        }
    }
}// 4. الإعدادات الأساسية للـ Widget
@main
struct MemorialWidget: Widget {
    let kind: String = "MemorialWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MemorialWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("دعاء الوالد")
        .description("يعرض عداد الأيام ودعاء متجدد لوالدك رحمه الله.")
        // يدعم الحجم الصغير والمتوسط
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryRectangular, .accessoryCircular])
        // إلغاء الهوامش الافتراضية عشان الخلفية تعبي الشاشة
        .contentMarginsDisabled()
    }
}
