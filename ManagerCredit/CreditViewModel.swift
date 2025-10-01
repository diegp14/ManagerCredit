//
//  CreditViewModel.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 15/09/25.
//

import Foundation
import SwiftData

@Observable
final class CreditViewModel {
    
    private let modelContext: ModelContext
    
    var credits: [Credit] = []
    var historyCredits: [Credit] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        // self.cancelledStatus = .cancelled
        fetchCredits()
        
        
    }
    
    func fetchCredits(filter: String = "") {
        Task{ @MainActor in
            do {
                var descriptor = FetchDescriptor<Credit>( sortBy: [SortDescriptor(\.name)])
                if !filter.isEmpty {
                    descriptor.predicate = #Predicate<Credit> { credit in
                        credit.name.localizedStandardContains(filter)
                    }
                }
                let allCredits = try modelContext.fetch(descriptor)
                
                // Filtrar por status en memoria
                credits = allCredits.filter { $0.status == .active }
            } catch {
                print("Error al fetch credits: \(error)")
            }
        }
    }
    
    func fetchHistoryCredits(filter: String = "") {
        
        Task{ @MainActor in
            do {
                var descriptor = FetchDescriptor<Credit>( sortBy: [SortDescriptor<Credit>(\.name)])
                
                if !filter.isEmpty {
                    descriptor.predicate = #Predicate<Credit> { credit in
                        credit.name.localizedStandardContains(filter)
                    }
                }
                let allCredits = try modelContext.fetch(descriptor)
                historyCredits = allCredits.filter {
                    $0.status == .cancelled || $0.status == .paid
                }
            }
        }
    }
    
    func addCredit(credit: Credit) throws {
        Task { @MainActor in
            modelContext.insert(credit)
            try modelContext.save()
            fetchCredits()
        }
    }
    
    func updateCredit(credit: Credit) throws {
        Task { @MainActor in
            try modelContext.save()
            fetchCredits()
        }
    }
    
    func deleteCredit(credit: Credit) throws {
        credit.status = .cancelled
        
        // Marcar todos los abonos como cancelados
        let payments = credit.payments
        for payment in payments {
            payment.status = .cancelled
        }
        
        Task { @MainActor in
            try modelContext.save()
            fetchCredits()
        }
    }
    
    
}

enum CreditFilterType {
    case active
    case cancelled
    case paid
    case history
    
    var title: String {
        switch self {
        case .active: return "Créditos Activos"
        case .cancelled: return "Créditos Cancelados"
        case .paid: return "Créditos Pagados"
        case .history: return "Historial"
        }
    }
}
