//
//  FlowInteractor.swift
//  
//
//  Created by Vladislav Markov on 26.02.2023.
//

/// Сущность, содержащая в себе асинхронную бизнес-лоигку
public protocol FlowInteractor<Action, Effect> {
    associatedtype Action: FlowAction
    associatedtype Effect: FlowEffect
    
    /// Вызывается, когда Reducer возвращает Effect.
    /// В ответ на Effect может начать генерировать Action из dispatch-функции
    func apply(
        effect: Effect,
        dispatch: @escaping (Action) -> Void
    ) async
}
