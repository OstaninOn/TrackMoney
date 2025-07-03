//
//  NoItemsView.swift
//  ExpenseTracker
//
//  Created by  aleksandr on 25.05.25.
//  Copyright © 2025 Alfian Losari. All rights reserved.
//

import SwiftUI
import TipKit

struct NoItemsView: View {
    let offColor = Color("SetColorMenu")
    let colorMenuColor = Color("AccentColor")
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    let infoList = InfoButtonNoItems()
    
    var body: some View {
        ZStack{
            colorMenuColor
                .ignoresSafeArea()
            ScrollView {
             
                    NavigationLink(
                        destination: AddView(),
                        
                        label: {
                            Spacer()
                            Text("создать   заметку")
                                .font(.custom("Osterbar", size: 35))
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(height: 60)
                                .frame(maxWidth: .infinity)
                                .background(animate ? secondaryAccentColor : Color.accentColor)
                                .cornerRadius(15)
                            
                                //.popoverTip(settingsColor)
                        })
                    
                    .padding(.horizontal, animate ? 20 : 50)
                    .shadow(
                        color: animate ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                        radius: animate ? 30 : 10,
                        x: 0,
                        y: animate ? 50 : 30)
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .offset(y: animate ? -7 : 0)
                //}
                .frame(maxWidth: 400)
                .multilineTextAlignment(.center)
                .padding(40)
                .onAppear(perform: addAnimation)
                
            TipView(infoList)
                    .padding(.horizontal, 10)
            }
            .padding(.top, 360)
            //.padding(5)
            //.background(.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
    }
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 1)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
    
}

//struct NoItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            NoItemsView()
//                .navigationTitle("ЗАМЕТКИ")
//            
//        }
//    }
//}


#Preview {
    NoItemsView()
}
