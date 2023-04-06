//
//  FlowFactory.swift
//  
//
//  Created by Vladislav Markov on 06.04.2023.
//

public enum Flow {
    public static func make<
        State: FlowState,
        Action: FlowAction,
        Effect: FlowEffect,
        Event: FlowEvent,
        ViewModel: FlowViewModel
    >(
        initialState: State,
        initialViewModel: ViewModel,
        reducer: any FlowReducer<Action, State, Effect>,
        interactor: any FlowInteractor<Action, Effect>,
        coordinate: @escaping (Event) -> Action?,
        map: @escaping (State, inout ViewModel) -> Void
    ) -> FlowCoordinator<Action, State, Event> {
        let mapper = FlowMapper(
            viewModel: initialViewModel,
            map: map
        )
        
        let store = FlowStoreImpl(
            initialState: initialState,
            reducer: reducer,
            interactor: interactor,
            stateChanged: mapper.handleState
        )
        
        let coordinator = FlowCoordinator(
            store: store,
            coordinate: coordinate
        )
        
        return coordinator
    }
}
