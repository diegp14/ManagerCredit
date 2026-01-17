//
//  PaymentViewModel.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 17/09/25.
//

import Foundation
import SwiftData


class PaymentViewModel {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addPayment(for credit: Credit, payment: Payment) throws {
        Task { @MainActor in
            credit.payments.append(payment)
            credit.creditPayment += payment.amount
            credit.creditBalance = max(0, credit.total - credit.creditPayment)
            
            //Verificar si el credito esta pagado
            if credit.creditBalance == 0 {
                credit.status = .paid
            }
            
            try modelContext.save()
        }
    }
    // 
    func deletePayment(for credit: Credit, payment: Payment) throws {
        Task { @MainActor in
            payment.status = .cancelled
            if credit.payments.firstIndex(of: payment) != nil {
                credit.creditPayment -= payment.amount
                credit.creditBalance = max(0, credit.total - credit.creditPayment)
                if credit.creditBalance > 0 {
                    credit.status = .active
                }
                
                try modelContext.save()
            }
        }
    }
}
