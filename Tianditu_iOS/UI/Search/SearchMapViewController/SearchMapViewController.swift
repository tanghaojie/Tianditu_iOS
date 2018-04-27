//
//  SearchMapViewController.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/23.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class SearchMapViewController: JTNavigationViewController {
    
    private let mapView = UIView()
    private let transparentView = JTTransparentUIView()
    private let searchPointResultView = SearchPointResultView.loadFromNib()
    private let searchPointResultViewHeight: CGFloat = 120
    private let searchNameResultView = UIView()
    private let searchContentTableView = SearchContentTableView()
    private let searchNameResultViewOpenView = UIView()
    private let searchNameResultViewOpenViewHeight: CGFloat = 40
    private let autoFinishTransformYHeight: CGFloat = 80
    private let closeButton = UIButton()
    private let jtSearchBar = JTSearchBar()
    private let progressView = UIView()
    
    private var searchContentTableViewPan: UIPanGestureRecognizer?
    private var halfTransformY: CGFloat = 0
    private var mode: Mode
    private var text: String?
    private var position: Object_Attribute?
    
    init(position: Object_Attribute) {
        mode = Mode.point
        self.position = position
        super.init(nibName: nil, bundle: nil)
        delegate = self
        setupUI()
    }
    init(text: String) {
        mode = Mode.text
        self.text = text
        super.init(nibName: nil, bundle: nil)
        delegate = self
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        mode = Mode.text
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModeView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard mapView.subviews.count <= 0 else { return }
        setupJTMapView()
    }
    
}
extension SearchMapViewController {
    private func setupJTMapView() {
        let jtMapView = JTMapView.shareInstance
        jtMapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(jtMapView)
        NSLayoutConstraint.activate([
            jtMapView.topAnchor.constraint(equalTo: mapView.topAnchor),
            jtMapView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor),
            jtMapView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            jtMapView.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            ])
    }
}
extension SearchMapViewController {
    
    private func initPoint(position: Object_Attribute) {
        optionalDelegate = nil
        mode = Mode.point
        JTMapView.shareInstance.removeSymbolLayer()
        self.position = position
    }
    private func initText(text: String) {
        optionalDelegate = nil
        mode = Mode.text
        JTMapView.shareInstance.removeSymbolLayer()
        self.text = text
    }
    private func setupModeView() {
        if mode == .point {
            if !showPoint() { return }
            setupPoint()
        } else {
            if !showName() { return }
            setupName()
        }
    }
    private func hideAll() {
        searchPointResultView.isHidden = true
        SearchNameResultViewOffsetToHide(false, showOpenView: false)
        searchNameResultViewOpenView.isHidden = true
    }
    private func showPoint() -> Bool {
        guard let p = position, let _ = p.name else { return false }
        searchPointResultView.isHidden = false
        SearchNameResultViewOffsetToHide(false, showOpenView: false)
        return true
    }
    private func setupPoint() {
        guard let p = position, let n = p.name else { return }
        let region = p.region ?? ""
        let county = p.county ?? ""
        let address = p.address ?? ""
        let detail = region + " " + county + " " + address
        searchPointResultView.set(t: n, d: detail)
        jtSearchBar.text = n
        guard let x = p.x, let y = p.y else { return }
        JTMapView.shareInstance.removeSymbolLayer()
        JTMapView.shareInstance.addSymbolLayerLocationPoints(points: [(x, y)])
        JTMapView.shareInstance.zoom(toScale: 20000, withCenter: AGSPoint(location: CLLocation(latitude: y, longitude: x)), animated: true)
    }
    private func showName() -> Bool {
        if text == nil, let t = text, (t == "" || t.trimmingCharacters(in: .whitespaces) == "") { return false }
        searchPointResultView.isHidden = true
        searchNameResultView.isHidden = false
        searchNameResultViewOpenView.isHidden = true
        return true
    }
    private func setupName() {
        guard let t = text else { return }
        jtSearchBar.text = t
        let a = setupActivityIndicatorView()
        hideAll()
        searchContentTableView.nameSearch(text: t) {
            [weak self]
            result in
            a.removeFromSuperview()
            if !result {
                if let s = self {
                    _ = JTHUD(view: s.full).textOnly(LocalizableStrings.searchFailed, delayTimeIfAutoHide: 1.5)
                }
                return
            }
            guard let s = self else { return }
            s.searchNameResultViewOpenView.isHidden = true
            s.searchNameResultView.isHidden = false
            s.SearchNameResultViewOffsetToHideHalf()
            s.showNameSymbol()
        }
    }
    private func showNameSymbol() {
        JTMapView.shareInstance.removeSymbolLayer()
        let positions = searchContentTableView.positions
        var points = [(x: Double, y: Double)]()
        var maxX: Double? = nil
        var maxY: Double? = nil
        var minX: Double? = nil
        var minY: Double? = nil
        for p in positions {
            guard let x = p.x, let y = p.y else { continue }
            points.append((x: x, y: y))
            if maxX == nil { maxX = x }
            if minX == nil { minX = x }
            if maxY == nil { maxY = y }
            if minY == nil { minY = y }
            if x > maxX! { maxX = x }
            if x < minX! { minX = x }
            if y > maxY! { maxY = y }
            if y < minY! { minY = y }
            if points.count > 10 { break }
        }
        JTMapView.shareInstance.addSymbolLayerLocationPoints(points: points)
        guard let ax = maxX, let ix = minX, let ay = maxY, let iy = minY else { return }
        let env = AGSEnvelope(xmin: ix, ymin: iy, xmax: ax, ymax: ay, spatialReference: JTMapView.shareInstance.spatialReference)
        JTMapView.shareInstance.zoom(to: env, animated: true)
    }
}
extension SearchMapViewController {
    
