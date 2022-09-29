//
//  DatePickerBuilder.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/23.
//

import UIKit

protocol DatePickerBuilder: UseAutoLayout {
    associatedtype Builder
    
    var datePicker: UIDatePicker { get }
    
    func setStyle(_ style: UIDatePickerStyle) -> Builder
    func setMode(_ mode: UIDatePicker.Mode) -> Builder
    func setLocale(_ identifier: String) -> Builder
    func setTimeZone(_ timeZone: TimeZone) -> Builder
}

final class DefaultDatePickerBuilder: DatePickerBuilder {
    typealias Builder = DefaultDatePickerBuilder
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    func setStyle(_ style: UIDatePickerStyle) -> DefaultDatePickerBuilder {
        datePicker.preferredDatePickerStyle = style
        return self
    }
    
    func setMode(_ mode: UIDatePicker.Mode) -> DefaultDatePickerBuilder {
        datePicker.datePickerMode = mode
        return self
    }
    
    func setLocale(_ identifier: String) -> DefaultDatePickerBuilder {
        datePicker.locale = Locale(identifier: identifier)
        return self
    }
    
    func setTimeZone(_ timeZone: TimeZone) -> DefaultDatePickerBuilder {
        datePicker.timeZone = timeZone
        return self
    }
    
    func useAutoLayout() -> DefaultDatePickerBuilder {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
