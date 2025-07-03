//
//  AddView.swift
//  ExpenseTracker
//
//  Created by  aleksandr on 25.05.25.
//  Copyright © 2025 Alfian Losari. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    // MARK: PROPERTIES
    let offColor = Color("SetColorMenu")
    let colorMenuColor = Color("AccentColor")
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    init() {
        
        //UINavigationBar.appearance().backgroundColor = .yellow
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font : UIFont(name:"RubikDoodleShadow-Regular", size: 35)!]
        
    }
    // MARK: BODY
    
    var body: some View {
        
        ZStack{
            colorMenuColor
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    TextField("поле ввода", text: $textFieldText)
                        .font(.custom("Osterbar", size: 30))
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(20)
                    Spacer(minLength: 20)
                    Button(action: saveButtonPressed, label: {
                        
                        Text("Сохранить".uppercased())
                            .padding(.top, 5)
                            .font(.custom("Osterbar", size: 23).bold())
                            .foregroundColor(Color("AccentColor"))
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .frame(height: 45)
                            .frame(width: 150)
                            .background(Color("SetColorMenu"))
                            .cornerRadius(20)
                            //.buttonStyle(.glass)
                    })
                   
                }
                .padding(10)
                
            }
            
            .navigationTitle("Новая  заметка  ")
            .shadow(color: Color.black ,radius: 5)
            .font(.title)
            .fontWeight(.semibold)
            .alert(isPresented: $showAlert, content: getAlert)
        }
        
    }
        // MARK: FUNCTIONS
        
        func saveButtonPressed() {
            if textIsAppropriate() {
                listViewModel.addItem(title: textFieldText)
                presentationMode.wrappedValue.dismiss()
            }
        }
        
        func textIsAppropriate() -> Bool {
            if textFieldText.count < 3 {
                alertTitle = "  Введите текст!"
                showAlert.toggle()
                return false
            }
            return true
        }
        
        func getAlert() -> Alert {
            return Alert(title: Text(alertTitle))
        }
        
    }

    // MARK: PREVIEW

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.light)
            .environmentObject(ListViewModel())
            
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.light)
           // .preferredColorScheme(.dark)
            .environmentObject(ListViewModel())
            
        }
        
    }
}


//#Preview {
//    AddView()
//}