    private func setupUI() {
        setupMapView()
        setupJTTransparentView()
        setupSearchPointResultView()
        setupSearchNameResultView()
        setupSearchContentTableView()
        setupSearchNameResultViewOpenView()
        setupCloseButton()
        setupJTSearchBar()
        setupProgressView()
    }
    private func setupMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: content.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            ])
    }
    private func setupJTTransparentView() {
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(transparentView)
        NSLayoutConstraint.activate([
            transparentView.topAnchor.constraint(equalTo: content.topAnchor),
            transparentView.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            transparentView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            transparentView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            ])
    }
    private func setupSearchPointResultView() {
        searchPointResultView.translatesAutoresizingMaskIntoConstraints = false
        transparentView.addSubview(searchPointResultView)
        NSLayoutConstraint.activate([
            searchPointResultView.heightAnchor.constraint(equalToConstant: searchPointResultViewHeight),
            searchPointResultView.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor),
            searchPointResultView.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor),
            searchPointResultView.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor),
            ])
        searchPointResultView.isHidden = true
    }
    private func setupSearchNameResultView() {
        searchNameResultView.translatesAutoresizingMaskIntoConstraints = false
        transparentView.addSubview(searchNameResultView)
        NSLayoutConstraint.activate([
            searchNameResultView.topAnchor.constraint(equalTo: transparentView.topAnchor),
            searchNameResultView.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor),
            searchNameResultView.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor),
            searchNameResultView.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor),
            ])
        SearchNameResultViewOffsetToHide(false, showOpenView: false)
    }
    private func setupSearchContentTableView() {
        searchContentTableView.translatesAutoresizingMaskIntoConstraints = false
        searchContentTableView.jtDelegate = self
        searchNameResultView.addSubview(searchContentTableView)
        NSLayoutConstraint.activate([
            searchContentTableView.topAnchor.constraint(equalTo: searchNameResultView.topAnchor),
            searchContentTableView.bottomAnchor.constraint(equalTo: searchNameResultView.bottomAnchor),
            searchContentTableView.leadingAnchor.constraint(equalTo: searchNameResultView.leadingAnchor),
            searchContentTableView.trailingAnchor.constraint(equalTo: searchNameResultView.trailingAnchor),
            ])
    }
    private func setupSearchNameResultViewOpenView() {
        searchNameResultViewOpenView.translatesAutoresizingMaskIntoConstraints = false
        searchNameResultViewOpenView.backgroundColor = .white
        transparentView.addSubview(searchNameResultViewOpenView)
        NSLayoutConstraint.activate([
            searchNameResultViewOpenView.heightAnchor.constraint(equalToConstant: searchNameResultViewOpenViewHeight),
            searchNameResultViewOpenView.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor),
            searchNameResultViewOpenView.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor),
            searchNameResultViewOpenView.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor),
            ])
        searchNameResultViewOpenView.isHidden = true
        searchNameResultViewOpenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchNameResultViewOpenViewTaped)))
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(r: 80, g: 80, b: 80)
        label.text = LocalizableStrings.clickToShowResultList
        label.translatesAutoresizingMaskIntoConstraints = false
        searchNameResultViewOpenView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: searchNameResultViewOpenView.topAnchor),
            label.bottomAnchor.constraint(equalTo: searchNameResultViewOpenView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: searchNameResultViewOpenView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: searchNameResultViewOpenView.trailingAnchor),
            ])
    }
    private func setupSearchNameResultViewPanView() {
        let view = UIView()
        view.accessibilityIdentifier = "qwewqewq"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        searchNameResultView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: searchNameResultView.topAnchor),
            view.bottomAnchor.constraint(equalTo: searchNameResultView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: searchNameResultView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: searchNameResultView.trailingAnchor),
            ])
        searchNameResultView.bringSubview(toFront: view)
        view.gestureRecognizers?.removeAll()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(searchNameResultViewPaned)))
        let t = UITapGestureRecognizer(target: self, action: #selector(searchNameResultViewTaped))
        t.numberOfTapsRequired = 1
        t.numberOfTouchesRequired = 1
        view.addGestureRecognizer(t)
    }
    private func setupSearchContentTableViewPan() {
        searchContentTableViewPan = UIPanGestureRecognizer(target: self, action: #selector(searchContentTableViewPaned))
        searchContentTableViewPan?.delegate = self
        guard let x = searchContentTableViewPan else { return }
        searchContentTableView.addGestureRecognizer(x)
    }
    private func setupCloseButton() {
        let btnAspectRatio: CGFloat = 1.2
        let width = navigationHeight * btnAspectRatio
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.backgroundColor = .white
        closeButton.setImage(Assets.close, for: .normal)
        navigationContent.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: navigationContent.topAnchor),
            closeButton.bottomAnchor.constraint(equalTo: navigationContent.bottomAnchor),
            closeButton.trailingAnchor.constraint(equalTo: navigationContent.trailingAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: width),
            ])
        closeButton.addTarget(self, action: #selector(closeTouchUpInside), for: .touchUpInside)
    }
    private func setupJTSearchBar() {
        jtSearchBar.translatesAutoresizingMaskIntoConstraints = false
        if let x = getTextField(inView: jtSearchBar) { x.clearButtonMode = .never }
        navigationContent.addSubview(jtSearchBar)
        NSLayoutConstraint.activate([
            jtSearchBar.topAnchor.constraint(equalTo: navigationContent.topAnchor),
            jtSearchBar.bottomAnchor.constraint(equalTo: navigationContent.bottomAnchor),
            jtSearchBar.leadingAnchor.constraint(equalTo: navigationContent.leadingAnchor),
            jtSearchBar.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor),
            ])
        jtSearchBar.delegate = self
    }
    private func setupProgressView() {
        let btnAspectRatio: CGFloat = 1
        let width = navigationHeight * btnAspectRatio
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.isUserInteractionEnabled = false
        jtSearchBar.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: jtSearchBar.topAnchor),
            progressView.bottomAnchor.constraint(equalTo: jtSearchBar.bottomAnchor),
            progressView.trailingAnchor.constraint(equalTo: jtSearchBar.trailingAnchor),
            progressView.widthAnchor.constraint(equalToConstant: width),
            ])
    }
    private func setupActivityIndicatorView() -> UIActivityIndicatorView {
        let a = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        a.translatesAutoresizingMaskIntoConstraints = false
        progressView.addSubview(a)
        NSLayoutConstraint.activate([
            a.topAnchor.constraint(equalTo: progressView.topAnchor),
            a.bottomAnchor.constraint(equalTo: progressView.bottomAnchor),
            a.leadingAnchor.constraint(equalTo: progressView.leadingAnchor),
            a.trailingAnchor.constraint(equalTo: progressView.trailingAnchor),
            ])
        a.startAnimating()
        return a
    }
}
extension SearchMapViewController: JTSearchContentTableViewDelegate {
    func didSelectedContent(vm: SearchContentTableViewCellVM) {
        position = vm.data
        if !showPoint() { return }
        mode = Mode.point
        setupPoint()
        if let x = searchContentTableViewPan { searchContentTableView.removeGestureRecognizer(x) }
        optionalDelegate = self
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset
        if offset.y < 0 { offset = .zero }
    }
}
extension SearchMapViewController {
    enum Mode {
        case point
        case text
    }
}
extension SearchMapViewController: JTNavigationViewControllerOptionalDelegate {
    func backTouchUpInsideRecognizeJTNavigation() -> Bool {
        if !showName() { return true }
        jtSearchBar.text = text
        optionalDelegate = nil
        mode = Mode.text
        SearchNameResultViewOffsetToHideHalf()
        showNameSymbol()
        return false
    }
}
extension SearchMapViewController: JTNavigationViewControllerDelegate {
    func backTouchUpInsideBegin() {
        JTMapView.shareInstance.removeSymbolLayer()
    }
}
extension SearchMapViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
extension SearchMapViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let s = SearchViewController()
        s.searchDelegate = self
        navigationController?.pushViewController(s, animated: false)
        return false
    }
}
extension SearchMapViewController {
    private func getTextField(inView: UIView) -> UITextField? {
        for v in inView.subviews {
            if v.isKind(of: UITextField.self) {
                return v as? UITextField
            }
            if v.subviews.count > 0 {
                let x = getTextField(inView: v)
                if x != nil { return x }
            }
        }
        return nil
    }
}
extension SearchMapViewController: SearchViewControllerDelegate {
    func popAfterSearchPosition(position: Object_Attribute) -> Bool {
        hideAll()
        initPoint(position: position)
        setupModeView()
        return true
    }
    
