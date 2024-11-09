//
//  Extensions.swift
//  EcommerceAdditionalFeatures
//
//  Created by muhammed dursun on 9.11.2024.
//

import SDWebImage

// MARK: TypeAlias

typealias Handler = (() -> Void)
typealias Callback<T> = ((T) -> Void)



//MARK: UIFont
extension UIFont {
    
    
    static func setDynamicFont(size: CGFloat) -> UIFont {
        let width = Device.width
        let divisor: CGFloat = Device.isAnIpad ? 530 : 375
        let multiplier = width / divisor
        
        return UIFont.systemFont(ofSize: size * multiplier)
    }
}



//MARK: Encodable
extension Encodable {
    
    var dictionary: [String: Any] {
        guard
            let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        else { return [:] }
        
        return dictionary
    }
    
    
    var json: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard
            let data = try? encoder.encode(self),
            let json = String(data: data, encoding: .utf8)
        else { return "" }
        
        return json
    }
}



//MARK: UIImage
extension UIImage {
    static let iconWarning = UIImage(systemName: "exclamationmark.triangle")
    static let iconError = UIImage(systemName: "exclamationmark.circle")
    static let iconSuccess = UIImage(systemName: "checkmark.circle")
    static let iconProfile = UIImage(systemName: "person.crop.circle")
    static let iconInfo = UIImage(systemName: "info.circle")
    static let iconAdd = UIImage(systemName: "plus")
//    static let iconBack = UIImage(systemName: "arrow.backward")
//    static let iconAdd = UIImage(systemName: "plus")
//    static let iconEdit = UIImage(systemName: "pencil")
//    static let iconLocation = UIImage(systemName: "mappin.and.ellipse")
//    static let iconRight = UIImage(systemName: "chevron.right")
//    static let iconInfo = UIImage(systemName: "info.circle")
//    static let iconLeft = UIImage(systemName: "chevron.left")
//    static let iconRemove = UIImage(systemName: "minus")
//    static let iconCircle = UIImage(systemName: "circle.fill")
//    static let iconBlock = UIImage(systemName: "hand.raised")
//    static let iconCheck = UIImage(systemName: "checkmark.square.fill")
//    static let iconUncheck = UIImage(systemName: "square")
}



//MARK: UIColor
//extension UIColor {
//    static let error = UIColor(named: "error")!
//    static let success = UIColor(named: "success")!
//    static let warning = UIColor(named: "warning")!
//    static let snow = UIColor(named: "snow")!
//}



//MARK: UIImageView
extension UIImageView {
    
    
    func load(photoUrl: String?, completion: Callback<UIImage?>? = nil) {
        guard let photoUrl = photoUrl else {
            image = nil
            return
        }
        
        let url = URL(string: photoUrl)
        
        sd_setImage(with: url) { image, _, _, _ in
            completion?(image)
        }
    }
}
