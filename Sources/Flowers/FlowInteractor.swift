//
//  FlowInteractor.swift
//  
//
//  Created by Vladislav Markov on 26.02.2023.
//

public protocol FlowInteractor<Action, Effect> {
    associatedtype Action: FlowAction
    associatedtype Effect: FlowEffect
    
    func apply(
        effect: Effect,
        dispatch: @escaping (Action) -> Void
    ) async
}
