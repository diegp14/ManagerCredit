//
//  CreditSampleData.swift
//  TaskSwiftData
//
//  Created by Diego Guzman on 14/09/25.
//

import Foundation

extension Credit {
    
    static let sampleData: [Credit] = [
        Credit(id: UUID(), name: "Credito 1", total: 10_000, status: .cancelled, payDay: 15, comment: "Comentario 1"),
        Credit(id: UUID(), name: "Credito 2", total: 15_000, status: .active, payDay: 25, comment: "Comentario 2"),
        Credit(id: UUID(), name: "Credito 3", total: 1_000, status: .paid, payDay: 10, comment: "Comentario 3"),
        Credit(id: UUID(), name:"Credito 4" , total: 4_000, status: .active, payDay: 12, creditBalance: 1_000, creditPayment: 3_000, comment: "Comentario 4", payments: [Payment(id: UUID(), amount: 1_000, status: .active)])
]
}
