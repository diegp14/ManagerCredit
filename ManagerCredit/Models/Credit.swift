//
//  Credit.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 14/09/25.
//

import Foundation
import SwiftData


@Model
final class Credit {
    
    @Attribute(.unique)
    var id: UUID
    var name: String
    var total: Double
    var status: CreditStatus
    var creditBalance: Double
    var creditPayment: Double
    var payDay: Int
    var comment: String?
    var createdAt: Date
    
    @Relationship(deleteRule: .cascade, inverse: \Payment.credit)
    var payments: [Payment]?
    
    init(id: UUID, name: String, total: Double, status: CreditStatus, payDay: Int, creditBalance: Double, creditPayment: Double  ,comment: String? = nil) {
        self.id = id
        self.name = name
        self.total = total
        self.status = status
        self.payDay = payDay
        self.comment = comment
        
        self.creditBalance = creditBalance
        self.creditPayment = creditPayment
        createdAt = Date()
        self.payments = nil
    }
    init(id: UUID, name: String, total: Double, status: CreditStatus, payDay: Int, creditBalance: Double, creditPayment: Double  ,comment: String? = nil, payments: [Payment]? = nil) {
        self.id = id
        self.name = name
        self.total = total
        self.status = status
        self.payDay = payDay
        self.comment = comment
        
        self.creditBalance = creditBalance
        self.creditPayment = creditPayment
        createdAt = Date()
        self.payments = payments
    }
    
    init(id: UUID, name: String, total: Double, status: CreditStatus, payDay: Int, comment: String? = nil) {
        self.id = id
        self.name = name
        self.total = total
        self.status = status
        self.payDay = payDay
        self.comment = comment
        
        creditBalance = total
        creditPayment = 0
        createdAt = Date()
    }
    
    init(name: String, total: Double, payDay: Int, comment: String? = nil) {
        self.id = UUID()
        self.name = name
        self.total = total
        
        self.payDay = payDay
        self.comment = comment
        
        self.status = .active
        creditBalance = total
        creditPayment = 0
        createdAt = Date()
    }
    
}
extension Credit {
    enum CreditStatus: String, Codable {
        case active = "ACTIVE"
        case cancelled = "CANCELLED"
        case paid = "PAID"
    }
}
