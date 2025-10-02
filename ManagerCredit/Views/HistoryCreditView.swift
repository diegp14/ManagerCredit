//
//  HistoryCreditView.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 15/09/25.
//

import SwiftUI
import SwiftData

struct HistoryCreditView: View {
    
    var credits: [Credit]
    @Binding var searchText: String
    var onSubmit: () -> Void
    var onChange: (String, String) -> Void
    
    
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(credits) { credit in
                    NavigationLink(destination:  CreditDetailView(modelContext: modelContext, credit: credit, onEditCredit: {_,_,_,_  in }))
                    {
                        CreditRowView(credit: credit)
                    }

                }
            }
            .searchable(text: $searchText, prompt: "Buscar")
            .onSubmit(of: .search, onSubmit)
            .onChange(of: searchText){ oldValue, newValue in
                onChange(oldValue, newValue)
                
            }
            .navigationTitle("Historial")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button{
                        dismiss()
                    } label:{
                        Text("Cerrar")
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var searchText: String = ""
    let credits = Credit.sampleData
    let historicalCredits = credits.filter { $0.status != .active  }
    HistoryCreditView(credits: historicalCredits, searchText:$searchText){
        print("Buscar")
    } onChange: {
        oldValue, newValue in
        print(newValue)
    }
}
