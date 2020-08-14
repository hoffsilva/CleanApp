//
//  HttpClientError.swift
//  Data
//
//  Created by Hoff Henry Pereira da Silva on 02/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

public enum HttpClientError: Error, Equatable {
    case noConnectivity
    case fourHundred
    case threeHundred
    case fiveHundred
}
