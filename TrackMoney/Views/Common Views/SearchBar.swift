//
//  SearchBar.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 18/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    let offColor = Color("SetColorMenu")
    let colorMenuColor = Color("AccentColor")
    
    let offWhiteColor = Color(red: 236/255, green: 234/255, blue: 235/255)
    let shadowColor = Color(red: 197/255, green: 197/255, blue: 197/255)
    
    @Binding var text : String
    @Binding var keyboardHeight: CGFloat
    var placeholder: String
    
    class Cordinator : NSObject, UISearchBarDelegate {
        
        
        @Binding var text : String
        @Binding var searchBarHeight: CGFloat

        
        init(text : Binding<String>, searchBarHeight: Binding<CGFloat>) {
            _text = text
            _searchBarHeight = searchBarHeight
            
            super.init()
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
            
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardWillHide),
                name: UIResponder.keyboardWillHideNotification,
                object: nil
            )
            
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            let textField = searchBar.value(forKey: "searchField") as? UITextField
            //textField?.textColor = UIColor(named: "SetColorMenu")
            //textField!.backgroundColor = UIColor(named: "AccentColor")
//            searchBar.barTintColor = .red
            
        }
        
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
        }
        
        @objc func keyboardWillShow(_ notification: Notification) {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                searchBarHeight = keyboardRectangle.height
                
            }
        }
        
        @objc func keyboardWillHide(_ notification: Notification) {
            searchBarHeight = 0
            
        }
    }
    
    func makeCoordinator() -> SearchBar.Cordinator {
        
        return Cordinator(text: $text, searchBarHeight: $keyboardHeight)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = placeholder
        searchBar.delegate = context.coordinator
        searchBar.enablesReturnKeyAutomatically = false
        
        searchBar.barTintColor = UIColor(named: "AccentColor")
        //searchBar.searchTextField.backgroundColor = UIColor(named: "AccentColor")
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
        
    }
    
    func resignFirstResponder() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}




