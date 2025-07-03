


import SwiftUI
import CoreData
import TipKit

struct LogsTabView: View {
   
    @State private var showAddSheet = false
    let leftColorshadowButton = Color("FloatingButtonTopLeft")
    //let rightColorshadowButton = Color("FloatingButtonBottomRight")
    let offColor = Color("SetColorMenu")
    let colorMenuColor = Color("AccentColor")
    
    let offWhiteColor = Color(red: 236/255, green: 234/255, blue: 235/255)
    let shadowColor = Color(red: 197/255, green: 197/255, blue: 197/255)
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var searchText : String = ""
    @State private var searchBarHeight: CGFloat = 0
    @State private var sortType = SortType.date
    @State private var sortOrder = SortOrder.descending
    
    @State var selectedCategories: Set<Category> = Set()
    @State var isAddFormPresented: Bool = false
    
    //@State private var currentDetent = PresentationDetent.medium
    
    //@Environment(\.presentationMode) var presentationMode
    @State private var showingColorsCrad = false
    @State private var showingColors = false
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")

    let infoLogs = InfoButtonLogs()

    
    var body: some View {
            
            ZStack {

                colorMenuColor
                        .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        
                        Text("Журналы расходов")
                            .font(.custom("RubikDoodleShadow-Regular", size: 30))
                            //.font(.system(size: 30))
                            .fontWeight(.ultraLight)
                            //.foregroundColor(Color(.black))
                            .colorScheme(.light)
                            .font(.subheadline)
                            .padding(.bottom, 5)
                        
                        SearchBar(text: $searchText, keyboardHeight: $searchBarHeight, placeholder: "поиск")
                            .font(.custom("Osterbar", size: 15))
                            .cornerRadius(12)
                        
                        
                        FilterCategoriesView(selectedCategories: $selectedCategories)
                            .font(.custom("Osterbar", size: 25))
                        Divider()
                        
                        SelectSortOrderView(sortType: $sortType, sortOrder: $sortOrder)
        
                        ZStack {
                           
                            VStack(spacing: 0) {
                                LogListView(predicate: ExpenseLog.predicate(with: Array(selectedCategories), searchText: searchText), sortDescriptor: ExpenseLogSort(sortType: sortType, sortOrder: sortOrder).sortDescriptor)
               
                                    .fullScreenCover(isPresented: $isAddFormPresented) {
                                        LogFormView(context: self.context)
                         
                                    }
                                
                            }
                            
                        }
                        
                    }
                
                    .padding(.bottom, 60)
                    .padding(5)
                    .modifier(DismissingKeyboard())
//                TipView(infoLogs)
                
                Button(action: {
                        addTapped()
                        
                    }){
                        VStack(spacing: 0, content: {
                  
                            RoundedRectangle(cornerRadius: 77)
                                .frame(width: 50, height: 50)
                           
                                .foregroundStyle(.yellow).opacity(0)
                            .shadow(radius: 3)
                                .overlay {
                                    Image("plus")
                                        .resizable()
                                        .colorMultiply(.white)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 35, height: 35)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .frame(height: 50)
                                        .frame(width: 50)
                                        .background(animate ? colorMenuColor : Color("AccentColor"))
                                        .cornerRadius(25)
                
                                        .shadow(
                                            color: animate ? colorMenuColor.opacity(1) : Color.accentColor.opacity(1),
                                            radius: animate ? 30 : 10,
                                           
                                            y: animate ? -5 : 0)
                                        .scaleEffect(animate ? 1.1 : 1.0)
                                        .offset(y: animate ? -7 : 0)
                                        .frame(maxWidth: 400)
                                        .multilineTextAlignment(.center)
                                        .padding(40)
                                        .onAppear(perform: addAnimation)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                               
                                .padding(.bottom)
                            
                                                        })

                    }
                    .offset(CGSize(width: 155, height: 280))
                TipView(infoLogs)
                    .padding(.horizontal, 10)
                    .padding(.top, 280)

                }
           
                .scrollDismissesKeyboard(.interactively)
 
    }
    
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 1.5)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
    
    
    
    func addTapped() {
        isAddFormPresented = true
        
    }
    
 
    
    
}

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}




struct LogsTabView_Previews: PreviewProvider {
    static var previews: some View {
        LogsTabView()
            //.preferredColorScheme(.dark)
            .preferredColorScheme(.light)
    }
}
