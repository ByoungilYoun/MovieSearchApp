//
//  MovieDetailWebView.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/17.
//

import UIKit
import WebKit

class MovieDetailWebView : UIView {
  
  //MARK: - Properties
  
  var webView = WKWebView()
  
  //MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func layout() {
    self.addSubview(webView)
    
    webView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func laodWebUrl(url : String) {
    if let url = URL(string: url) {
      let urlRequest = URLRequest(url: url)
      webView.load(urlRequest)
    }
  }
}
