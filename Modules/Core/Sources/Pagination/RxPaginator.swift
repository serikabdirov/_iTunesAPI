//
//  RxPaginator.swift
//  Core
//
//  Created by Денис Кожухарь on 22.11.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import RxRelay
import RxSwift
import UIKit

// MARK: - RxSwift Paginator

// MARK: - RxSwift Paginator

public class RxPaginator<PageModel: PaginatedModel, Item>: NSObject {
    /// Called to end refreshing
    public typealias EndRefreshingCompletion = () -> Void

    /// Called when `Paginator` start loading
    /// - Parameters:
    ///   - onLoad: Completion, that should be called to indicate action result
    public typealias LoadActionProvider = () -> Single<(PageModel, [Item])>

    /// Called when `Paginator` start loading next pages
    /// - Parameters:
    ///   - nextPage: Next page
    public typealias LoadMoreActionProvider = (_ nextPage: PageModel.Page) -> Single<(PageModel, [Item])>

    /// Called when `Paginator` start refreshing
    public typealias RefreshActionProvider = () -> Single<(PageModel, [Item])>

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

    private let loadActionProvider: LoadActionProvider
    private let moreActionProvider: LoadMoreActionProvider
    private let refreshActionProvider: RefreshActionProvider
    private let shouldLoadMoreProvider: ShouldLoadMoreProvider

    private var loadDisposable: Disposable?
    private var loadMoreDisposable: Disposable?
    private var refreshDisposable: Disposable?

    private var shouldStartRefreshing = false
    private var isLoading = BehaviorRelay(value: false)
    private var isRefreshing = BehaviorRelay(value: false)
    private var isLoadingMore = BehaviorRelay(value: false)

    private var scrollViewObservation: NSKeyValueObservation?
    private var scrollViewContentSizeObservation: NSKeyValueObservation?

    private let disposeBag = DisposeBag()

    // MARK: - Init

    public init(
        loadActionProvider: @escaping LoadActionProvider,
        moreActionProvider: @escaping LoadMoreActionProvider,
        refreshActionProvider: @escaping RefreshActionProvider,
        shouldLoadMoreProvider: ShouldLoadMoreProvider = .verticalOffset(250)
    ) {
        self.loadActionProvider = loadActionProvider
        self.moreActionProvider = moreActionProvider
        self.refreshActionProvider = refreshActionProvider
        self.shouldLoadMoreProvider = shouldLoadMoreProvider
        super.init()
    }

    // MARK: - Public methods

    public func startLoading() {
        targetScrollView?.refreshControl?.endRefreshing()
        cancelCurrentTasks()
        loadDisposable = loadActionProvider()
            .trackState(using: isLoading)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                self?.targetScrollView?.refreshControl?.endRefreshing()
                switch result {
                case let .success((page, items)):
                    self?.reload(page: page, items: items)
                case .failure:
                    break
                }
            }
        loadDisposable?.disposed(by: disposeBag)
    }

    @objc
    public func startRefreshing() {
        cancelCurrentTasks()
        refreshDisposable = refreshActionProvider()
            .trackState(using: isRefreshing)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success((page, items)):
                    self.reload(page: page, items: items)
                case .failure:
                    break
                }
                DispatchQueue.main.async {
                    self.targetScrollView?.refreshControl?.endRefreshing()
                }
            }
        refreshDisposable?.disposed(by: disposeBag)
    }

    // MARK: - Private methods

    private func observe(_ scrollView: UIScrollView?) {
        scrollViewObservation = targetScrollView?
            .observe(\.contentOffset, options: [.initial, .new]) { [weak self] object, _ in
                self?.scrollViewDidScroll(object)
            }
        scrollViewContentSizeObservation = targetScrollView?
            .observe(\.contentSize, options: [.new]) { [weak self] object, _ in
                self?.scrollViewDidScroll(object)
            }
        targetScrollView?.refreshControl?.addTarget(self, action: #selector(scheduleRefreshing), for: .valueChanged)
    }

    private func reload(page: PageModel, items: [Item]) {
        self.page = page
        self.items = items
        itemsChangedHandler?(items)
    }

    private func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if shouldStartRefreshing, scrollView.isDecelerating {
            shouldStartRefreshing = false
            startRefreshing()
            return
        }
        if !isLoadingMore.value, !isRefreshing.value, !isLoading.value,
           let nextPage = page?.nextPage(),
           shouldLoadMoreProvider.shouldLoadMore(scrollView)
        {
            cancelCurrentTasks()
            loadMoreDisposable = moreActionProvider(nextPage)
                .trackState(using: isLoadingMore)
                .observe(on: MainScheduler.instance)
                .subscribe { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case let .success((page, newItems)):
                        self.page = page
                        self.items.append(contentsOf: newItems)
                        self.itemsAppendedHandler?(newItems)
                    case .failure:
                        break
                    }
                }
            loadMoreDisposable?.disposed(by: disposeBag)
        }
    }

    private func cancelCurrentTasks() {
        loadDisposable?.dispose()
        loadDisposable = nil
        loadMoreDisposable?.dispose()
        loadMoreDisposable = nil
        refreshDisposable?.dispose()
        refreshDisposable = nil
    }

    @objc
    private func scheduleRefreshing() {
        shouldStartRefreshing = true
    }
}
