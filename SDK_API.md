# Passio PassioRemodelAISDK 

## Version  2.2.21
```Swift
import AVFoundation
import Accelerate
import CommonCrypto
import CoreML
import CoreMedia
import CoreMotion
import Foundation
import Metal
import MetalPerformanceShaders
import SQLite3
import SwiftUI
import UIKit
import VideoToolbox
import Vision
import _Concurrency
import _StringProcessing
import simd

public struct ArchitectureStructure : Codable {

    public let modelName: String?

    public let modelId: String?

    public let datasetId: String?

    public let trainingRunId: String?

    public let filename: PassioRemodelAISDK.FileName?

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws
}

/// The ClassificationCandidate protocol returns the classification candidate result delegate.
public protocol ClassificationCandidate {

    /// PassioID recognized by the MLModel
    var passioID: PassioRemodelAISDK.PassioID { get }

    /// Confidence (0.0 to 1.0) of the associated PassioID recognized by the MLModel
    var confidence: Double { get }
}

/// The CustomCandidate protocol returns custom object detection candidate
public protocol CustomCandidate {

    var label: String? { get }

    var passioID: PassioRemodelAISDK.PassioID { get }

    /// Confidence (0.0 to 1.0) of the associated PassioID recognized by the MLModel
    var confidence: Double { get }

    /// boundingBox CGRect representing the predicted bounding box in normalized coordinates.
    var boundingBox: CGRect { get }

    /// The image that the detection was preformed upon
    var croppedImage: UIImage? { get }
}

public protocol CustomClassificationCandidate : PassioRemodelAISDK.ClassificationCandidate {

    /// Human readable label by the MLModel
    var label: String? { get }
}

/// Implement the CustomObjectDetectionDelegate protocol to receive delegate methods from the object detection
public protocol CustomDetectionDelegate : AnyObject {

    /// Delegate for CustomDetection
    /// - Parameters:
    ///   - odCandidates: Object Detection candidates
    ///   - classCandidates: Classification candidates
    ///   - hnnCandidates: HNN candidates
    ///   - image: Image used for detection
    func customDetectionResult(customCandidates: [PassioRemodelAISDK.CustomCandidate]?, hnnCandidates: [PassioRemodelAISDK.CustomClassificationCandidate]?, classCandidates: [PassioRemodelAISDK.CustomClassificationCandidate]?, image: UIImage?)
}

public struct EnsembleArchitecture : Codable {

    public let name: String

    public let structure: [PassioRemodelAISDK.ArchitectureStructure]

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws
}

public typealias FileLocalURL = URL

public typealias FileName = String

public enum IconSize : String {

    case px90

    case px180

    case px360

    /// Creates a new instance with the specified raw value.
    ///
    /// If there is no value of the type that corresponds with the specified raw
    /// value, this initializer returns `nil`. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     print(PaperSize(rawValue: "Legal"))
    ///     // Prints "Optional("PaperSize.Legal")"
    ///
    ///     print(PaperSize(rawValue: "Tabloid"))
    ///     // Prints "nil"
    ///
    /// - Parameter rawValue: The raw value to use for the new instance.
    public init?(rawValue: String)

    /// The raw type that can be used to represent all values of the conforming
    /// type.
    ///
    /// Every distinct value of the conforming type has a corresponding unique
    /// value of the `RawValue` type, but there may be values of the `RawValue`
    /// type that don't have a corresponding value of the conforming type.
    public typealias RawValue = String

    /// The corresponding value of the raw type.
    ///
    /// A new instance initialized with `rawValue` will be equivalent to this
    /// instance. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     let selectedSize = PaperSize.Letter
    ///     print(selectedSize.rawValue)
    ///     // Prints "Letter"
    ///
    ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
    ///     // Prints "true"
    public var rawValue: String { get }
}

extension IconSize : Equatable {
}

extension IconSize : Hashable {
}

extension IconSize : RawRepresentable {
}

public struct LabelMetaData : Codable {

    public let displayName: String?

    public let synonyms: [String : [PassioRemodelAISDK.SynonymLang]]?

    public let models: [String]?

    public let labelId: String

    public let description: String?

    public var modelName: String? { get }

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws
}

public enum ModelForDetection : String, CaseIterable {

    case environment

    case surfaceMaterial

    case abnormality

    public var mlModelName: String { get }

    /// Creates a new instance with the specified raw value.
    ///
    /// If there is no value of the type that corresponds with the specified raw
    /// value, this initializer returns `nil`. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     print(PaperSize(rawValue: "Legal"))
    ///     // Prints "Optional("PaperSize.Legal")"
    ///
    ///     print(PaperSize(rawValue: "Tabloid"))
    ///     // Prints "nil"
    ///
    /// - Parameter rawValue: The raw value to use for the new instance.
    public init?(rawValue: String)

    /// A type that can represent a collection of all values of this type.
    public typealias AllCases = [PassioRemodelAISDK.ModelForDetection]

    /// The raw type that can be used to represent all values of the conforming
    /// type.
    ///
    /// Every distinct value of the conforming type has a corresponding unique
    /// value of the `RawValue` type, but there may be values of the `RawValue`
    /// type that don't have a corresponding value of the conforming type.
    public typealias RawValue = String

    /// A collection of all values of this type.
    public static var allCases: [PassioRemodelAISDK.ModelForDetection] { get }

    /// The corresponding value of the raw type.
    ///
    /// A new instance initialized with `rawValue` will be equivalent to this
    /// instance. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     let selectedSize = PaperSize.Letter
    ///     print(selectedSize.rawValue)
    ///     // Prints "Letter"
    ///
    ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
    ///     // Prints "true"
    public var rawValue: String { get }
}

extension ModelForDetection : Equatable {
}

extension ModelForDetection : Hashable {
}

extension ModelForDetection : RawRepresentable {
}

/// The ObjectDetectionCandidate protocol returns the object detection result
public protocol ObjectDetectionCandidate : PassioRemodelAISDK.ClassificationCandidate {

    /// boundingBox CGRect representing the predicted bounding box in normalized coordinates.
    var boundingBox: CGRect { get }
}

/// Implement the ObjectDetectionDelegate protocol to receive delegate methods from the object detection
public protocol ObjectDetectionDelegate : AnyObject {

    /// Called each frame, returns the top 5 ObjectDetectionCandidates and the relevant image.
    /// - Parameter candidates: Array of ObjectDetectionCandidate
    /// - Parameter image: Image used for detection
    func objectDetectionResult(candidates: [PassioRemodelAISDK.ObjectDetectionCandidate], image: UIImage?)
}

/// PassioConfiguration is needed configure the SDK with the following options:
public struct PassioConfiguration : Equatable {

    /// This is the key you have received from Passio. A valid key must be used.
    public var key: String

    /// If you have chosen to remove the files from the SDK and provide the SDK different URLs for this files please use this variable.
    public var filesLocalURLs: [PassioRemodelAISDK.FileLocalURL]?

    /// If you set this option to true, the SDK will download the models relevant for this version from Passio's bucket.
    public var sdkDownloadsModels: Bool

    /// If you have problems configuring the SDK, set debugMode = 1 to get more debugging information.
    public var debugMode: Int

    /// If you set allowInternetConnection = false without working with Passio the SDK will not work. The SDK will not connect to the internet for key validations.
    public var allowInternetConnection: Bool

    public init(key: String)

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: PassioRemodelAISDK.PassioConfiguration, b: PassioRemodelAISDK.PassioConfiguration) -> Bool
}

/// PassioID (typealias String) is and idetifier used throughout the SDK.
public typealias PassioID = String

public struct PassioMetadata : Codable {

    public let projectId: String

    public let ensembleId: String?

    public let ensembleVersion: Int?

    public let architecture: PassioRemodelAISDK.EnsembleArchitecture?

    public var labelMetadata: [PassioRemodelAISDK.PassioID : PassioRemodelAISDK.LabelMetaData]? { get }

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws
}

public struct PassioMetadataService {

    public var passioMetadata: PassioRemodelAISDK.PassioMetadata? { get }

    public var getModelNames: [String]? { get }

    public var getlabelIcons: [PassioRemodelAISDK.PassioID : PassioRemodelAISDK.PassioID]? { get }

    public func getPassioIDs(byModelName: String) -> [PassioRemodelAISDK.PassioID]?

    public func getLabel(passioID: PassioRemodelAISDK.PassioID, languageCode: String = "en") -> String?

    public init(metatadataURL: URL? = nil)
}

/// PassioMode will report the mode the SDK is currently in.
public enum PassioMode {

    case notReady

    case isBeingConfigured

    case isDownloadingModels

    case isReadyForDetection

    case failedToConfigure

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: PassioRemodelAISDK.PassioMode, b: PassioRemodelAISDK.PassioMode) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
    ///   compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    public var hashValue: Int { get }
}

extension PassioMode : Equatable {
}

extension PassioMode : Hashable {
}

public class PassioRemodelAI {

    public var version: String { get }

    /// Shared Instance
    public class var shared: PassioRemodelAISDK.PassioRemodelAI { get }

    /// Get the PassioStatus directly or implement the PassioStatusDelegate for updates.
    public var status: PassioRemodelAISDK.PassioStatus { get }

    /// Delegate to track PassioStatus changes. You will get the same status via the configure function.
    weak public var statusDelegate: PassioRemodelAISDK.PassioStatusDelegate?

    /// Available frames per seconds
    public enum FramesPerSecond : Int32 {

        case one

        case two

        case three

        case four

        /// Creates a new instance with the specified raw value.
        ///
        /// If there is no value of the type that corresponds with the specified raw
        /// value, this initializer returns `nil`. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     print(PaperSize(rawValue: "Legal"))
        ///     // Prints "Optional("PaperSize.Legal")"
        ///
        ///     print(PaperSize(rawValue: "Tabloid"))
        ///     // Prints "nil"
        ///
        /// - Parameter rawValue: The raw value to use for the new instance.
        public init?(rawValue: Int32)

        /// The raw type that can be used to represent all values of the conforming
        /// type.
        ///
        /// Every distinct value of the conforming type has a corresponding unique
        /// value of the `RawValue` type, but there may be values of the `RawValue`
        /// type that don't have a corresponding value of the conforming type.
        public typealias RawValue = Int32

        /// The corresponding value of the raw type.
        ///
        /// A new instance initialized with `rawValue` will be equivalent to this
        /// instance. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     let selectedSize = PaperSize.Letter
        ///     print(selectedSize.rawValue)
        ///     // Prints "Letter"
        ///
        ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
        ///     // Prints "true"
        public var rawValue: Int32 { get }
    }

    /// Call this API to configure the SDK
    /// - Parameters:
    ///   - PassioConfiguration: Your desired configuration, must include your developer key
    ///   - completion: Receive back the status of the SDK
    @available(iOS 13.0, *)
    public func configure(passioConfiguration: PassioRemodelAISDK.PassioConfiguration, completion: @escaping (PassioRemodelAISDK.PassioStatus) -> Void)

    /// Shut down the Passio SDK and release all resources
    public func shutDownPassioSDK()

    @available(iOS 13.0, *)
    public func startCustomObjectDetection(modelName: String, customDetectionDelegate: PassioRemodelAISDK.CustomDetectionDelegate, completion: (Bool) -> Void)

    public func stopCustomDetection()

    public func getPreviewLayer() -> AVCaptureVideoPreviewLayer?

    /// Don't call this function if you need to use the Passio layer again. Only call this function to set the PassioSDK Preview layer to nil
    public func removeVidoeLayer()

    /// Use this function to get the bounding box relative to the previewLayerBonds
    /// - Parameter boundingBox: The bounding box from the delegate
    /// - Parameter preview: The preview layer bounding box
    public func transformCGRectForm(boundingBox: CGRect, toRect: CGRect) -> CGRect

    /// Lookup for an icon for a PassioID. You will receive an icon and a bool, The boolean is true if the icons is food icon or false if it's a placeholder icon. If you get false you can use the asycronous funcion to "fetchIconFor" the icons from the web.
    /// - Parameters:
    ///   - passioID: PassioIC
    ///   - size: 90, 180 or 360 px
    ///   - entityType: PassioEntityType to return the right placeholder.
    /// - Returns: UIImage and a bool, The boolean is true if the icons is food icon or false if it's a placeholder icon. If you get false you can use the asycronous funcion to "fetchIconFor" the icons from
    public func lookupIconFor(passioID: PassioRemodelAISDK.PassioID, size: PassioRemodelAISDK.IconSize = IconSize.px90, activeModelType: PassioRemodelAISDK.ModelForDetection) -> (UIImage, Bool)

    /// Fetch icons from the web.
    /// - Parameters:
    ///   - passioID: PassioIC
    ///   - size: 90, 180 or 360 px
    ///   - entityType: PassioEntityType to return the right placeholder.
    ///   - completion: Optional Icon.
    public func fetchIconFor(passioID: PassioRemodelAISDK.PassioID, size: PassioRemodelAISDK.IconSize = IconSize.px90, completion: @escaping (UIImage?) -> Void)

    /// Lookup an icon by its name
    /// - Parameter imageName: the name of the image.
    public func defaultIconFor(activeModelType: PassioRemodelAISDK.ModelForDetection) -> UIImage

    public func detectCustomPassioIDIn(image: UIImage, modelName: String, completion: @escaping ([PassioRemodelAISDK.CustomCandidate]?, [PassioRemodelAISDK.CustomClassificationCandidate]?) -> Void)
}

extension PassioRemodelAI : PassioRemodelAISDK.PassioStatusDelegate {

    public func completedDownloadingAllFiles(filesLocalURLs: [PassioRemodelAISDK.FileLocalURL])

    public func completedDownloadingFile(fileLocalURL: PassioRemodelAISDK.FileLocalURL, filesLeft: Int)

    public func downloadingError(message: String)

    public func passioStatusChanged(status: PassioRemodelAISDK.PassioStatus)

    public func passioProcessing(filesLeft: Int)
}

extension PassioRemodelAI.FramesPerSecond : Equatable {
}

extension PassioRemodelAI.FramesPerSecond : Hashable {
}

extension PassioRemodelAI.FramesPerSecond : RawRepresentable {
}

/// PassioSDKError will return the error with errorDescription if the configuration has failed. 
public enum PassioSDKError : LocalizedError {

    case canNotRunOnSimulator

    case keyNotValid

    case licensedKeyHasExpired

    case modelsNotValid

    case modelsDownloadFailed

    case noModelsFilesFound

    case noInternetConnection

    case notLicensedForThisProject

    /// A localized message describing what error occurred.
    public var errorDescription: String? { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: PassioRemodelAISDK.PassioSDKError, b: PassioRemodelAISDK.PassioSDKError) -> Bool

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
    ///   compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    public var hashValue: Int { get }
}

extension PassioSDKError : Equatable {
}

extension PassioSDKError : Hashable {
}

/// PassioStatus is returned at the end of the configuration of the SDK.
public struct PassioStatus {

    /// The mode had several values . isReadyForDetection is full success
    public var mode: PassioRemodelAISDK.PassioMode { get }

    /// If the SDK is missing files or new files could be used. It will send the list of files needed for the update.
    public var missingFiles: [PassioRemodelAISDK.FileName]? { get }

    /// A string with more verbose information related to the configuration of the SDK
    public var debugMessage: String? { get }

    /// The error in case the SDK failed to configure
    public var error: PassioRemodelAISDK.PassioSDKError? { get }

    /// The version of the latest models that are now used by the SDK.
    public var activeModels: Int? { get }
}

/// Implement the protocol to receive status updates
public protocol PassioStatusDelegate : AnyObject {

    func passioStatusChanged(status: PassioRemodelAISDK.PassioStatus)

    func passioProcessing(filesLeft: Int)

    func completedDownloadingAllFiles(filesLocalURLs: [PassioRemodelAISDK.FileLocalURL])

    func completedDownloadingFile(fileLocalURL: PassioRemodelAISDK.FileLocalURL, filesLeft: Int)

    func downloadingError(message: String)
}

public struct SynonymLang : Codable {

    public let synonym: String?

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws
}

extension simd_float4x4 : ContiguousBytes {

    /// Calls the given closure with the contents of underlying storage.
    ///
    /// - note: Calling `withUnsafeBytes` multiple times does not guarantee that
    ///         the same buffer pointer will be passed in every time.
    /// - warning: The buffer argument to the body should not be stored or used
    ///            outside of the lifetime of the call to the closure.
    public func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R
}

extension UIImageView {

    @MainActor public func loadPassioIconBy(passioID: PassioRemodelAISDK.PassioID, activeModelType: PassioRemodelAISDK.ModelForDetection, size: PassioRemodelAISDK.IconSize = .px90, completion: @escaping (PassioRemodelAISDK.PassioID, UIImage) -> Void)
}

infix operator .+ : DefaultPrecedence

infix operator ./ : DefaultPrecedence


```
<sup>Copyright 2023 Passio Inc</sup>
