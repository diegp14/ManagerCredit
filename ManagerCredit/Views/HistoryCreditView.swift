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
    
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    @State var searchText: String = ""
    
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
            .onSubmit(of: .search) {
                print("Buscar!!")
                
            }
            .onChange(of: searchText) {oldValue, newValue in
                print(newValue)
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
    let credits = Credit.sampleData
    let historicalCredits = credits.filter { $0.status != .active  }
    HistoryCreditView(credits: historicalCredits)
}
