//
//  AdministrationCodable.swift
//  AdministrationExam
//
//  Created by Angel David Macho Esperilla on 31/03/2020.
//  Copyright © 2020 TuLotero. All rights reserved.
//

/// A structure for an administration coming from http responses
struct AdministrationDTO : Codable {
    public let id: String?
    public let nombre: String?
    public let urlFoto: String?
    public let telefono: String?
    public let poblacion: String?
    public let direccion: String?
    public let latitud: Float?
    public let longitud: Float?
    public let enabled: Bool?
    public let mail: String?
    public let provincia: String?
    public let codigoPostal: String?
    public let licencia: String?
    public let licenciaNombre: String?
    public let licenciaApellidos: String?
    public let licenciaDni: String?
    public let numero: String?
    public let commercial: String?
    public let mapImage: String?
}
