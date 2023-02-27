//
//  ViewController.swift
//  DiffableDataSourceGAHA
//
//  Created by Aleksandr Eliseev on 24.02.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, CellModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, CellModel>
    
    private enum ItemSize: CGFloat {
        case half = 0.5
        case third = 0.333
        case quarter = 0.25
    }
        
    private var gridItemSize: ItemSize = .third
    private var cellModel: [CellModel] = []
    private var sections = [0]
    
    private var factory: Factory?
    private var dataSource: DataSource?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        factory = Factory(viewModelDelegate: self, numbersLoader: NumbersLoader())
        factory?.loadNumbers()
        
        createCollectionView()
        
    }
    
    // MARK: CollectionView
    
    private func createCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
//     MARK: Layout
    
    private func createDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { [unowned self] collectionView, indexPath, itemIdentifier in
            return self.cell(collectionView: collectionView, for: indexPath, with: itemIdentifier)
        })
        
        dataSource?.apply(createSnapshot())
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(gridItemSize.rawValue), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.26))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    // MARK: Snapshot
    
    private func createSnapshot() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        snapshot.appendItems(cellModel)
        return snapshot
    }
    
    // MARK: Cell
    
    private func cell(collectionView: UICollectionView, for indexPath: IndexPath, with item: CellModel) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(with: item)
        return cell
    }
}

// MARK: ViewModel Delegate (DataSource creation)

extension ViewController: ViewModelDelegate {
    func didRFormedModel(model: [CellModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.cellModel = model
            self.createDataSource()
        }
    }
}
