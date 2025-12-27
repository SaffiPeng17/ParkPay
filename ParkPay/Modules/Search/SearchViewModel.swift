//
//  SearchViewModel.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/27.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var parkingLots: [ParkingLot] = []
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false
    @Published var errorMessage: String?

    private let apiService: APIService
    private var searchTask: Task<Void, Never>?
    private var currentKeyword: String = ""
    private var pagination: Pagination?

    init(apiService: APIService = .shared) {
        self.apiService = apiService
    }

    func fetchParkingLots(keyword: String, page: Int = 1, limit: Int = 20) async {
        // cancel previous search task
        searchTask?.cancel()

        guard !keyword.isEmpty else {
            parkingLots = []
            isLoading = false
            currentKeyword = ""
            return
        }

        currentKeyword = keyword

        // create new search task with debounce
        searchTask = Task {
            // debounce: wait 0.3 seconds
            try? await Task.sleep(nanoseconds: 300_000_000)

            // check if task was cancelled
            guard !Task.isCancelled else { return }

            isLoading = true
            errorMessage = nil

            do {
                let request = ParkingLotsRequest(page: page,
                                                 limit: limit,
                                                 keyword: keyword)
                let response = try await apiService.fetchParkingLots(request: request)

                // check if task was cancelled before updating
                guard !Task.isCancelled else { return }

                parkingLots = response.data
                pagination = response.pagination
            } catch {
                // check if task was cancelled
                guard !Task.isCancelled else { return }

                errorMessage = error.localizedDescription
                parkingLots = []
                print("Failed to fetch parking lots: \(error)")
            }

            isLoading = false
        }
        await searchTask?.value
    }

    func loadNextPage() async {
        guard let pagination = pagination,
              pagination.page < pagination.totalPages,
              !isLoading,
              !isLoadingMore,
              !currentKeyword.isEmpty else {
            return
        }

        isLoadingMore = true
        errorMessage = nil

        do {
            let nextPage = pagination.page + 1
            let request = ParkingLotsRequest(page: nextPage,
                                             limit: pagination.limit,
                                             keyword: currentKeyword)
            let response = try await apiService.fetchParkingLots(request: request)

            // Append new data to existing list
            parkingLots.append(contentsOf: response.data)
            self.pagination = response.pagination
        } catch {
            errorMessage = error.localizedDescription
            print("Failed to load next page: \(error)")
        }

        isLoadingMore = false
    }

    func shouldLoadNextPage(currentItem: ParkingLot) -> Bool {
        guard let lastIndex = parkingLots.lastIndex(where: { $0.id == currentItem.id }),
              parkingLots.count - lastIndex <= 3,
              let pagination = pagination,
              pagination.page < pagination.totalPages else {
            return false
        }
        return true
    }

    func clearResults() {
        searchTask?.cancel()
        parkingLots = []
        pagination = nil
        errorMessage = nil
        isLoading = false
        isLoadingMore = false
        currentKeyword = ""
    }
}
