//
//  SettingsApp.swift
//  ExpenseTracker
//
//  Created by  aleksandr on 25.04.25.
//  Copyright © 2025 Alfian Losari. All rights reserved.
//

//import SwiftUI
//
//struct SettingsApp: View {
//    @State private var showModal = false
//    let leftColorshadowButton = Color("FloatingButtonTopLeft")
//    let rightColorshadowButton = Color("FloatingButtonBottomRight")
//    let offColor = Color("SetColorMenu")
//    let colorMenuColor = Color("AccentColor")
//    let offWhiteColor = Color(red: 236/255, green: 234/255, blue: 235/255)
//    let shadowColor = Color(red: 197/255, green: 197/255, blue: 197/255)
//    
//    @Environment(\.presentationMode) var presentationMode
//    @State private var showingColorsCrad = false
//    @State private var showingColors = false
//    @State var animate: Bool = false
//    let secondaryAccentColor = Color("SecondaryAccentColor")
//    
//    var body: some View {
//        
//        
//        
//        VStack(alignment: .center, spacing: 20) {
//            
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 40.0)
//                                .frame(width: 370, height: 400)
//                                .foregroundStyle(.white.opacity(0.5))
//                                .shadow(radius: 5)
//                                .offset(CGSize(width: 100.0, height: 10.0))
//                                .padding(10)
//                                .overlay(alignment: .bottomTrailing)  {
//            
//            
//            Button(action: {
//                //                                    self.showingColorsCrad.toggle()
//            }, label: {
//                VStack(spacing: 22, content: {
//                    Spacer(minLength: 10)
//                    RoundedRectangle(cornerRadius: 77)
//                        .frame(width: 60, height: 60)
//                        .foregroundStyle(.yellow)
//                    //.shadow(radius: 3)
//                        .overlay {
//                            Image("plus")
//                                .resizable()
//                                .colorMultiply(.white)
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 35, height: 35)
//                                .font(.headline)
//                                .foregroundColor(.white)
//                                .font(.headline)
//                                .frame(height: 60)
//                                .frame(width: 60)
//                                .background(animate ? colorMenuColor : Color("AccentColor"))
//                                .cornerRadius(35)
//                            
//                                //.padding(.horizontal, animate ? 20 : 50)
//                                .shadow(
//                                    color: animate ? colorMenuColor.opacity(0.7) : Color.accentColor.opacity(0.7),
//                                    radius: animate ? 30 : 10,
//                                    x: 0,
//                                    y: animate ? 50 : 30)
//                                .scaleEffect(animate ? 1.1 : 1.0)
//                                .offset(y: animate ? 1 : 0)
//                                .frame(maxWidth: 400)
//                                .multilineTextAlignment(.center)
//                                .padding(40)
//                                .onAppear(perform: addAnimation)
//                        }
//                    
//                        .padding(.bottom)
//                    
//                    
//                })
//            })
//            //                                .sheet(isPresented: $showingColorsCrad) {
//            //                                                        ColorViews()
//            //                                                    }
//            .offset(CGSize(width: -20, height: 50.0))
//            
//            }
//            
//               }
//            
//        }
//        
//        
//        
//        
//        
//        
//        
//    }
//            
//            
//            func addAnimation() {
//                guard !animate else { return }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
//                    withAnimation(
//                        Animation
//                            .easeInOut(duration: 1.5)
//                            .repeatForever()
//                    ) {
//                        animate.toggle()
//                    }
//                }
//            }
//
//}
//
//#Preview {
//    SettingsApp()
//}
