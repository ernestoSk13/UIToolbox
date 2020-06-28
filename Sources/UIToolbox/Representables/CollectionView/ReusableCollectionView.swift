//
//  ReusableCollectionView.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI

///WIP
//class IdentifiableCollectionCell: UICollectionViewCell {
//    static let reuseIdentifer = "\(IdentifiableCollectionCell.self)"
//}
//
//struct DataSource<T> {
//    let items: [T]
//    let configure: (T, IdentifiableCollectionCell) -> Void
//    let select: (IdentifiableCollectionCell, IndexPath) -> Void
//}
//
//struct ReusableCollectionView<CollectionCell, Item>: UIViewRepresentable where CollectionCell: IdentifiableCollectionCell, Item: Hashable {
//    var items: [Item]
//    var sections: [String]
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIView(context: Context) -> UICollectionView {
//        let collectionView = UICollectionView(frame: CGRect.zero,
//                                              collectionViewLayout: UICollectionViewLayout())
//        collectionView.backgroundColor = .systemBackground
//        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.reuseIdentifer)
//        collectionView.delegate = context.coordinator
//        //collectionView.dataSource = context.coordinator
//        return collectionView
//    }
//
//    func updateUIView(_ uiView: UICollectionView, context: Context) {
//
//    }
//
//    class Coordinator: NSObject, UICollectionViewDelegate {
//        var parent: ReusableCollectionView
//        var dataSource: UICollectionViewDiffableDataSource<String, Item>! = nil
//
//        init(_ collectionView: ReusableCollectionView) {
//            self.parent = collectionView
//        }
//
//        func configureDatasource(_ aCollectionView: UICollectionView) {
//            dataSource = UICollectionViewDiffableDataSource
//                <Section, Negocio>(collectionView: aCollectionView) {
//                (collectionView: UICollectionView, indexPath: IndexPath, negocio: Negocio) -> UICollectionViewCell? in
//                guard let cell = collectionView.dequeueReusableCell(
//                  withReuseIdentifier: BusinessCell.reuseIdentifer,
//                  for: indexPath) as? BusinessCell else { fatalError("Could not create new cell") }
//                    cell.configurarNegocio(negocio)
//                    cell.imageView.sd_setImage(with: negocio.imagenUrl, placeholderImage: UIImage(systemName: "camera")!)
//                return cell
//            }
//
//            dataSource.supplementaryViewProvider = { (
//              collectionView: UICollectionView,
//              kind: String,
//              indexPath: IndexPath) -> UICollectionReusableView? in
//
//              guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
//                ofKind: kind,
//                withReuseIdentifier: HeaderView.reuseIdentifier,
//                for: indexPath) as? HeaderView else { fatalError("Cannot create header view") }
//
//                supplementaryView.label.text = self.parent.subcategoria.valor
//              return supplementaryView
//            }
//
//            let snapshot = snapshotForCurrentState()
//            dataSource.apply(snapshot, animatingDifferences: true)
//        }
//
//        func applySnapshot(animatingDifferences: Bool = true) {
//          let snapshot = snapshotForCurrentState()
//          dataSource.apply(snapshot, animatingDifferences: true)
//        }
//
//        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            if let cell = collectionView.cellForItem(at: indexPath) as? BusinessCell {
//                self.parent.didSelect?(cell.negocio)
//            }
//        }
//
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//                            referenceSizeForHeaderInSection section: Int) -> CGSize {
//            return CGSize.zero
//        }
//        func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<String, Item> {
//          var snapshot = NSDiffableDataSourceSnapshot<String, Item>()
//          snapshot.appendSections([Section.business])
//            let items = self.parent.negocios
//          snapshot.appendItems(items)
//          return snapshot
//        }
//    }
//
//    typealias UIViewType = UICollectionView
//
//
//}
