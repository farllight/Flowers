//
//  FlowCoordinator.swift
//  
//
//  Created by Vladislav Markov on 06.04.2023.
//

public final class FlowCoordinator<Action: FlowAction, State: FlowState, Event: FlowEvent> {
    /// Будет уведомлен о произошедших в UI событиях
    private let store: any FlowStore<Action, State>
    
    /// Чистая функция для преобразования UI-события в бизнес-событие
    private let coordinate: (Event) -> Action
    
    init(
        store: any FlowStore<Action, State>,
        coordinate: @escaping (Event) -> Action
    ) {
        self.store = store
        self.coordinate = coordinate
    }
    
    public func onEvent(event: Event) {
        let action = coordinate(event)
        store.dispatch(action: action)
    }
}
