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
    private let pointResultView = PointResultView.loadFromNib()
    private let pointResultViewHeight: CGFloat = 120
    private let contentResultView = UIView()
    private let searchContentTableView = SearchContentTableView()
    private let searchContentResultViewOpenView = UIView()
    private let searchContentResultViewOpenViewHeight: CGFloat = 40
    private let autoFinishTransformYHeight: CGFloat = 80
    private let closeButton = UIButton()
    private let jtSearchBar = JTSearchBar()
    private let progressView = UIView()
    
    private var searchContentTableViewPan: UIPanGestureRecognizer?
    private var halfTransformY: CGFloat = 0
    private var mode: Mode
    private var previousMode: Mode? = nil
    private var text: String?
    private var position: Object_Attribute?
    private var type: Tianditu_NameSearchType?
    private var withEnvelope: Bool = false
    
    init(position: Object_Attribute) {
        mode = .point
        self.position = position
        super.init(nibName: nil, bundle: nil)
        delegate = self
        setupUI()
    }
    init(text: String) {
        mode = .text
        self.text = text
        super.init(nibName: nil, bundle: nil)
        delegate = self
        setupUI()
    }
    init(type: Tianditu_NameSearchType, withEnvelope: Bool = false) {
        mode = .type
        self.type = type
        self.withEnvelope = withEnvelope
        super.init(nibName: nil, bundle: nil)
        delegate = self
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        mode = .text
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
        jtMapView.locationDisplay.autoPanMode = .off
        jtMapView.setRotationAngle(0, animated: true)
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
        mode = .point
        JTMapView.shareInstance.removeSymbolLayer()
        self.position = position
    }
    private func initText(text: String) {
        optionalDelegate = nil
        mode = .text
        JTMapView.shareInstance.removeSymbolLayer()
        self.text = text
    }
    private func initType(type: Tianditu_NameSearchType, withEnvelope: Bool = false) {
        optionalDelegate = nil
        mode = .type
        JTMapView.shareInstance.removeSymbolLayer()
        self.type = type
        self.withEnvelope = withEnvelope
    }
    private func setupModeView() {
        if mode == .point {
            if !showPoint() { return }
            setupPoint()
        } else if mode == .text {
            if !showName() { return }
            setupName()
        } else if mode == .type {
            if !showType() { return }
            setupType()
        }
    }
    private func hideAll() {
        pointResultView.isHidden = true
        SearchNameResultViewOffsetToHide(false, showOpenView: false)
        searchContentResultViewOpenView.isHidden = true
    }
    private func showPoint() -> Bool {
        guard let p = position, let _ = p.name else { return false }
        pointResultView.isHidden = false
        SearchNameResultViewOffsetToHide(false, showOpenView: false)
        return true
    }
    private func showName() -> Bool {
        if text == nil, let t = text, (t == "" || t.trimmingCharacters(in: .whitespaces) == "") { return false }
        pointResultView.isHidden = true
        contentResultView.isHidden = false
        searchContentResultViewOpenView.isHidden = true
        return true
    }
    private func showType() -> Bool {
        if type == nil || type == .unknown { return false }
        pointResultView.isHidden = true
        contentResultView.isHidden = false
        searchContentResultViewOpenView.isHidden = true
        return true
    }
    private func setupPoint() {
        guard let p = position, let n = p.name else { return }
        let region = p.region ?? ""
        let county = p.county ?? ""
        let address = p.address ?? ""
        let detail = region + " " + county + " " + address
        pointResultView.set(t: n, d: detail)
        jtSearchBar.text = n
        guard let x = p.x, let y = p.y else { return }
        JTMapView.shareInstance.removeSymbolLayer()
        JTMapView.shareInstance.addSymbolLayerLocationPoints(points: [(x, y)])
        JTMapView.shareInstance.zoom(toScale: 30000, withCenter: AGSPoint(location: CLLocation(latitude: y, longitude: x)), animated: true)
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
            guard s.searchContentTableView.dataNumber > 0 else {
                s.hideAll()
                return
            }
            s.searchContentResultViewOpenView.isHidden = true
            s.contentResultView.isHidden = false
            s.SearchNameResultViewOffsetToHideHalf()
            s.showNameSymbol()
        }
    }
    private func setupType() {
        guard let t = type else { return }
        jtSearchBar.text = "\"" + t.rawValue + "\""
        let a = setupActivityIndicatorView()
        hideAll()
        var e: Object_SearchEnvelope? = nil
        if withEnvelope {
            if let je = JTMapView.shareInstance.visibleAreaEnvelope {
                e = Object_SearchEnvelope(xmin: je.xmin, ymin: je.ymin, xmax: je.xmax, ymax: je.ymax)
            }
        }
        searchContentTableView.typeSearch(type: t, envelope: e) {
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
            guard s.searchContentTableView.dataNumber > 0 else {
                s.hideAll()
                return
            }
            s.searchContentResultViewOpenView.isHidden = true
            s.contentResultView.isHidden = false
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
        pointResultView.translatesAutoresizingMaskIntoConstraints = false
        transparentView.addSubview(pointResultView)
        NSLayoutConstraint.activate([
            pointResultView.heightAnchor.constraint(equalToConstant: pointResultViewHeight),
            pointResultView.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor),
            pointResultView.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor),
            pointResultView.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor),
            ])
        pointResultView.isHidden = true
    }
    private func setupSearchNameResultView() {
        contentResultView.translatesAutoresizingMaskIntoConstraints = false
        transparentView.addSubview(contentResultView)
        NSLayoutConstraint.activate([
            contentResultView.topAnchor.constraint(equalTo: transparentView.topAnchor),
            contentResultView.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor),
            contentResultView.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor),
            contentResultView.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor),
            ])
        SearchNameResultViewOffsetToHide(false, showOpenView: false)
    }
    private func setupSearchContentTableView() {
        searchContentTableView.translatesAutoresizingMaskIntoConstraints = false
        searchContentTableView.jtDelegate = self
        contentResultView.addSubview(searchContentTableView)
        NSLayoutConstraint.activate([
            searchContentTableView.topAnchor.constraint(equalTo: contentResultView.topAnchor),
            searchContentTableView.bottomAnchor.constraint(equalTo: contentResultView.bottomAnchor),
            searchContentTableView.leadingAnchor.constraint(equalTo: contentResultView.leadingAnchor),
            searchContentTableView.trailingAnchor.constraint(equalTo: contentResultView.trailingAnchor),
            ])
    }
    private func setupSearchNameResultViewOpenView() {
        searchContentResultViewOpenView.translatesAutoresizingMaskIntoConstraints = false
        searchContentResultViewOpenView.backgroundColor = .white
        transparentView.addSubview(searchContentResultViewOpenView)
        NSLayoutConstraint.activate([
            searchContentResultViewOpenView.heightAnchor.constraint(equalToConstant: searchContentResultViewOpenViewHeight),
            searchContentResultViewOpenView.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor),
            searchContentResultViewOpenView.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor),
            searchContentResultViewOpenView.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor),
            ])
        searchContentResultViewOpenView.isHidden = true
        searchContentResultViewOpenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchNameResultViewOpenViewTaped)))
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(r: 80, g: 80, b: 80)
        label.text = LocalizableStrings.clickToShowResultList
        label.translatesAutoresizingMaskIntoConstraints = false
        searchContentResultViewOpenView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: searchContentResultViewOpenView.topAnchor),
            label.bottomAnchor.constraint(equalTo: searchContentResultViewOpenView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: searchContentResultViewOpenView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: searchContentResultViewOpenView.trailingAnchor),
            ])
    }
    private func setupSearchNameResultViewPanView() {
        let view = UIView()
        view.accessibilityIdentifier = "qwewqewq"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        contentResultView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentResultView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentResultView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: contentResultView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentResultView.trailingAnchor),
            ])
        contentResultView.bringSubview(toFront: view)
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
        previousMode = mode
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
    private enum Mode {
        case point
        case text
        case type
    }
}
extension SearchMapViewController: JTNavigationViewControllerOptionalDelegate {
    func backTouchUpInsideRecognizeJTNavigation() -> Bool {
        if previousMode == .text {
            if !showName() { return true }
            jtSearchBar.text = text
            optionalDelegate = nil
            mode = .text
            SearchNameResultViewOffsetToHideHalf()
            showNameSymbol()
        } else if previousMode == .type {
            if !showType() { return true }
            jtSearchBar.text = "\"" + ((type != nil) ? (type?.rawValue)! : "") + "\""
            optionalDelegate = nil
            mode = .type
            SearchNameResultViewOffsetToHideHalf()
            showNameSymbol()
        } else { return true }
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
        if y >= 0 && searchContentTableView.contentOffset.y <= 0 {
            searchContentTableView.isScrollEnabled = false
            contentResultView.transform = CGAffineTransform(translationX: 0, y: y)
        }
        if pan.state == .ended {
            searchContentTableView.isScrollEnabled = true
            let ty = contentResultView.transform.ty
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
        searchContentResultViewOpenView.isHidden = true
        contentResultView.isHidden = false
        SearchNameResultViewOffsetToHideHalf()
    }
    @objc private func searchNameResultViewPaned(pan: UIPanGestureRecognizer) {
        let ty = pan.translation(in: pan.view).y
        let y = halfTransformY + ty
        if y >= 0 { contentResultView.transform = CGAffineTransform(translationX: 0, y: y) }
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
                s.contentResultView.transform = CGAffineTransform(translationX: 0, y: s.contentResultView.frame.height - s.navigationHeight)
            }) {
                [weak self]
                finish in
                guard finish else { return }
                self?.contentResultView.isHidden = true
                if showOpenView { self?.searchContentResultViewOpenView.isHidden = false }
            }
        } else {
            contentResultView.transform = CGAffineTransform(translationX: 0, y: contentResultView.frame.height - navigationHeight)
            contentResultView.isHidden = true
            if showOpenView { searchContentResultViewOpenView.isHidden = false }
        }
    }
    private func SearchNameResultViewOffsetToHideHalf(_ withAnimate: Bool = true, timeInterval: TimeInterval = 0.2) {
        contentResultView.isHidden = false
        if withAnimate {
            UIView.animate(withDuration: timeInterval, animations: {
                [weak self] in
                guard let s = self else { return }
                s.contentResultView.transform = CGAffineTransform(translationX: 0, y: (s.contentResultView.frame.height - s.navigationHeight) / 2)
            }) {
                [weak self]
                finish in
                guard finish else { return }
                self?.halfTransformY = (self?.contentResultView.transform.ty)!
                self?.setupSearchNameResultViewPanView()
            }
        } else {
            contentResultView.transform = CGAffineTransform(translationX: 0, y: (contentResultView.frame.height - navigationHeight) / 2)
            halfTransformY = contentResultView.transform.ty
            setupSearchNameResultViewPanView()
        }
    }
    private func SearchNameResultViewNotOffset(_ withAnimate: Bool = true) {
        contentResultView.isHidden = false
        if withAnimate {
            UIView.animate(withDuration: 0.2, animations: {
                [weak self] in
                guard let s = self else { return }
                s.contentResultView.transform = CGAffineTransform(translationX: 0, y: 0)
            }) {
                [weak self]
                finish in
                guard finish, let s = self else { return }
                s.setupSearchContentTableViewPan()
            }
        } else {
            contentResultView.transform = CGAffineTransform(translationX: 0, y: 0)
            setupSearchContentTableViewPan()
        }
    }
}