    func popAfterSearchText(name: String) -> Bool {
        hideAll()
        initText(text: name)
        setupModeView()
        return true
    }
}
extension SearchMapViewController {
    @objc private func closeTouchUpInside() {
        JTMapView.shareInstance.removeSymbolLayer()
        navigationController?.dismiss(animated: false, completion: nil)
    }
    @objc private func searchContentTableViewPaned(pan: UIPanGestureRecognizer) {
        let y = pan.translation(in: pan.view).y
        print(y)
        if y >= 0 && searchContentTableView.contentOffset.y <= 0 {
            searchContentTableView.isScrollEnabled = false
            searchNameResultView.transform = CGAffineTransform(translationX: 0, y: y)
        }
        if pan.state == .ended {
            searchContentTableView.isScrollEnabled = true
            let ty = searchNameResultView.transform.ty
            pan.view?.removeGestureRecognizer(pan)
            if let gcs = pan.view?.gestureRecognizers {
                for gc in gcs {
                    if gc == pan {
                        pan.view?.removeGestureRecognizer(gc)
                    }
                }
            }
            if ty > halfTransformY {
                SearchNameResultViewOffsetToHide(true, showOpenView: true)
            } else if ty > autoFinishTransformYHeight {
                SearchNameResultViewOffsetToHideHalf()
            } else {
                SearchNameResultViewNotOffset(false)
            }
        }
    }
    @objc private func searchNameResultViewOpenViewTaped() {
        searchNameResultViewOpenView.isHidden = true
        searchNameResultView.isHidden = false
        SearchNameResultViewOffsetToHideHalf()
    }
    @objc private func searchNameResultViewPaned(pan: UIPanGestureRecognizer) {
        let ty = pan.translation(in: pan.view).y
        let y = halfTransformY + ty
        print("-----\(y)")
        if y >= 0 { searchNameResultView.transform = CGAffineTransform(translationX: 0, y: y) }
        if pan.state == .ended {
            let v = pan.view
            v?.gestureRecognizers?.removeAll()
            v?.removeGestureRecognizer(pan)
            v?.removeFromSuperview()
            if ty > autoFinishTransformYHeight {
                SearchNameResultViewOffsetToHide()
            } else if ty < -autoFinishTransformYHeight {
                SearchNameResultViewNotOffset()
            } else {
                SearchNameResultViewOffsetToHideHalf(true, timeInterval: 0.1)
            }
        }
    }
    @objc private func searchNameResultViewTaped(tap: UITapGestureRecognizer) {
        let loca = tap.location(ofTouch: 0, in: tap.view)
        let indexPath = searchContentTableView.indexPathForRow(at: loca)
        guard let ip = indexPath else { return }
        searchContentTableView.tableView(searchContentTableView, didSelectRowAt: ip)
        let v = tap.view
        v?.gestureRecognizers?.removeAll()
        v?.removeFromSuperview()
    }

