//
//  FilterCategoriesView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct FilterCategoriesView: View {
    let leftColorshadowButton = Color("FloatingButtonTopLeft")
    //let rightColorshadowButton = Color("FloatingButtonBottomRight")
    let offColor = Color("SetColorMenu")
    let colorMenuColor = Color("AccentColor")
    
    @Binding var selectedCategories: Set<Category>
    private let categories = Category.allCases
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 13) {
                ForEach(categories) { category in
                    FilterButtonView(
                        category: category,
                        isSelected: self.selectedCategories.contains(category),
                        onTap: self.onTap
                    )
                        
                        .padding(.leading, category == self.categories.first ? 5 : 0)
                        .padding(.trailing, category == self.categories.last ? 5 : 0)
                    
                }
            }
        }
        .padding(.vertical)
    }
    
    func onTap(category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}

struct FilterButtonView: View {
    
    var category: Category
    var isSelected: Bool
    var onTap: (Category) -> ()
    
    var body: some View {
        Button(action: {
            self.onTap(self.category)
        }) {
            HStack(spacing: 5) {
                Text(category.rawValue.capitalized)
                    .fixedSize(horizontal: true, vertical: true)
                
                if isSelected {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 5)
                
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? category.color : Color(UIColor(named: "SetColorMenu")!), lineWidth: 4))
                .frame(height: 44)
        }
        .foregroundColor(isSelected ? category.color : Color(UIColor(named: "SetColorMenu")!))
    }
    
    
}


struct FilterCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        FilterCategoriesView(selectedCategories: .constant(Set()))
    }
}
