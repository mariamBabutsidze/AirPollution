//
//  ListPollutionView.swift
//  AirPollution
//
//  Created by Mariam Babutsidze on 27.05.25.
//

import SwiftUI

struct ListPollutionView: View {
    @StateObject var viewModel: ListPollutionViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.pollutionList, id: \.date) { pollution in
                PollutionView(airQuality: pollution)
            }
        }
        .onAppear {
            Task {
                await viewModel.loadPollutionData()
            }
        }
        .alert(isPresented: .constant(viewModel.error != nil)) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error?.localizedDescription ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    ListPollutionView(viewModel: ListPollutionViewModel(pollutionFetcher: FetchPollution()))
}
