

import SwiftUI
import CoreData

struct LogListView: View {
    
    let leftColorshadowButton = Color("FloatingButtonTopLeft")
    //let rightColorshadowButton = Color("FloatingButtonBottomRight")
    let offColor = Color("SetColorMenu")
    let colorMenuColor = Color("AccentColor")
    let offWhiteColor = Color(red: 236/255, green: 234/255, blue: 235/255)
    let shadowColor = Color(red: 197/255, green: 197/255, blue: 197/255)
    
    @State var logToEdit: ExpenseLog?
    @State private var log = true
    @State private var showModal = false
    @State var id = UUID()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @FetchRequest(
        entity: ExpenseLog.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ExpenseLog.date, ascending: false)
        ]
    )
    private var result: FetchedResults<ExpenseLog>
    
    init(predicate: NSPredicate?, sortDescriptor: NSSortDescriptor) {
        let fetchRequest = NSFetchRequest<ExpenseLog>(entityName: ExpenseLog.entity().name ?? "ExpenseLog")
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        _result = FetchRequest(fetchRequest: fetchRequest)
    }
    
    
    
    
    
    var body: some View {
      //  NavigationView {
            
            ZStack {

                List {
                    
                    
                    ForEach(result) { (log: ExpenseLog) in
//                        
//                        Button(action: {
//                            self.logToEdit = log
//
//                        }) {
                            
                            
                            HStack(spacing: 6) {
                                CategoryImageView(category: log.categoryEnum)

                                VStack(alignment: .leading, spacing: 8) {
                                    Text(log.nameText)
                                        .font(.custom("Osterbar", size: 30))
                                    Text(log.dateText)
                                        .font(.custom("Osterbar", size: 15))
                                }
                                Spacer()
                                Text(log.amountText)
                                    .font(.custom("Osterbar", size: 25))
                            }
                            .scrollContentBackground(.hidden)
                            .background(Color("SetColorMenu"))
                            .padding(.vertical, 4)
                            
                            
                      //  }
                        .swipeActions(edge: .leading) {
                                    Button {
                                        self.logToEdit = log
                                        
                                    } label: {
                                        Image(systemName: "applepencil.tip")
                                            .frame(width: 6.0, height: 6.0)

                                    }
                                    .tint(.green)

                                }
                        
                    }
                    
                    .onDelete(perform: onDelete)
                    
                    
                    .sheet(item: $logToEdit , onDismiss:{
                        self.logToEdit = nil
                        
                    }) { (log: ExpenseLog) in
                        LogFormView(
                            logToEdit: log,
                            context: self.context,
                            name: log.name ?? "",
                            amount: log.amount?.doubleValue ?? 0,
                            category: Category(rawValue: log.category ?? "") ?? .магазин,
                            date: log.date ?? Date()
                            
                            )
                        
                        .presentationCornerRadius(30)
                        
                    }
                    
                    
                    
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.automatic)
                            .foregroundColor(Color(.black))
                            
                }
//                .id(result.count)
                .scrollContentBackground(.hidden)
                .background(Color("SetColorMenu"))
                
                .cornerRadius(15)
                    
            }
 
    }
    
    private func onDelete(with indexSet: IndexSet) {
        indexSet.forEach { index in
            let log = result[index]
            context.delete(log)
                
        }
        try? context.saveContext()
//        if result.isEmpty {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                id = UUID()
//            }
//        }
    }
        
}

struct LogListView_Previews: PreviewProvider {
    
    static var previews: some View {
        let stack = CoreDataStack(containerName: "TrackMoney")
        let sortDescriptor = ExpenseLogSort(sortType: .date, sortOrder: .descending).sortDescriptor
        return LogListView(predicate: nil, sortDescriptor: sortDescriptor)
            .environment(\.managedObjectContext, stack.viewContext)
   
    }
}
