//
//  CreditDetailView.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 14/09/25.
//

import SwiftUI
import SwiftData

struct CreditDetailView: View {
    
    var credit: Credit
    let onEditCredit: (( String, Double, Int, String ) -> Void)?
    
    @State private var isPresenting = false
    
    @State private var viewModel: PaymentViewModel
    
    
    init(modelContext: ModelContext, credit: Credit, onEditCredit: (( String, Double, Int, String ) -> Void)? = nil) {
        self.credit = credit
        self.onEditCredit = onEditCredit
        _viewModel = State(initialValue: PaymentViewModel(modelContext: modelContext))
    }
    
    
    var body: some View {
        List{
            if credit.status == .active {
                Section(header: Text("Abonar")){
                    NavigationLink(destination: AddPaymentView(credit: credit){
                        (amount, date, comment) in
                        let payment = Payment(id: UUID(), amount: amount, comment: comment, createdAt: date)
                        do {
                            try viewModel.addPayment(for: credit, payment: payment)
                        }catch {
                            print("Error al agregar el pago: \(error)")
                        }
                    }
                                   
                    )
                    {
                        Label("Abonar", systemImage: "plus").foregroundStyle(.black)
                            .font(.headline)
                            .foregroundColor(.accentColor)
                    }
                }
            }else {
                HStack{
                    Text("Crédito: ")
                    
                    Text("\(credit.status.description)")
                        .font(.headline)
                        .foregroundStyle( credit.status == .cancelled ? .red : credit.status == .paid ? .green : .primary )
                }
                
            }
            Section(header: Text("Crédito Información")){
                HStack {
                    Label("Nombre", systemImage: "creditcard").foregroundStyle(.black)
                    Spacer()
                    Text("\(credit.name)")
                }
                HStack {
                    Label("Total", systemImage: "gauge.with.dots.needle.bottom.0percent").foregroundStyle(.black)
                    Spacer()
                    Text("\(credit.total.formatted())").foregroundStyle(.black)
                }
                HStack {
                    Label("Crédito Pendiente", systemImage: "gauge.with.dots.needle.67percent").foregroundStyle(.black)
                    Spacer()
                    Text("\(credit.creditBalance.formatted())").foregroundStyle(.black)
                }
                HStack {
                    Label("Día de pago", systemImage: "calendar").foregroundStyle(.black)
                    Spacer()
                    Text("\(credit.payDay.formatted())").foregroundStyle(.black)
                }
                
            }
            
            Section(header: Label("Comentario", systemImage: "text.bubble")){
                HStack{
                    Text("\(credit.comment ?? "")")
                }
            }
            
            Section(header: Text("Historial de Abonos")){
                NavigationLink(destination: ListPaymentsView(payments: credit.payments, onDelete: handleDeletePayment ))
                {
                    Label("Ver Abonos", systemImage: "list.bullet")
                        .foregroundStyle(.black)
                }
                
            }
        }.toolbar{
            if credit.status == .active && credit.payments.isEmpty{
                
                ToolbarItem(placement: .primaryAction){
                    Button("Editar"){
                        isPresenting = true
                    }
                }
            }
        }
        .sheet(isPresented: $isPresenting) {
            if let onEditCredit = onEditCredit {
                NavigationStack {
                    EditCreditView(credit: credit, onEditCredit: onEditCredit)
                        .navigationTitle("Editar Crédito")
                }
            }
        }
    }
    
    private func handleDeletePayment(at indexSet: IndexSet) {
        
        do {
            for index in indexSet {
                let paymentToDelete = credit.payments[index]
                if paymentToDelete.status == .active {
                    try viewModel.deletePayment(for: credit, payment: paymentToDelete)
                }
            }
        }catch {
            print("Error al eliminar el pago: \(error.localizedDescription)")
        }
    }
}

#Preview {
    let credit = Credit.sampleData[1]
    
    let sampleData = SampleData.shared
    
    
    NavigationStack{
        CreditDetailView(modelContext: sampleData.context, credit: credit){
            (name, total, payDay, comment) in
            print("name: \(name)")
        }
    }
}
