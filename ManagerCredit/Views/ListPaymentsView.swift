//
//  ListPaymentsView.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 16/09/25.
//

import SwiftUI

struct ListPaymentsView: View {
    
    let payments: [Payment]
    var body: some View {
       
        NavigationStack {
            if payments.isEmpty {
                Text("No se encontraron abonos")
            }else{
                List {
                    ForEach(Array(payments.enumerated()), id: \.element.id){  index, payment in
                        PaymentRow(payment: payment, index: index)
                        
                    }
                }
                .navigationBarTitle("Lista de Abonos")
            }
        }
    }
}

#Preview {
    let credit = Credit.sampleData[3]
    let payments = credit.payments
    
    NavigationStack {
            ListPaymentsView(payments: payments)
    }
    
   
}
