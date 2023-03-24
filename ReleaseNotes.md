# Passio Remodel-AI iOS SDK Release Notes

## V2.2.21
Updated Models

## V2.2.19
Updated Models

## V2.2.17
Updated Models

## V2.2.15
Updated Models

## V2.2.13
Updated Models

### Additional API 
```swift
public struct PassioMetadataService {

    public var passioMetadata: PassioNutritionAISDK.PassioMetadata? { get }

    public var getModelNames: [String]? { get }

    public var getlabelIcons: [PassioNutritionAISDK.PassioID : PassioNutritionAISDK.PassioID]? { get }

    public func getPassioIDs(byModelName: String) -> [PassioNutritionAISDK.PassioID]?

    public func getLabel(passioID: PassioNutritionAISDK.PassioID, languageCode: String = "en") -> String?

    public init()
}
```

## Version 2.2.11
Updated Models

## Version 2.2.9
Updated Models

## Version 2.2.7
Updated Models

## Version 2.2.5
Updated Models

## Version 2.2.3
Updated Models

## Version  2.2.1
Updated models

## Version  2.2.0
New models, ready for production