//
//  CreditRowView.swift
//  ManagerCredit
//
//  Created by Diego Guzman on 16/09/25.
//

import SwiftUI

struct CreditRowView: View {
    let credit: Credit
    var body: some View {
        VStack {
            HStack {
                Text("Descripción:")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(credit.name)")
                    .font(.headline)
                
            }
            HStack {
                Text("Total:")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("$\(credit.total.formatted())")
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
            HStack {
                Text("Crédito Pendiente:")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("$\(credit.creditBalance.formatted())")
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
            HStack {
                Text("Estado:")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(credit.status.description)")
                    .font(.headline)
                    .foregroundStyle( credit.status == .cancelled ? .red : credit.status == .paid ? .green : .primary )
                
            }
        }
    }
}

#Preview {
    let credit = Credit.sampleData[0]
    CreditRowView(credit: credit)
}
