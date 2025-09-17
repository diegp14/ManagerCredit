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
                        Text("# \(index + 1) - \(payment.amount.formatted())")
                        
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
        if let payments {
            ListPaymentsView(payments: payments)
        } else {
             Text("No Payments")
        }
    }
    
   
}
