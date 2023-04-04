//
//  FlowStoreImpl.swift
//  
//
//  Created by Vladislav Markov on 26.02.2023.
//

public final class FlowStoreImpl<
    Action: FlowAction,
    State: FlowState,
    Effect: FlowEffect
>: FlowStore {
    // MARK: - Public properties
    public private(set) var state: State {
        didSet {
            guard oldValue != state else {
                return
            }
            
            stateChanged(state)
        }
    }
    
    // MARK: - Private properties
    private let reducer: any FlowReducer<Action, State, Effect>
    private let interactor: any FlowInteractor<Action, Effect>
    private let stateChanged: (State) -> Void
    
    // MARK: - Init
    public init(
        initialState: State,
        reducer: any FlowReducer<Action, State, Effect>,
        interactor: any FlowInteractor<Action, Effect>,
        stateChanged: @escaping (State) -> Void
    ) {
        self.state = initialState
        self.reducer = reducer
        self.interactor = interactor
        self.stateChanged = stateChanged
    }
    
    // MARK: - Dispatch
    public func dispatch(action: Action) {
        let (state, effect) = reducer.reduce(
            action: action,
            state: state
        )
        
        self.state = state
        
        Task {
            guard let effect = effect else {
                return
            }
            
            await interactor.apply(
                effect: effect,
                dispatch: { [weak self] action in
                    guard let self = self else { return }
                    self.dispatch(action: action)
                }
            )
        }
    }
}
