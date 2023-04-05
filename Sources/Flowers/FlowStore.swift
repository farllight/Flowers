//
//  FlowStore.swift
//  
//
//  Created by Vladislav Markov on 26.02.2023.
//

/// Протокол над Store для инъекции
public protocol FlowStore<Action, State> {
    associatedtype Action: FlowAction
    associatedtype State: FlowState
    
    var state: State { get }
    
    func dispatch(action: Action)
}
