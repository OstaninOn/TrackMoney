//
//  ListRowView.swift
//  ExpenseTracker
//
//  Created by  aleksandr on 25.05.25.
//  Copyright © 2025 Alfian Losari. All rights reserved.
//

import SwiftUI

let offColor = Color("SetColorMenu")
let colorMenuColor = Color("AccentColor")

struct ListRowView: View {
    
    @State var isDeleted: Bool = false
    @State private var animationAmount = 0.0
    
    let item: ItemModel
    
    var body: some View {
        ZStack {
         
                HStack {
                    
                    Button {
                        isDeleted.toggle()
                        
                    }label: {
                        
                        Image(systemName: item.isCompleted ? "multiply.circle" : "circle")
                        
                        
                            .symbolEffect(.rotate, options: .repeat(.periodic(delay: 1)).repeat(1))
                        
                            .symbolRenderingMode(.hierarchical)
                            .contentTransition(.symbolEffect(.replace))
                        
                        
                            .foregroundColor(item.isCompleted ? .red : .green)
                            .font(.system(size: 30, weight: .bold))
                            //.contentTransition(.symbolEffect(.replace))
                        
//                            .symbolRenderingMode(.hierarchical)
//                            .contentTransition(.symbolEffect(.replace))
                        
                        
                    }
       
                Text(item.title)
                
                    .font(.custom("Osterbar", size: 30))
                    .bold()
                Spacer()
                
            }
        }
        .font(.title2)
        .padding(.vertical, 8)
       // .padding(.trailing, 60)
        .padding(5)
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var item1 = ItemModel(title: "First item!", isCompleted: false)
    
    static var item2 = ItemModel(title: "Second Item.", isCompleted: true)
    
    
    static var previews: some View {
        Group {
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
        
    }
}


//#Preview {
//    ListRowView()
//}
