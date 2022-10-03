//  ___FILEHEADER___

import Moya

final class ___VARIABLE_ModuleName___Network: Networkable {

    // MARK: - Properties
    let provider: MoyaProvider<___VARIABLE_ModuleName___Provider>
    let dataConverter: JSONDataConverterService

    init(converter: JSONDataConverterService,
         plugins: [PluginType],
         interceptor: EnvironmentInterceptor = EnvironmentInterceptor()) {
        self.dataConverter = converter
        let session = Session(startRequestsImmediately: false, interceptor: interceptor)
        let provider = MoyaProvider<___VARIABLE_ModuleName___Provider>(session: session, plugins: plugins)
        self.provider = provider
    }
}
