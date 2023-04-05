//
//  FlowMapper.swift
//  
//
//  Created by Vladislav Markov on 06.04.2023.
//

import Combine

final class FlowMapper<ViewModel: FlowViewModel, State: FlowState> {
    
    /// ViewModel, которая будет обновляться при изменения данных
    private weak var viewModel: ViewModel?
    
    /// Функция обновления ViewModel при изменении State
    private let map: (State, inout ViewModel) -> Void
    
    init(
        viewModel: ViewModel,
        map: @escaping (State, inout ViewModel) -> Void
    ) {
        self.viewModel = viewModel
        self.map = map
    }
    
    func handleState(_ state: State) {
        Task { @MainActor in
            guard var viewModel else { return }
            map(state, &viewModel)
        }
    }
}
