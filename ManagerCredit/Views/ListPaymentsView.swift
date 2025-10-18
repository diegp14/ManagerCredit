//
//  ListPaymentsView.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 16/09/25.
//

import SwiftUI

struct ListPaymentsView: View {

    let payments: [Payment]
    var onDelete: (_ index: IndexSet) -> Void
    
    @State private var showAlertDelete = false
    
    var body: some View {

        NavigationStack {
            if payments.isEmpty {
                Text("No se encontraron abonos")
            } else {
                List {
                    ForEach(Array(payments.enumerated()), id: \.element.id) {
                        index,
                        payment in
                        PaymentRow(payment: payment, index: index)
                            .swipeActions(edge: .trailing) {
                                if payment.status == .active {
                                    Button {
                                        print("Borrar \(payment.id)")
                                        showAlertDelete = true
                                    } label: {
                                        Label("Cancelar", systemImage: "trash")
                                    }
                                    .tint(.red)
                                }
                            }
                            .alert("Cancelar abono", isPresented: $showAlertDelete) {
                                /// A destructive button that appears in red.
                                   Button(role: .destructive) {
                                       // Perform the deletion
                                       self.onDelete([index])
                                   } label: {
                                       Text("Cancelar")
                                   }
                                   
                                   /// A cancellation button that appears with bold text.
                                   Button("Cerrar", role: .cancel) {
                                       // Perform cancellation
                                   }
                            }
                    }
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
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
        ListPaymentsView(
            payments: payments,
            onDelete: {
                index in print("Deleted: \(index)")
            }
        )
    }

}