    private func SearchNameResultViewOffsetToHide(_ withAnimate: Bool = true, showOpenView: Bool = true) {
        if withAnimate {
            UIView.animate(withDuration: 0.2, animations: {
                [weak self] in
                guard let s = self else { return }
                s.searchNameResultView.transform = CGAffineTransform(translationX: 0, y: s.searchNameResultView.frame.height - s.navigationHeight)
            }) {
                [weak self]
                finish in
                guard finish else { return }
                self?.searchNameResultView.isHidden = true
                if showOpenView { self?.searchNameResultViewOpenView.isHidden = false }
            }
        } else {
            searchNameResultView.transform = CGAffineTransform(translationX: 0, y: searchNameResultView.frame.height - navigationHeight)
            searchNameResultView.isHidden = true
            if showOpenView { searchNameResultViewOpenView.isHidden = false }
        }
    }
    private func SearchNameResultViewOffsetToHideHalf(_ withAnimate: Bool = true, timeInterval: TimeInterval = 0.2) {
        searchNameResultView.isHidden = false
        if withAnimate {
            UIView.animate(withDuration: timeInterval, animations: {
                [weak self] in
                guard let s = self else { return }
                s.searchNameResultView.transform = CGAffineTransform(translationX: 0, y: (s.searchNameResultView.frame.height - s.navigationHeight) / 2)
            }) {
                [weak self]
                finish in
                guard finish else { return }
                self?.halfTransformY = (self?.searchNameResultView.transform.ty)!
                self?.setupSearchNameResultViewPanView()
            }
        } else {
            searchNameResultView.transform = CGAffineTransform(translationX: 0, y: (searchNameResultView.frame.height - navigationHeight) / 2)
            halfTransformY = searchNameResultView.transform.ty
            setupSearchNameResultViewPanView()
        }
    }
    private func SearchNameResultViewNotOffset(_ withAnimate: Bool = true) {
        searchNameResultView.isHidden = false
        if withAnimate {
            UIView.animate(withDuration: 0.2, animations: {
                [weak self] in
                guard let s = self else { return }
                s.searchNameResultView.transform = CGAffineTransform(translationX: 0, y: 0)
            }) {
                [weak self]
                finish in
                guard finish, let s = self else { return }
                s.setupSearchContentTableViewPan()
            }
        } else {
            searchNameResultView.transform = CGAffineTransform(translationX: 0, y: 0)
            setupSearchContentTableViewPan()
        }
    }
}
