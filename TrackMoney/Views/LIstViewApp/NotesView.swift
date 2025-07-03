//
//  NotesView.swift
//  ExpenseTracker
//
//  Created by  aleksandr on 25.05.25.
//  Copyright © 2025 Alfian Losari. All rights reserved.
//

import SwiftUI



struct NotesView: View {
    let offColor = Color("SetColorMenu")
    let colorMenuColor = Color("AccentColor")
    @Binding var presentSideMenu: Bool
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some View {
        
        VStack{
//            HStack{
//                Button{
//                    presentSideMenu.toggle()
//                } label: {
//                    Image("menu")
//                        .resizable()
//                        .frame(width: 32, height: 32)
//                        .padding(.horizontal, 15)
//                }
//                Spacer()
//
//            }
            
            NavigationView {
                ListView()
                colorMenuColor
                .ignoresSafeArea()
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
            //.foregroundColor(.red)

        }
        .preferredColorScheme(.light)
        //.preferredColorScheme(.dark)
        //.background(.white)
        
    }
}

