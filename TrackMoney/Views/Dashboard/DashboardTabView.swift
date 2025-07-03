

import SwiftUI
import CoreData
import LocalAuthentication
import TipKit

struct DashboardTabView: View {
   
    
//    init() {
//            try? Tips.configure()
//        }
    
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    let leftColorshadowButton = Color("FloatingButtonTopLeft")
   // let rightColorshadowButton = Color("FloatingButtonBottomRight")
    let offColor = Color("SetColorMenu")
    let colorMenuColor = Color("AccentColor")
    let offWhiteColor = Color(red: 236/255, green: 234/255, blue: 235/255)
    let shadowColor = Color(red: 197/255, green: 197/255, blue: 197/255)
    
    let infoBut = InfoButtonDashboard()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    
    
    
    
    @State var totalExpenses: Double?
    @State var categoriesSum: [CategorySum]?
    @State var count: Int = 0
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")

    
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                colorMenuColor
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    VStack(spacing: 4) {
                        
                        if totalExpenses != nil {
                            
                            Text("Ваши  расходы")
                                .font(.custom("RubikDoodleShadow-Regular", size: 35))
                            // .font(.system(size: 30))
                                .fontWeight(.ultraLight)
                                .foregroundColor(Color(.black))
                                .colorScheme(.light)
                                .font(.subheadline)
                                .padding(.top, 5)
                                .buttonStyle(.borderedProminent)
                                .padding(.bottom, 10)
                                //.privacySensitive()
                        }
                            
                    }
                    
                    if categoriesSum != nil {
                        if totalExpenses != nil && totalExpenses! > 0 {
                            
                            PieChartView(
                                data: categoriesSum!.map { ($0.sum, $0.category.color) },
                                style: Styles.pieChartStyleOne,
                                form: CGSize(width: 300, height: 200),
                                dropShadow: false
                                
                            )
                        }
                        
                        if totalExpenses != nil {
                            Text(totalExpenses!.formattedCurrencyText)
                                .font(.custom("Osterbar", size: 55))
                                .font(.largeTitle)
                                .colorScheme(.light)
                                .foregroundColor(Color(.black))
                            
                        }
                        
                        
                        List {
                          
                            ForEach(self.categoriesSum!) {
                                CategoryRowView(category: $0.category, sum: $0.sum)
                                
                            }
                            
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.automatic)
                            .foregroundColor(Color(.black))
                            
                        }
                        
                        .scrollContentBackground(.hidden)
                        .background(Color("SetColorMenu"))
                        .cornerRadius(15)
                        
                        .padding(.bottom, 60)
                        .padding(5)
                        
                    }
                    
                    if totalExpenses == nil && categoriesSum == nil {
                        TipView(infoBut)
                            .padding()
                        Text("нет расходов")
                            
                            .font(.custom("RubikDoodleShadow-Regular", size: 25))
                            //.popoverTip(infoBut)
                            .foregroundColor(.black)
                            .shadow(
                                color: Color.primary.opacity(1), /// shadow color
                                radius: 0.2, /// shadow radius
                                    x: 0, /// x offset
                                    y: 0 /// y offset
                                )
                            .fontWeight(.bold)
                            .padding(30)
                            .background(Color.white)
                           
                        
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 10,
                                    bottomLeadingRadius: 40,
                                    bottomTrailingRadius: 10,
                                    topTrailingRadius: 40
                                )
                            )
                            .shadow(
                                color: Color.black.opacity(1), /// shadow color
                                    radius: 9, /// shadow radius
                                    x: 1, /// x offset
                                    y: 1 /// y offset
                                )
                           // .padding()
//                        TipView(infoBut)
                           // .popoverTip(infoBut)
                    }
                    
                }
                
                .onAppear(perform: fetchTotalSums)
                .navigationBarBackButtonHidden(true)
           
            }
            
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

    func fetchTotalSums() {
        ExpenseLog.fetchAllCategoriesTotalAmountSum(context: self.context) { (results) in
            guard !results.isEmpty else { return }
            
            let totalSum = results.map { $0.sum }.reduce(0, +)
            self.totalExpenses = totalSum
            self.categoriesSum = results.map({ (result) -> CategorySum in
                return CategorySum(sum: result.sum, category: result.category)
            })
        }
        
    }

}


struct CategorySum: Identifiable, Equatable {
    let sum: Double
    let category: Category
    
    var id: String { "\(category)\(sum)" }
}


struct DashboardTabView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTabView()
        
    }
}

//#Preview {
//    DashboardTabView()
//
//}



//import SwiftUI
//
//struct Note: Identifiable {
//    let id = UUID()
//    let content: String
//}
//
//struct NotesListView: View {
//    @State private var notes = [
//        Note(content: "Заметка 1"),
//        Note(content: "Заметка 2"),
//        Note(content: "Заметка 3")
//    ]
//    
//    var body: some View {
//        List {
//            ForEach(notes) { note in
//                Text(note.content)
//                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
//                        Button(role: .destructive) {
//                            delete(note)
//                        } label: {
//                            Label("Удалить", systemImage: "trash")
//                        }
//                        .tint(.red) // Цвет кнопки
//                    }
//                    .clipShape(RoundedRectangle(cornerRadius: 12)) // Визуальный эффект
//            }
//        }
//    }
//
//    func delete(_ note: Note) {
//        if let index = notes.firstIndex(where: { $0.id == note.id }) {
//            notes.remove(at: index)
//        }
//    }
//}
