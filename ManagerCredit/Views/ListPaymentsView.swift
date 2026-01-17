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
    @State private var selectedStatus: PaymentStatusFilter = .all
    @State private var showDatePicker: Bool = false
    @State private var initialDate: Date = Date()
    @State private var finalDate: Date = Date()

    var filteredPayments: [Payment] {
        payments.filter { payment in
            // Filtro de status
            let matchesStatus = selectedStatus.paymentStatus.map { payment.status == $0 } ?? true
            // Filtro de fecha
            //let matchesDate = payment.createdAt >= initialDate && payment.createdAt <= finalDate
            
            return matchesStatus
        }
    }

    var body: some View {

        NavigationStack {
            Group {
                if filteredPayments.isEmpty {
                    ContentUnavailableView(
                        "No se encontraron abonos",
                        systemImage: "creditcard.circle"
                    )
                } else {
                    List {
                        ForEach(
                            Array(filteredPayments.enumerated()),
                            id: \.element.id
                        ) {
                            index,
                            payment in
                            PaymentRow(payment: payment, index: index)
                                .swipeActions(edge: .trailing) {
                                    if payment.status == .active {
                                        Button {
                                            print("Borrar \(payment.id)")
                                            showAlertDelete = true
                                        } label: {
                                            Label(
                                                "Borrar",
                                                systemImage: "trash"
                                            )
                                        }
                                        .tint(.red)
                                    }
                                }
                                .alert(
                                    "Cancelar abono",
                                    isPresented: $showAlertDelete
                                ) {
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
                        .listRowInsets(
                            .init(top: 10, leading: 0, bottom: 10, trailing: 10)
                        )

                    }
                    .navigationBarTitle("Lista de Abonos")
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Menu {
                                Picker("Filtro", selection: $selectedStatus) {
                                    ForEach(PaymentStatusFilter.allCases) {
                                        status in
                                        Text(status.description).tag(status)
                                    }
                                }
                            } label: {
                                Image(systemName: "slider.horizontal.3")
                                Text("Status")
                            }
                        }
                        ToolbarItem(placement: .automatic) {
                            Button {
                                showDatePicker.toggle()
                            } label: {
                                //Label("Buscar", systemImage: "calendar")
                                Image(systemName: "calendar")
                                Text("Fecha")

                            }
                            .popover(
                                isPresented: $showDatePicker,
                                attachmentAnchor: .point(.bottom),
                                arrowEdge: .top
                            ) {
                                VStack {
                                    Text("DatePicker")
                                    LabeledContent("Fecha inicial") {
                                        DatePicker(
                                            "",
                                            selection: $initialDate,
                                            //displayedComponents: .
                                        )
                                    }
                                    LabeledContent("Fecha final") {
                                        DatePicker(
                                            "",
                                            selection: $finalDate,
                                            //displayedComponents: .date
                                        )
                                    }
                                    Divider()
                                    Button {
                                        displayDate()
                                        showDatePicker = false
                                    } label: {
                                        Text("Buscar")
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .trailing
                                    )
                                }
                                .padding()
                                .presentationCompactAdaptation(.popover)
                                .frame(minWidth: 300, minHeight: 210)
                            }
                        }
                    }
                    Text("Abonos mostrados: \(filteredPayments.count)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
            }
        }
    }
    
    private func displayDate(){
        print("Fecha inicial \(initialDate) - fechaa final \(finalDate)")
    }
}

#Preview("Normal") {
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

#Preview("Empty") {
    NavigationStack {
        ListPaymentsView(payments: []) {
            index in print("Borrar \(index)")
        }
    }
}
