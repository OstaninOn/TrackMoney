



import SwiftUI
import LocalAuthentication
import CoreData
import Lottie
import TipKit


struct ContentView: View {
    
//    init() {
//               try? Tips.configure()
//           }
    
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    @State private var selectedTab = "расходы"

    let settingsColor = InfoButtonNoItems()
    
    let tabs = ["расходы", "добавить","заметки"]
    
    init () {
        UITabBar.appearance().isHidden = true
        
    }
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    
    var body: some View {
 
        
        ZStack (alignment: .bottom){
            
            
            
            TabView (selection: $selectedTab){
                
                DashboardTabView()
//                TipView(settingsColor)
                    .tag("расходы")
                    .font(.custom("Osterbar", size: 30))
//                    .task {
//                        try? Tips.configure([
//                           // .displayFrequency(.immediate)
//                            .datastoreLocation(.applicationDefault)])
//                    }
                
                //Text("расходы")
                
                LogsTabView()
                    .tag("добавить")
                    .font(.custom("Osterbar", size: 30))
                //Text("календарь")
                
                NotesView(presentSideMenu: $presentSideMenu)
                    .tag("заметки")
                    .font(.custom("Osterbar", size: 30))
                //Text("settings")
//                Tab.init("заметки", systemImage: "house.fill") {
//                    Text("заметки")
//                }
                
            }
            
            HStack{
                ForEach(tabs, id: \.self) { tab in
            
                    TabBarItem(tab: tab, selected: $selectedTab)
                   
                        
                }
            }
            .padding(.top, 17)
            .padding(.bottom, 7)
            //.frame(maxWidth: .infinity)
            //.background(.gray)
            .frame(width: 400, height: 55)
            .background(Color("AccentColor"))
            //.cornerRadius(17)
           //FaceIDAuthView()
        }
        
        .tint(Color.black)
    }
    
}



struct FaceIDAuthView: View {
    @State var isActive: Bool = false
    @State private var unlocked = false
    @State private var text = "LOCKED"
    @State private var isUnlocked = false
    @State private var showAuthScreen = true
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    let leftColorshadowButton = Color("FloatingButtonTopLeft")
    //let rightColorshadowButton = Color("FloatingButtonBottomRight")
    let offColor = Color("SetColorMenu")
    let colorMenuColor = Color("AccentColor")

    var body: some View {
        ZStack {
            if isUnlocked {
                ContentView()
//                    Text("Добро пожаловать 👋")
//                        .font(.largeTitle)
            } else if showAuthScreen {
                // Кастомный фон перед Face ID
                VStack {
                
                    
                    LottieView(animation: .named("id"))
                    .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                    
                    
//                                .onAppear {
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
//                                        withAnimation {
//                                            self.isActive = true
//                                        }
//                                    }
//                                }
                    Text("Авторизация")
                        .font(.custom("Osterbar", size: 70))
                        .font(.title)
                        //.padding(.top, -40)

                    Text("Подтвердите личность с помощью Face ID")
                        .font(.custom("Osterbar", size: 27))
                        .foregroundColor(.gray)
                        .padding(30)

                    Button("Войти") {
                        authenticate()
                    }
                    
                    .font(.custom("RubikDoodleShadow-Regular", size: 35))
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(animate ? secondaryAccentColor : Color("AccentColor"))
                    .cornerRadius(25)
                    .padding(.horizontal, animate ? 20 : 50)
                  .shadow(
                        color: animate ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                        radius: animate ? 30 : 10,
                        x: 0,
                       y: animate ? 50 : 30)
                    .scaleEffect(animate ? 1.1 : 1.0)
                   .offset(y: animate ? -7 : 0)
                    .frame(maxWidth: 400)
                    .multilineTextAlignment(.center)
                   .padding(60)
                    .onAppear(perform: addAnimation)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.bottom, 30)
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                

//                        .ignoresSafeArea()
//                )
            }
        }
    }
    
    


    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // Проверка: доступен ли Face ID
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Пожалуйста, подтвердите личность"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        
                        isUnlocked = true
                        showAuthScreen = false
                        
                    } else {
                       // exit(0)
                    }
                    
                }
            }
        } else {
            // Face ID недоступен
            
//            VStack {
//                
//                
//                if self.isActive {
//                    FaceIDAuthView()
//                } else {
//                    LottieView(animation: .named("error"))
//                        .playbackMode(.playing(.toProgress(1, loopMode: .playOnce)))
//                    
//                }
//                
//                
//                
//            }
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
//                    withAnimation {
//                        self.isActive = true
//                    }
//                }
//            }
            
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






struct TabBarItem: View {
    
    let offWhiteColor = Color(red: 236/255, green: 234/255, blue: 235/255)
    let shadowColor = Color(red: 197/255, green: 197/255, blue: 197/255)
    
    @State var tab: String
    @Binding var selected: String
    @State private var animationAmount = 0.0
    
    var body: some View {
        
//        if tab == "settings" {
//          
//        } else {
            
            ZStack {
                Button {
                    
                    withAnimation(.spring()) {
                        selected = tab
                    }
                    
                    withAnimation(.spring(duration: 1.1, bounce: 0.5)) {
                            animationAmount += 360
                            
                        }
                    
                } label: {
                    HStack{
                        Image(tab)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                        if selected == tab {
                            Text(tab)
                                .font(.custom("Osterbar", size: 30))
                                //.font(.system(size: 17))
                        }
                        
                    }
                    
                }
                
            }
            .opacity(selected == tab ? 1 : 0.5)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 25)
                    .background(selected == tab ? Color("SetColorMenu") : Color("AccentColor"))
                    .clipShape(Capsule())
        
//                            .background(
//                                RoundedRectangle(cornerRadius: 20, style: .continuous)
//                                    .fill(
//                                        .shadow(.drop(color: .black, radius: 11, x: 10, y: 10))
//                                    )
//                                    .foregroundColor(offWhiteColor))
        
    //    }AccentColor
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}


        




