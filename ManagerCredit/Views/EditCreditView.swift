//
//  EditCreditView.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 14/09/25.
//

import SwiftUI

struct EditCreditView: View {
    
    var credit: Credit
    var onEditCredit: (( String, Double, Int, String ) -> Void)? = nil
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String
    @State private var total: Double
    @State private var payDay: Int
    @State private var comment: String
    
    init(credit: Credit, onEditCredit: @escaping ( String, Double, Int, String ) -> Void){
        self.name = credit.name
        self.total = credit.total
        self.payDay = credit.payDay
        self.comment = credit.comment ?? " "
        self.credit = credit
        self.onEditCredit = onEditCredit
    }
    
    var body: some View {
        Form{
            Section(header: Text("Info Crédito")){
                TextField("Nombre", text: $name)
                TextField("Total", value: $total, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                Picker("Dia de Pago", selection: $payDay){
                    ForEach(1...31, id: \.self){
                        Text("\($0)")
                    }
                }
                
            }
            Section(header: Text("Comentario")){
               TextEditor(text: $comment)
                    .frame(minHeight: 100, maxHeight: .infinity)
            }
            
        }
        .toolbar{
            ToolbarItem(placement: .primaryAction){
                Button("Guardar"){
                    if let onEditCredit = onEditCredit {
                        onEditCredit(name, total, payDay, comment)
                    }
                    dismiss()
                }
            }
            ToolbarItem(placement: .cancellationAction){
                Button {
                    dismiss()
                } label: {
                    Text("Cancelar")
                        .foregroundStyle(.red)
                }
            }
        }
       
    }
    
}

#Preview {
    let credit = Credit.sampleData[0]
    EditCreditView(credit: credit){
        name, total, payDay, comment in
        print("Credito \(name) \(total) \(payDay) \(comment)")
    }
}
