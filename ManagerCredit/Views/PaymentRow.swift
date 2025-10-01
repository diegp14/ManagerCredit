//
//  PaymentRow.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 18/09/25.
//

import SwiftUI

struct PaymentRow: View {
    
    let payment: Payment
    let index: Int
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 8, height: 102)
                .foregroundColor(payment.status == .cancelled ? Color.red : Color.green)
                .padding(0)
            VStack {
                HStack {
                    Text("# de pago:")
                    Spacer()
                    Text("\(index+1)").bold(true)
                }
                HStack {
                    Text("Monto:")
                    Spacer()
                    Text("$\(payment.amount.formatted())").bold(true)
                }
                HStack {
                    Text("Fecha de pago:")
                    Spacer()
                    Text(payment.createdAt, format: .dateTime.day().month().year()) // ← Así
                        .bold()
                }
                HStack {
                    Text("Estado:")
                    Spacer()
                    Text(payment.status.rawValue)
                        .bold().foregroundStyle(payment.status == .active ? Color.black : Color.red)
                }
                
            }
            
        }
        
    }
}

#Preview {
    let payment = Payment(id: UUID(), amount: 100, status: .active)
    PaymentRow(payment: payment, index: 0)
}
