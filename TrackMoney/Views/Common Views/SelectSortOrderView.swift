
import SwiftUI

struct SelectSortOrderView: View {
    let offColor = Color("SetColorMenu")
    let offWhiteColor = Color(red: 236/255, green: 234/255, blue: 235/255)
    let shadowColor = Color(red: 197/255, green: 197/255, blue: 197/255)
    
    @Binding var sortType: SortType
    @Binding var sortOrder: SortOrder
    
    private let sortTypes = SortType.allCases
    private let sortOrders = SortOrder.allCases
    
    var body: some View {
        
            
            HStack {
                Text("")
                Picker(selection: $sortType, label: Text("Sort by")) {
                    ForEach(SortType.allCases) { type in
                        Image(systemName: type == .date ? "calendar" : "dollarsign.circle")
                            .tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Text("")
                Picker(selection: $sortOrder, label: Text("Order")) {
                    ForEach(sortOrders) { order in
                        Image(systemName: order == .ascending ? "arrow.up" : "arrow.down")
                            .tag(order)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
            }
            .padding(.all)
            //.frame(height: 64)
        
    }
}

struct SelectSortOrderView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSortOrderView(sortType: .constant(.amount), sortOrder: .constant(.descending))
    }
}
