//
//  TipView.swift
//  TrackMoney
//
//  Created by  aleksandr on 6/29/25.
//
import Foundation
import TipKit

struct InfoButtonDashboard: Tip {
    var title: Text {
        Text("Здесь будут отображаться ваши расходы")
            .foregroundStyle(.teal)
    }
    
    var message: Text? {
        Text("что бы добавить перейдите в следующую вкладку")
    }
    
    var image: Image? {
        //Image(systemName: "exclamationmark.triangle")
        Image("расходы")
    }
}


struct InfoButtonLogs: Tip {
    
//    static let setLogs = Event(id: "setLogsPlus")
//    static let infoLogs = Event(id: "infoLogsPlus")
    
    var title: Text {
        Text("Кнопка добавить расходы")
            .foregroundStyle(.teal)
    }
    
    var message: Text? {
        Text("нажмите что бы добавить запись и настроить")
    }
    
    var image: Image? {
        Image( "plus")
    }
//    var rules: [Rule] {
//        #Rule(Self.setLogs) { event in
//            event.donations.count == 0
//        }
//        #Rule(Self.infoLogs) { event in
//            event.donations.count > 2
//        }
//        
//    }
}

struct InfoButtonNoItems: Tip {
   
    
    
        var title: Text {
            Text("кнопка добавить заметку")
                .foregroundStyle(.teal)
        }
        
        var message: Text? {
            Text("здесь будут отображаться ваши заметки ")
        }
        
        var image: Image? {
            Image("warning")
        }
    }
