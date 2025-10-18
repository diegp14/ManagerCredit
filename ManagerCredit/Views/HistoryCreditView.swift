//
//  HistoryCreditView.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 15/09/25.
//

import SwiftUI
import SwiftData

enum filterOptions: String, CaseIterable, Identifiable {
    case all = "Todos"
    case paid = "Pagados"
    case canceled = "Cancelados"
    
    var id: String {self.rawValue}
}

struct HistoryCreditView: View {
    
    var credits: [Credit]
    @Binding var searchText: String
    var onSubmit: () -> Void
    var onChange: (String, String) -> Void
    
    
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    @State private var filterStatus: filterOptions = .all
    
    var filteredCredits: [Credit] {
        switch filterStatus {
        case .all:
            return credits
        case .paid:
            return  credits.filter { $0.status == Credit.CreditStatus.paid }
        case .canceled:
            return  credits.filter { $0.status == Credit.CreditStatus.cancelled }
        }
    }
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(filteredCredits) { credit in
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
                ToolbarItem(placement: .cancellationAction) {
                    Button{
                        dismiss()
                    } label:{
                        Text("Cerrar").foregroundStyle(.red)
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Picker("Status", selection: $filterStatus) {
                            ForEach(filterOptions.allCases){
                                option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(.menu)
                    } label: {
                        Label("Filtro", systemImage: "slider.horizontal.3")
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
