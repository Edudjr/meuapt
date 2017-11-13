//
//  CustomError.swift
//  MeuApt
//
//  Created by mac mini capgemini sp on 13/11/17.
//  Copyright © 2017 Domene. All rights reserved.
//
import Foundation

public enum CustomError: Error {
    case notFound
    case serverError
    case undefined
    case jsonParse
}

extension CustomError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .notFound:
            return NSLocalizedString("O recurso não foi encontrado", comment: "Não encontrado")
        case .serverError:
            return NSLocalizedString("Servidor indisponível. Tente novamente", comment: "Servidor indisponível")
        case .undefined:
            return NSLocalizedString("Ocorreu um erro inesperado", comment: "Erro inesperado")
        case .jsonParse:
            return NSLocalizedString("Não foi possível converter JSON", comment: "Erro inesperado")
        }
    }
}
