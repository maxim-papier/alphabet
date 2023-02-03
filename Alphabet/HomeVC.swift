import UIKit

class HomeVC: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let reuseCellIdentifier = "cell"
    private let reuseFooterIdentifier = "footer"
    private let reuseHeaderIdentifier = "header"
    
    private let letters: [String] = [
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
        "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
        "U", "V", "W", "X", "Y", "Z"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    
    func setUp() {
        registerClassesForReuse()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        setConstraints()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


// MARK: - Data source

extension HomeVC: UICollectionViewDataSource {
    
    
    func registerClassesForReuse() {
        
        collectionView.register(
            LetterCollectionViewCell.self,
            forCellWithReuseIdentifier: reuseCellIdentifier) //Cell
        
        collectionView.register(
            SupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: reuseHeaderIdentifier) //Header
        
        collectionView.register(
            SupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: reuseFooterIdentifier) //Footer
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return letters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? LetterCollectionViewCell
        
        cell?.titleLabel.text = letters[indexPath.row]
        return cell!
    }
    
    /// Define the method for providing a supplementary view for a collection view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // Define a variable to store the identifier for the view to be dequeued
        var id: String
        
        // Check the kind of supplementary view requested
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            // If it's a header, use the header identifier
            id = reuseHeaderIdentifier
        case UICollectionView.elementKindSectionFooter:
            // If it's a footer, use the footer identifier
            id = reuseFooterIdentifier
        default:
            // If it's neither a header nor a footer, set the identifier to an empty string
            id = ""
        }
        
        // Dequeue a reusable view using the identifier, cast it to a custom class called `SupplementaryView`, and return it
        guard let supplementView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as? SupplementaryView else { return .init() }
        
        // Set the text of the title label in the supplementary view
        supplementView.titleLabel.text = ">> SUPPLEMENTARY IS HERE <<"
        
        // Return the configured supplementary view
        return supplementView
    }
}

/// Extension to the HomeVC class to conform to the UICollectionViewDelegateFlowLayout protocol
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(
            collectionView,
            viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
            at: indexPath)
        
        return headerView.systemLayoutSizeFitting(CGSize(
            width: collectionView.frame.width,
            height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
    
    
    
    // Define the size of the footer for a particular section in the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        // Create an index path for the specified section and row
        let indexPath = IndexPath(row: 0, section: section)
        
        // Get the footer view for the specified section
        let footerView = self.collectionView(
            collectionView,
            viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter,
            at: indexPath)
        
        // Return the size of the footer view based on the width of the collection view and the height of the content
        return footerView.systemLayoutSizeFitting(CGSize(
            width: collectionView.frame.width, // Set the width to the width of the collection view
            height: UIView.layoutFittingExpandedSize.height), // Set the height to the maximum height the footer view can expand to while still fitting its content
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
}


extension HomeVC: UICollectionViewDelegate {
    
    
    
}
