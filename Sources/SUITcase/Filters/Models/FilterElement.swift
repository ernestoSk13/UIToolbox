//
//  FilterElement.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 13/01/21.
//

import Foundation

public enum FilterType: Equatable {
    case dimension
    case topBottomDimension
    case measure
    case dateRange
    case relativeDate
}

public class FilterElement: ObservableObject, Hashable, Identifiable {
    var filterID: String
    var type: FilterType
    var columnLabel: String
    var isEnabled: Bool
    
    public static func == (lhs: FilterElement, rhs: FilterElement) -> Bool {
        lhs.filterID == rhs.filterID
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(filterID)
    }
    
    public init(filterId: String,
         type: FilterType,
         columnLabel: String,
         isEnabled: Bool = true) {
        self.filterID = filterId
        self.type = type
        self.columnLabel = columnLabel
        self.isEnabled = isEnabled
    }
}

public class FilterMeasure: FilterElement {
    public var range: Range<Double>
    /// greater or equal
    @Published public var initialValue: Double?
    /// less or equal
    @Published public var finalValue: Double?
    
    public init(range: Range<Double>,
         initialValue: Double?,
         finalValue: Double?,
         filter: FilterElement) {
        self.range = range
        self.initialValue = initialValue
        self.finalValue = finalValue
        super.init(filterId: filter.filterID,
                   type: filter.type,
                   columnLabel: filter.columnLabel,
                   isEnabled: filter.isEnabled)
    }
}

public class FilterDimension: FilterElement {
    var elements: [String]
    @Published var selected: [Int]
    
    public init(elements: [String],
         selected: [Int],
         filter: FilterElement) {
        self.elements = elements
        self.selected = selected
        super.init(filterId: filter.filterID,
                   type: filter.type,
                   columnLabel: filter.columnLabel,
                   isEnabled: filter.isEnabled)
    }
}

public class FilterTopBottomDimension: FilterElement {
    var count: Double?
    
    public init(count: Double?,
         filter: FilterElement) {
        self.count = count
        super.init(filterId: filter.filterID,
                   type: filter.type,
                   columnLabel: filter.columnLabel,
                   isEnabled: filter.isEnabled)
    }
}

public class FilterDateRange: FilterElement {
    var initialDate: Date?
    var finalDate: Date?
    
    public init(initialDate: Date?,
         finalDate: Date?,
         filter: FilterElement) {
        self.initialDate = initialDate
        self.finalDate = finalDate
        super.init(filterId: filter.filterID,
                   type: filter.type,
                   columnLabel: filter.columnLabel,
                   isEnabled: filter.isEnabled)
    }
}

public enum FilterDateRangeType: String {
    case last
    case next
    case periodOfDate
}

/// Enum to indicate date period level
public enum FilterRelativeDateTimeLevel: String {
    case month
    case quarter
    case year
    case week
    case day
}

public class FilterRelativeDate: FilterElement {
    public var relativeDateRangeType: FilterDateRangeType
    public var relativeDateNumberOfPeriods: String?
    public var relativeDateRelativeToType: String?
    public var relativeDateTimeLevel: FilterRelativeDateTimeLevel
    
    init(relativeDateRangeType: String,
         relativeDateNumberOfPeriods: String?,
         relativeDateRelativeToType: String?,
         relativeDateTimeLevel: String,
         filter: FilterElement) {
        self.relativeDateRangeType = FilterDateRangeType(rawValue: relativeDateRangeType) ?? .last
        self.relativeDateNumberOfPeriods = relativeDateNumberOfPeriods
        self.relativeDateRelativeToType = relativeDateRelativeToType
        self.relativeDateTimeLevel = FilterRelativeDateTimeLevel(rawValue: relativeDateTimeLevel) ?? .month
        super.init(filterId: filter.filterID,
                   type: filter.type,
                   columnLabel: filter.columnLabel,
                   isEnabled: filter.isEnabled)
    }
}
