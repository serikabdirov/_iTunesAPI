//
//  Paginator.swift
//  Core
//
//  Created by Денис Кожухарь on 12.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit

@available(*, deprecated, message: "Use RxPaginator instead")
public class Paginator<PageModel: PaginatedModel, Item>: NSObject {
    /// Called after load items
    public typealias LoadCompletion = (Result<(PageModel, [Item]), Error>) -> Void

    /// Called to end refreshing
    public typealias EndRefreshingCompletion = () -> Void

    /// Called when `Paginator` start loading
    /// - Parameters:
    ///   - onLoad: Completion, that should be called to indicate action result
    public typealias LoadAction = (
        _ onLoad: @escaping LoadCompletion
    ) -> Void

    /// Called when `Paginator` start loading next pages
    /// - Parameters:
    ///   - nextPage: Next page
    ///   - onLoad: Completion, that should be called to indicate action result
    public typealias LoadMoreAction = (
        _ nextPage: PageModel.Page,
        _ onLoad: @escaping LoadCompletion
    ) -> Void

    /// Called when `Paginator` start refreshing
    /// - Parameters:
    ///   - onLoad: Completion, that should be called to indicate action result
    ///   - onEndRefreshing: Completion, that should be called to indicate refreshing end
    public typealias RefreshAction = (
        _ onLoad: @escaping LoadCompletion,
        _ onEndRefreshing: @escaping EndRefreshingCompletion
    ) -> Void

    // MARK: - Public properties

    public private(set) var page: PageModel?
    public private(set) var items: [Item] = []

    public var canLoadMore: Bool { page?.nextPage() != nil }

    public var targetScrollView: UIScrollView? {
        didSet {
            if targetScrollView != oldValue {
                observe(targetScrollView)
            }
            oldValue?.refreshControl?.removeTarget(self, action: nil, for: .valueChanged)
        }
    }

    /// Called when items fully reloaded
    public var itemsChangedHandler: (([Item]) -> Void)?
    /// Called when new items appended
    public var itemsAppendedHandler: (([Item]) -> Void)?

    // MARK: - Private properties

    private let loadAction: LoadAction
    private let moreAction: LoadMoreAction
    private let refreshAction: RefreshAction
    private let shouldLoadMoreProvider: ShouldLoadMoreProvider
    private var scrollViewObservation: NSKeyValueObservation?
    private var isRefreshing = false
    private var isLoadingMore = false

    // MARK: - Init

    public init(
        loadAction: @escaping LoadAction,
        moreAction: @escaping LoadMoreAction,
        refreshAction: @escaping RefreshAction,
        shouldLoadMoreProvider: ShouldLoadMoreProvider = .verticalOffset(250)
    ) {
        self.loadAction = loadAction
        self.moreAction = moreAction
        self.refreshAction = refreshAction
        self.shouldLoadMoreProvider = shouldLoadMoreProvider
        super.init()
    }

    public init(
        loadAction: @escaping LoadAction,
        moreAction: @escaping LoadMoreAction,
        refreshAction: @escaping LoadAction,
        shouldLoadMoreProvider: ShouldLoadMoreProvider = .verticalOffset(250)
    ) {
        self.loadAction = loadAction
        self.moreAction = moreAction
        self.refreshAction = { completion, endRefreshing in refreshAction { endRefreshing(); completion($0) } }
        self.shouldLoadMoreProvider = shouldLoadMoreProvider
        super.init()
    }

    // MARK: - Public methods

    public func startLoading() {
        isLoadingMore = false
        isRefreshing = false
        targetScrollView?.refreshControl?.endRefreshing()
        loadAction { [weak self] result in
            self?.targetScrollView?.refreshControl?.endRefreshing()
            switch result {
            case let .success((page, items)):
                self?.reload(page: page, items: items)
            case .failure:
                break
            }
        }
    }

    @objc
    public func startRefreshing() {
        isLoadingMore = false
        isRefreshing = true
        refreshAction({ [weak self] result in
            guard let self = self else { return }
            self.isRefreshing = false
            switch result {
            case let .success((page, items)):
                self.reload(page: page, items: items)
            case .failure:
                break
            }
        }, { [weak self] in
            DispatchQueue.main.async {
                self?.targetScrollView?.refreshControl?.endRefreshing()
            }
        })
    }

    // MARK: - Private methods

    private func observe(_ scrollView: UIScrollView?) {
        scrollViewObservation = targetScrollView?
            .observe(\.contentOffset, options: [.initial, .new]) { [weak self] object, _ in
                self?.scrollViewDidScroll(object)
            }
        targetScrollView?.refreshControl?.addTarget(self, action: #selector(startRefreshing), for: .valueChanged)
    }

    private func reload(page: PageModel, items: [Item]) {
        self.page = page
        self.items = items
        itemsChangedHandler?(items)
    }

    private func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isLoadingMore, !isRefreshing, let nextPage = page?.nextPage(),
           shouldLoadMoreProvider.shouldLoadMore(scrollView)
        {
            isLoadingMore = true
            moreAction(nextPage) { [weak self] result in
                guard let self = self else { return }
                self.isLoadingMore = false
                switch result {
                case let .success((page, newItems)):
                    self.page = page
                    self.items.append(contentsOf: newItems)
                    self.itemsAppendedHandler?(newItems)
                case .failure:
                    break
                }
            }
        }
    }
}
