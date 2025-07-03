

import Foundation
import SwiftUI

enum Category: String, CaseIterable {
    
    case аптека
    case магазин
    //case онлайнпокупки
    case спорт
    case ипотека
    case отдых
    case ресторан
    case развлечения
    case платежи
    case автомобиль
    case другое

    var systemNameIcon: String {
        switch self {
        case .аптека: return "cross.circle.fill"
        case .магазин: return "cart.fill.badge.plus"
        //case .онлайнпокупки: return "cart"
        case .спорт: return "dumbbell"
        case .ипотека: return "dollarsign.gauge.chart.lefthalf.righthalf"
        case .отдых: return "airplane"
        case .ресторан: return "fork.knife.circle"
        case .развлечения: return "gamecontroller.circle.fill"
        case .платежи: return "creditcard"
        case .автомобиль: return "car"
        case .другое: return "ellipsis"
        }
    }

    var color: Color {
        switch self {
        case .аптека: return Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
        case .магазин: return Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
        //case .онлайнпокупки: return Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        case .спорт: return Color(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1))
        case .ипотека: return Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        case .отдых: return Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))
        case .ресторан: return Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        case .развлечения: return Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        case .платежи: return Color(#colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1))
        case .автомобиль: return Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        case .другое: return Color(#colorLiteral(red: 0.5365451574, green: 0.2724784315, blue: 0.2074103653, alpha: 1))
        }
    }
}

extension Category: Identifiable {
    var id: String { rawValue }
}
