//
//  ListView.swift
//  ExpenseTracker
//
//  Created by  aleksandr on 25.05.25.
//  Copyright © 2025 Alfian Losari. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    @State private var isStruckThrough = false
    
    let offColor = Color("SetColorMenu")
    let colorMenuColor = Color("AccentColor")
    @EnvironmentObject var listViewModel: ListViewModel
    init() {
        
        //UINavigationBar.appearance().backgroundColor = .yellow
        UINavigationBar.appearance().largeTitleTextAttributes = [
                .foregroundColor: UIColor.black,
                       .font : UIFont(name:"RubikDoodleShadow-Regular", size: 35)!]
        
    }
    
    var body: some View {
        ZStack {
            colorMenuColor
                .ignoresSafeArea()
            if listViewModel.items.isEmpty {
                NoItemsView()
                
                    .transition(AnyTransition.opacity.animation(.spring))
                    //.font(.custom("Osterbar", size: 25))
                    .cornerRadius(15)
                
            } else {
                List {
                    
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .font(.custom("Osterbar", size: 25))
                            .listRowSeparator(.hidden)
           
                            .strikethrough(item.isCompleted, color: .red)
                            .bold()
                            
                        
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                        
                                }
               
                            }
                 
                    }
                    
               
                    
                   .onDelete(perform: listViewModel.deleteItem)
                  
                       
                  
                    
                    
                    .onMove(perform: listViewModel.moveItem)
                    .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
                    //.font(.custom("Osterbar", size: 25))
                    .listRowBackground(Color.clear)
             
                    .listRowSeparator(.automatic)
                    
                    .foregroundColor(Color(.black))
                    //.font(.custom("Osterbar", size: 25))
                   
                
                .scrollContentBackground(.hidden)
                .background(Color("SetColorMenu"))
                .cornerRadius(10)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
                .cornerRadius(10)
                .listStyle(PlainListStyle())
                
               // .clipShape(RoundedRectangle(cornerRadius: 10))
                .navigationTitle("Мои  заметки ")
                
                //.foregroundColor(.black)
                //.foregroundColor(Color("AccentColor"))
                //.shadow(radius: 15)
                //.padding(.top, 25)
                .navigationBarItems(
                  
                    trailing:
                        NavigationLink("Добавить", destination: AddView())
                        .font(.custom("Osterbar", size: 25))
                        .foregroundColor(.black)
                        
                    )
   
                .foregroundColor(Color("SetColorMenu"))
            
            }
            
        }
        
        //.background(.gray)
        .preferredColorScheme(.light)
        
    }

}
















struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
            
        }
        .environmentObject(ListViewModel())
        
    }
}

