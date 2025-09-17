//
//  AddPaymentView.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 14/09/25.
//

import SwiftUI

struct AddPaymentView: View {
    
    var credit: Credit
    
    @State private var amount: Double?
    @State private var date: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Añadir Abono")){
                    TextField("Monto", value: $amount, formatter: NumberFormatter())
                    DatePicker("Fecha", selection: $date, displayedComponents: .date)
                }
                Section(header: Text("Comentario")){
                    TextEditor(text: .constant(""))
                }
            }
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    Button("Guadar"){
                        
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
