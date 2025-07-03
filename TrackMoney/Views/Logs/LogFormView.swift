//
//  LogFormView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData

struct LogFormView: View {
    let offColor = Color("SetColorMenu")
    let colorMenuColor = Color("AccentColor")
    var logToEdit: ExpenseLog?
    var context: NSManagedObjectContext
    
    @State var name: String = ""
    @State var amount: Double = 0
    @State var category: Category = .развлечения
    @State var date: Date = Date()
    
    //let settingsColor = SettingsColorTip()
    
    @Environment(\.presentationMode)
    var presentationMode
    
    var title: String {
        logToEdit == nil ? "Создать расходы" : "Изменить расходы"
    }
    
    
    var body: some View {
        
        NavigationView {
            
            Form {
                TextField("Название", text: $name)
                    .disableAutocorrection(true)
                    .listRowBackground(Color("SetColorMenu"))
                
                TextField("сумма", value: $amount, formatter: Utils.numberFormatter)
                    .keyboardType(.numbersAndPunctuation)
                    .listRowBackground(Color("SetColorMenu"))
                
                Picker(selection: $category, label: Text("Категория")) {
                    ForEach(Category.allCases) { category in
                        Text(category.rawValue.capitalized).tag(category)
                    }
                }
                
                .listRowBackground(Color("SetColorMenu"))
                DatePicker(selection: $date, displayedComponents: .date) {
                    Text("Дата")
                }
                .listRowBackground(Color("SetColorMenu"))
            }

            .navigationBarItems(
                leading: Button(action: self.onCancelTapped) { Text("назад")   },
                
                trailing: Button(action: self.onSaveTapped) { Text("сохранить")}
            ).navigationBarTitle(title)
                .font(.custom("Osterbar", size: 25).bold())
                //.navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color("AccentColor"), for: .navigationBar)
                .font(.custom("Osterbar", size: 25).bold())
                //.toolbarBackground(.visible, for: .navigationBar)
                .listRowBackground(Color.clear)
            
                .listRowSeparator(.automatic)
                .foregroundColor(Color(.black))
            .scrollContentBackground(.hidden)
            .background(Color("AccentColor"))
        }
        .preferredColorScheme(.light)
    }
    
    private func onCancelTapped() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func onSaveTapped() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        let log: ExpenseLog
        if let logToEdit = self.logToEdit {
            log = logToEdit
        } else {
            log = ExpenseLog(context: self.context)
            log.id = UUID()
        }
        
        log.name = self.name
        log.category = self.category.rawValue
        log.amount = NSDecimalNumber(value: self.amount)
        log.date = self.date
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

struct LogFormView_Previews: PreviewProvider {
    static var previews: some View {
        let stack = CoreDataStack(containerName: "TrackMoney")
        return LogFormView(context: stack.viewContext)
    }
}
