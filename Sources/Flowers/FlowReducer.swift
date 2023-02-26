//
//  FlowReducer.swift
//  
//
//  Created by Vladislav Markov on 26.02.2023.
//

public protocol FlowReducer<Action, State, Effect> {
    associatedtype State: FlowState
    associatedtype Action: FlowAction
    associatedtype Effect: FlowEffect
    
    /// Чистая функция для смены состояний
    /// - returns:
    /// - state: Новое состояние
    /// - effect:  эффект, который может быть вызван после смены состояния
    func reduce(
        action: Action,
        state: State
    ) -> (
        state: State,
        effect: Effect?
    )
}
