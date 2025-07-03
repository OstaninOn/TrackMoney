//
//  LoadingStartView.swift
//  TrackMoney
//
//  Created by  aleksandr on 6/16/25.
//

//import SwiftUI
//import Lottie


import SwiftUI
import Lottie

struct LottieViewModel: View {
    let colorMenuColor = Color("AccentColor")
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            colorMenuColor
                .ignoresSafeArea()
            VStack {
                
                
                if self.isActive {
                    FaceIDAuthView()
                } else {
                    LottieView(animation: .named("load"))
                        .playbackMode(.playing(.toProgress(1, loopMode: .playOnce)))
                }
                
                
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
            
        }
    }
}


#Preview {
    LottieViewModel()
}

//struct LottieViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
