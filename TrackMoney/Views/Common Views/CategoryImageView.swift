//
//  CategoryImageView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct CategoryImageView: View {
    
    let category: Category
    
    var body: some View {
        Image(systemName: category.systemNameIcon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            .padding(.all, 8)
            .foregroundColor(category.color)
            .background(category.color.opacity(0.1))
            .cornerRadius(20)
    }
}

struct CategoryImageView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryImageView(category: .аптека)
    }
}
