//
//  PreviewContainer.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 14/09/25.
//

import SwiftData
import SwiftUI


@MainActor
class SampleData {
    static let shared = SampleData()
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    private init () {
        let schema = Schema([
            Credit.self,
            Payment.self
        ])
        let modelConfigurations = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfigurations])
            insertSampleData()
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        
        
    }
    private func insertSampleData() {
        for credit in Credit.sampleData {
            context.insert(credit)
        }
    }
    
    // Método para verificar que los datos están presentes
    func verifySampleData() {
        do {
            let creditDescriptor = FetchDescriptor<Credit>()
            let credits = try context.fetch(creditDescriptor)
            print("Número de créditos en SampleData: \(credits.count)")
            
            let paymentDescriptor = FetchDescriptor<Payment>()
            let payments = try context.fetch(paymentDescriptor)
            print("Número de pagos en SampleData: \(payments.count)")
        } catch {
            print("Error verificando datos: \(error)")
        }
    }
}

