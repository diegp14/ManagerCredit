//
//  AddPaymentView.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 14/09/25.
//

import SwiftUI

struct AddPaymentView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var credit: Credit
    var onAddPayment: ((Double, Date, String) -> Void)?
    
    @State private var amount: Double?
    @State private var date: Date = Date()
    @State private var comment: String = ""
    
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Datos del abono")){
                    TextField("Monto", value: $amount, formatter: NumberFormatter())
                    DatePicker("Fecha", selection: $date, displayedComponents: .date)
                }
                TextEditor(text: $comment)
                     .frame(minHeight: 100, maxHeight: .infinity)
            }
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    Button("Guardar"){
                        onAddPayment?(amount ?? 0, date, comment)
                        dismiss()
                    }
                }
            }
        }
        .navigationTitle("Añadir Abono")
       
    }
}

#Preview {
    let credit = Credit.sampleData[0]
    NavigationStack {
        AddPaymentView(credit: credit)
    }
    
}
