//
//  NIbIdentifiable.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit

protocol NIbIdentifiable {
    static var nibName: String? { get }
    static var identity: String? { get }
}

extension NIbIdentifiable {
    static func getNib(for bundle: Bundle = .main) -> UINib? {
        guard let nibName = Self.nibName else { return nil }
        
        return UINib(nibName: nibName, bundle: bundle)
    }
}

extension NIbIdentifiable {
    
   static func loadFromNib(in bundle: Bundle = .main) -> Self? {
       
       guard let nibName = Self.nibName,
                let nib = bundle.loadNibNamed(nibName, owner: nil, options: nil),
                let view = nib.first(where: {$0 is Self}) as? Self
       else {
           return nil
       }
       
        return view
    }
}

extension UITableView {
    func registerCell(identityObject: NIbIdentifiable.Type) {
        guard let identity = identityObject.identity, let nib = identityObject.getNib() else { return }
        
        self.register(nib, forCellReuseIdentifier: identity)
    }
    
    func registerHeaderFooter(identityObject: NIbIdentifiable.Type) {
        guard let identity = identityObject.identity, let nib = identityObject.getNib() else { return }
        
        self.register(nib, forHeaderFooterViewReuseIdentifier: identity)
    }
    
    func dequeueReusableCell(with identity: NIbIdentifiable.Type) -> UITableViewCell? {
        guard let identity = identity.identity else { return nil }
        
        return dequeueReusableCell(withIdentifier: identity)
    }
    
    func dequeueReusableHeaderFooterView(with identity: NIbIdentifiable.Type) -> UITableViewHeaderFooterView? {
        guard let identity = identity.identity else { return nil }
        
        return dequeueReusableHeaderFooterView(withIdentifier: identity)
    }
}
