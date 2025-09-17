//
//  Payment.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 14/09/25.
//

import Foundation
import SwiftData

@Model
final class Payment {
    
    @Attribute(.unique)
    var id: UUID
    var amount: Double
    var comment: String?
    var status: PaymentStatus
    var createdAt: Date
    
    var credit: Credit?
    
    init(id: UUID, amount: Double, comment: String? = nil, status: PaymentStatus) {
        self.id = id
        self.amount = amount
        self.comment = comment
        self.status = status
        self.createdAt = Date()
    }
    
    init(id: UUID, amount: Double, comment: String? = nil, status: PaymentStatus, createdAt: Date = Date()) {
        self.id = id
        self.amount = amount
        self.comment = comment
        self.status = status
        self.createdAt = createdAt
    }
    
    init(id: UUID, amount: Double, comment: String? = nil, createdAt: Date = Date()) {
        self.id = id
        self.amount = amount
        self.comment = comment
        self.status = .active
        self.createdAt = createdAt
    }
    

}

extension Payment {
    enum PaymentStatus: String, Codable {
        case active = "ACTIVE"
        case cancelled = "CANCELLED"
    }
}
