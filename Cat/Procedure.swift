//
//  Procedure.swift
//  Poke
//
//  Created by Yuetong Yang on 20/12/2016.
//  Copyright © 2016 Yuetong Yang. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(value: T)
    case fail(errorMessage: String)
}

class Procedure<T> {
    
    let function: (@escaping (Result<T>)->Void)->Void
    
    init(_ function: @escaping (_ completion: @escaping (Result<T>)->Void)->Void) {
        self.function = function
    }
    
    func excuteSuccess(_ function: @escaping (T)->Void) {
        self.execute { (result) in
            guard case .success(let value) = result else {return}
            function(value)
        }
    }
    
    func execute(_ completion: @escaping (Result<T>)->Void) {
        function(completion)
    }
    
    func execute() {
        function({_ in })
    }
    
    static func unit(_ value: T) -> Procedure<T> {
        return Procedure<T>({ (completion) in
            completion(Result.success(value: value))
        })
    }
    
    func then<M>(_ next: @escaping (T)->Procedure<M>) -> Procedure<M> {
        return Procedure<M>({ completion in
            self.execute({ t in
                switch t {
                case .fail(let errorMessage):
                    completion(Result.fail(errorMessage: errorMessage))
                case .success(let value):
                    next(value).execute(completion)
                }
            })
        })
    }
    
    func map<M>(_ next: @escaping (T)->Result<M>) -> Procedure<M> {
        return self.then({ t in
            return Procedure<M>({$0(next(t))})
        })
    }
    
    func mapSuccess<M>(_ next: @escaping (T)->M) -> Procedure<M> {
        return self.map({Result.success(value: next($0))})
    }
    
    func compose<M>(_ procedure: Procedure<M>) -> Procedure<(T,M)> {
        return Procedure<(T,M)>({ completion in
            self.execute({ (result) in
                switch result {
                case .fail(let errorMessage):
                    completion(Result.fail(errorMessage: errorMessage))
                case .success(let value):
                    procedure.execute({ (otherResult) in
                        switch otherResult {
                        case .fail(let errorMessage):
                            completion(Result.fail(errorMessage: errorMessage))
                        case .success(let otherValue):
                            completion(Result.success(value: (value, otherValue)))
                        }
                    })
                }
            })
        })
    }
    
    func onStart(value: T) -> Procedure<T> {
        return Procedure<T>({ (completion) in
            completion(Result.success(value: value))
            self.execute(completion)
        })
    }
    
    func mapError(errorMessage: String) -> Procedure<T> {
        return Procedure<T>({ (completion) in
            self.execute({ (result) in
                switch result {
                case .success(let value):
                    completion(Result.success(value: value))
                case .fail(let errorMessage):
                    completion(Result.fail(errorMessage: errorMessage))
                }
            })
        })
    }
}

//side affect
extension Procedure {
    func onStart(_ function: @escaping ()->Void) -> Procedure<T> {
        return Procedure<T>({ completion in
            function()
            self.execute(completion)
        })
    }
    
    func onFinished(_ function: @escaping ()->Void) -> Procedure<T> {
        return Procedure<T>({ completion in
            self.execute({ result in
                function()
                completion(result)
            })
        })
    }
    
    func onFail(_ function: @escaping (String)->Void) -> Procedure<T> {
        return Procedure<T>({ completion in
            self.execute({ (result) in
                if case .fail(let errorMessage) = result {
                    function(errorMessage)
                }
                completion(result)
             })
        })
    }
    
    func onSuccess(_ function: @escaping (T)->Void) -> Procedure<T> {
        return Procedure<T>({ (completion) in
            self.execute({ (result) in
                if case .success(let value) = result {
                    function(value)
                }
                completion(result)
            })
        })
    }
}
