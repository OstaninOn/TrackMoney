//
//  CategoryRowView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct CategoryRowView: View {
    let category: Category
    let sum: Double
    let offColor = Color("SetColorMenu")
    let offWhiteColor = Color(red: 236/255, green: 234/255, blue: 235/255)
    let shadowColor = Color(red: 197/255, green: 197/255, blue: 197/255)
    
    var body: some View {
        ZStack {
            HStack {
                CategoryImageView(category: category)
                Text(category.rawValue.capitalized)
                Spacer()
                Text(sum.formattedCurrencyText)
                    .font(.custom("Osterbar", size: 25))
            }
           
        }
        
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView(category: .аптека, sum: 2500)
    }
}
