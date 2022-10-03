//
//  PecodeNetwork.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import Moya

final class PecodeNetwork: Networkable {

    let provider: MoyaProvider<PecodeProvider>
    let dataConverter: JSONDataConverterService

    init(converter: JSONDataConverterService,
         plugins: [PluginType],
         interceptor: EnvironmentInterceptor = EnvironmentInterceptor()) {
        self.dataConverter = converter
        let session = Session(startRequestsImmediately: false, interceptor: interceptor)
        let provider = MoyaProvider<PecodeProvider>(session: session,
                                                    plugins: plugins)
        self.provider = provider
    }
    
    func getNewsFeed(page: Int, searchText: String, category: String) -> PecodeTestTaskPromise<NewsFeedResponse> {
        return executeAndMap(request: .topHeadlines(page: page,
                                                    searchText: searchText,
                                                    category: category))
    }
}
