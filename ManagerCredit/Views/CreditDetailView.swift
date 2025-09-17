//
//  CreditDetailView.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 14/09/25.
//

import SwiftUI

struct CreditDetailView: View {
    
    var credit: Credit
    let onEditCredit: (( String, Double, Int, String ) -> Void)?
    
    @State private var isPresenting = false
    
    
    var body: some View {
        List{
            if credit.status == .active {
                Section(header: Text("Abonar")){
                    NavigationLink(destination: AddPaymentView(credit: credit))
                    {
                        Label("Abonar", systemImage: "plus")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                    }
                }
            }else {
                HStack{
                    Text("Crédito: ")
                    
                    Text("\(credit.status.rawValue)")
                        .font(.headline)
                        .foregroundStyle( credit.status == .cancelled ? .red : credit.status == .paid ? .green : .primary )
                }
                
            }
            
            Section(header: Text("Crédito Información")){
                HStack {
                    Label("Nombre", systemImage: "creditcard")
                    Spacer()
                    Text("\(credit.name)")
                }
                HStack {
                    Label("Total", systemImage: "gauge.with.dots.needle.bottom.0percent")
                    Spacer()
                    Text("\(credit.total.formatted())")
                }
                HStack {
                    Label("Crédito Pendiente", systemImage: "gauge.with.dots.needle.bottom.0percent")
                    Spacer()
                    Text("\(credit.creditBalance.formatted())")
                }
                HStack {
                    Label("Día de pago", systemImage: "calendar")
                    Spacer()
                    Text("\(credit.payDay.formatted())")
                }
                VStack {
                    Label("Comentario", systemImage: "text.bubble")
                    Spacer()
                    Text("\(credit.comment ?? "")")
                }
            }
            Section(header: Text("Historial de Abonos")){
                NavigationLink(destination: ListPaymentsView(payments: credit.payments ?? []))
                {
                    Label("Ver Abonos", systemImage: "list.bullet")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                
            }
        }.toolbar{
            if credit.status == .active && credit.payments == nil {
                
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
}

#Preview {
    let credit = Credit.sampleData[1]
    NavigationStack{
        CreditDetailView(credit: credit){
            (name, total, payDay, comment) in
            print("name: \(name)")
        }
    }
}
