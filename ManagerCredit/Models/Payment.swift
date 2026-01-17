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

    init(
        id: UUID,
        amount: Double,
        comment: String? = nil,
        status: PaymentStatus
    ) {
        self.id = id
        self.amount = amount
        self.comment = comment
        self.status = status
        self.createdAt = Date()
    }

    init(
        id: UUID,
        amount: Double,
        comment: String? = nil,
        status: PaymentStatus,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.amount = amount
        self.comment = comment
        self.status = status
        self.createdAt = createdAt
    }

    init(
        id: UUID,
        amount: Double,
        comment: String? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.amount = amount
        self.comment = comment
        self.status = .active
        self.createdAt = createdAt
    }

}

enum PaymentStatus: String, Codable, CaseIterable, Identifiable {
    case active
    case cancelled

    var id: Self { self }

    var description: String {
        switch self {
        case .active:
            "Activo"
        case .cancelled:
            "Cancelado"
        }
    }
}

enum PaymentStatusFilter: String, Codable, CaseIterable, Identifiable {
    case all
    case active
    case cancelled
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .all:
            "Todos"
        case .active:
            "Activos"
        case .cancelled:
            "Cancelados"
        }
    }
    
    var paymentStatus: PaymentStatus? {
        switch self {
        case .all:
            return nil
        case .active:
            return .active
        case .cancelled:
            return .cancelled
        }
    }
    init(from paymentStatus: PaymentStatus?){
        switch paymentStatus {
            case .active:
            self = .active
        case .cancelled:
            self = .cancelled
        case nil:
            self = .all
        }
    }
}
