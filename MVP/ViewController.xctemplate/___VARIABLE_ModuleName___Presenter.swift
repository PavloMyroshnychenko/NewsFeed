//  ___FILEHEADER___

import Foundation

// MARK: - ___VARIABLE_ModuleName___PresenterProtocol
protocol ___VARIABLE_ModuleName___PresenterProtocol: AnyObject { }

// MARK: - ___VARIABLE_ModuleName___Presenter
final class ___VARIABLE_ModuleName___Presenter {

    // MARK: - Private properties
    private weak var view: ___VARIABLE_ModuleName___ViewProtocol?

    // MARK: - Initialization
    init(view: ___VARIABLE_ModuleName___ViewProtocol) {
        self.view = view
    }
}

// MARK: - ___VARIABLE_ModuleName___PresenterProtocol implementation
extension ___VARIABLE_ModuleName___Presenter: ___VARIABLE_ModuleName___PresenterProtocol { }
