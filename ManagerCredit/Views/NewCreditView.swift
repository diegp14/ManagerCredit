//
//  NewCreditView.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 14/09/25.
//

import SwiftUI

struct NewCreditView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var total: Double?
    @State private var payDay: Int = 1
    @State private var comment: String = ""
    
    let onCreateCredit: ( String, Double, Int, String ) -> Void
    
    
    
    var body: some View {
       NavigationStack {
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
                       onCreateCredit(name, total ?? 0.0 , payDay, comment)
                       dismiss()
                   }
                   .disabled(name.isEmpty || total == nil)
               }
               ToolbarItem(placement: .cancellationAction){
                   Button{
                       dismiss()
                   } label: {
                       Text("Cerrar")
                           .foregroundStyle(.red)
                   }
               }
           }

        }
       .navigationTitle(Text("Nuevo Credito"))
    }
}

#Preview {
    NewCreditView{
        name, total, payDay, comment in
        print("Credito \(name) \(total) \(payDay) \(comment)")
    }
}
 
