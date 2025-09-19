//
//  ContentView.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 14/09/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var viewModel: CreditViewModel
    
    @State private var search: String = ""
    
    init(modelContext: ModelContext) {
        _viewModel = State(initialValue: CreditViewModel(modelContext: modelContext))
    }
    
    @State private var showAddCreditView: Bool = false
    @State private var showHistoryCredits: Bool = false

    var body: some View {
        
        NavigationStack {
            Section{
                HStack{
                    TextField("Busqueda", text: $search)
                    Button{
                        showHistoryCredits = true
                        viewModel.fetchHistoryCredits()
                    } label: {
                        Text("Historial")
                    }
                }
                .padding(.leading)
            }
            .padding(.horizontal)
            List {
                ForEach(viewModel.credits) { credit in
                    NavigationLink(destination: CreditDetailView(modelContext: modelContext, credit: credit){
                        (name, total, payDay, comment) in
                        credit.name = name
                        credit.total = total
                        credit.payDay = payDay
                        credit.comment = comment
                        handleEdit(credit: credit)
                    }
                    )
                    {
                        CreditRowView(credit: credit)
                    }
                }
                .onDelete(perform: handleDelete)
            }
            .navigationBarTitle("Créditos")
            .onAppear {
                print("👀 Vista apareció")
                // Recargar por si acaso
                viewModel.fetchCredits()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button{
                        showAddCreditView = true
                    } label:{
                        Image(systemName:"plus")
                    }
                }
            }
            
        }
        .sheet(isPresented: $showAddCreditView) {
            NewCreditView{ name, total, payDay, comment in
                let credit = Credit(name: name, total: total, payDay: payDay, comment: comment)
                do{
                    try viewModel.addCredit(credit: credit)
                } catch {
                    print("Error al agregar el crédito: \(error)")
                }
                
                
            }
        }
        .sheet(isPresented: $showHistoryCredits){
            HistoryCreditView(credits: viewModel.historyCredits)
        }
    }
    
    private func handleDelete(at indexSet: IndexSet) {
        do {
            for index in indexSet {
                let creditToDelete = viewModel.credits[index]
                try viewModel.deleteCredit(credit: creditToDelete)
            }
        }catch {
            print("Error al eliminar el crédito: \(error)")
        }
        
    }
    
    private func handleEdit(credit: Credit) {
        print("Editar crédito: \(credit)")
        do {
            
            if credit.total < credit.creditPayment{
                credit.status = .paid
                credit.creditBalance = 0
            }else{
                credit.creditBalance = credit.total - credit.creditPayment
            }
            
            try viewModel.updateCredit(credit: credit)
        } catch {
            print("Error al actualizar el crédito: \(error)")
        }
        
    }
    

}

#Preview {
    //Llama la instancia de SampleData (singleton)
    let sampleData = SampleData.shared
    
    ContentView(modelContext: sampleData.context)
      .modelContainer(sampleData.modelContainer)
}

/*
 
 NavigationLink(destination: CreditDetailView(credit: credit, onEditCredit: {
     name, total, payDay, comment in
     credit.name = name
     credit.total = total
     credit.payDay = payDay
     credit.comment = comment
     let creditUpdate = credit
     handleEdit(credit: creditUpdate)
 }))
 
 
 */


