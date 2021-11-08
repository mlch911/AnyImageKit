//
//  EditorTheme.swift
//  AnyImageKit
//
//  Created by 蒋惠 on 2021/11/7.
//  Copyright © 2021 AnyImageProject.org. All rights reserved.
//

import UIKit

/// UI Theme for Editor
public class EditorTheme: StringConfigProtocol {
    
    /// Custom color storage
    private var colors: [ColorConfigKey: UIColor] = [:]
    
    /// Custom icon storage
    private var icons: [IconConfigKey: UIImage] = [:]
    
    /// Custom string storage
    private var strings: [StringConfigKey: String] = [:]
    
    /// Config label
    internal var labelConfiguration: [LabelConfigKey: LabelConfigObject] = [:]
    
    /// Config button
    internal var buttonConfiguration: [ButtonConfigKey: ButtonConfigObject] = [:]
    
    public init() {
        
    }
    
    /// Set custom color
    public subscript(color key: ColorConfigKey) -> UIColor {
        get { colors[key] ?? key.defaultValue() }
        set { colors[key] = newValue }
    }
    
    /// Set custom icon
    public subscript(icon key: IconConfigKey) -> UIImage? {
        get { icons[key] ?? key.defaultValue() }
        set { icons[key] = newValue }
    }
    
    /// Set custom string
    /// - Note: Please set localized text if your app support multiple languages
    public subscript(string key: StringConfigKey) -> String {
        get { strings[key] ?? defaultStringValue(for: key) }
        set { strings[key] = newValue }
    }
    
    /// Configuration Label if you needed
    /// - Note: DONOT set hidden/enable properties
    public func configurationLabel(for key: LabelConfigKey, configurable: @escaping ((UILabel) -> Void)) {
        labelConfiguration[key] = LabelConfigObject(key: key, configurable: configurable)
    }
    
    /// Configuration Button if you needed
    /// - Note: DONOT set hidden/enable properties
    public func configurationButton(for key: ButtonConfigKey, configurable: @escaping ((UIButton) -> Void)) {
        buttonConfiguration[key] = ButtonConfigObject(key: key, configurable: configurable)
    }
}

// MARK: - Colors
extension EditorTheme {
    
    public enum ColorConfigKey: Hashable {
        
        /// Main Color
        case main
        
        func defaultValue() -> UIColor {
            switch self {
            case .main:
                return Palette.main
            }
        }
    }
}

// MARK: - Icon
extension EditorTheme {
    
    public enum IconConfigKey: String, Hashable {
        
        /// 25*25
        case checkMark = "CheckMark"
        /// 25*25
        case xMark = "XMark"
        /// 30*30
        case returnBackButton = "ReturnBackButton"
        
        /// 25*25
        case photoToolBrush = "PhotoToolBrush"
        /// 25*25
        case photoToolText = "PhotoToolText"
        /// 25*25
        case photoToolCrop = "PhotoToolCrop"
        /// 25*25
        case photoToolMosaic = "PhotoToolMosaic"
        
        /// 25*25
        case photoToolUndo = "PhotoToolUndo"
        /// 25*25
        case photoToolCropTrunLeft = "PhotoToolCropTrunLeft"
        /// 25*25
        case photoToolCropTrunRight = "PhotoToolCropTrunRight"
        /// 25*25
        case photoToolMosaicDefault = "PhotoToolMosaicDefault"
        
        /// 25*25
        case textNormalIcon = "TextNormalIcon"
        /// 25*25
        case trash = "Trash"
        
        /// 20*50
        case videoCropLeft = "VideoCropLeft"
        /// 20*50
        case videoCropRight = "VideoCropRight"
        /// 30*30
        case videoPauseFill = "VideoPauseFill"
        /// 30*30
        case videoPlayFill = "VideoPlayFill"
        /// 30*30
        case videoToolVideo = "VideoToolVideo"
        
        func defaultValue() -> UIImage? {
            return BundleHelper.image(named: rawValue, module: .editor)
        }
    }
}

// MARK: - String
extension EditorTheme {
    
    private func defaultStringValue(for key: StringConfigKey) -> String {
        return BundleHelper.localizedString(key: key.rawValue, module: .editor)
    }
}

extension StringConfigKey {
    
    public static let editorBrush = StringConfigKey(rawValue: "BRUSH")
    public static let editorCrop = StringConfigKey(rawValue: "CROP")
    public static let editorMosaic = StringConfigKey(rawValue: "MOSAIC")
    public static let editorInputText = StringConfigKey(rawValue: "INPUT_TEXT")
    public static let editorFree = StringConfigKey(rawValue: "FREE")
    
    public static let editorDragHereToRemove = StringConfigKey(rawValue: "DRAG_HERE_TO_REMOVE")
    public static let editorReleaseToRemove = StringConfigKey(rawValue: "RELEASE_TO_REMOVE")
}

// MARK: - Label
extension EditorTheme {
    
    struct LabelConfigObject: Equatable {
        let key: LabelConfigKey
        let configurable: ((UILabel) -> Void)
        
        static func == (lhs: EditorTheme.LabelConfigObject, rhs: EditorTheme.LabelConfigObject) -> Bool {
            return lhs.key == rhs.key
        }
    }
    
    public enum LabelConfigKey: Hashable {
        
        case cropOption
        case trash
        case videoTimeline
    }
}

// MARK: - Button
extension EditorTheme {
    
    struct ButtonConfigObject: Equatable {
        let key: ButtonConfigKey
        let configurable: ((UIButton) -> Void)
        
        static func == (lhs: EditorTheme.ButtonConfigObject, rhs: EditorTheme.ButtonConfigObject) -> Bool {
            return lhs.key == rhs.key
        }
    }
    
    public enum ButtonConfigKey: Hashable {
        
        case back
        case cancel
        case done
        
        case photoOptions(EditorPhotoToolOption)
        case videoOptions(EditorVideoToolOption)
        
        case undo
        case textSwitch
        
        case cropRotation
        case cropCancel
        case cropReset
        case cropDone
        
        case videoPlayPluse
        case videoCropLeft
        case videoCropRight
    }
}
