//
//  VideoMetadataView.swift
//  Pivo
//
//  Created by Til Blechschmidt on 27.12.18.
//  Copyright © 2018 Til Blechschmidt. All rights reserved.
//

import UIKit
import DownloadButton

class VideoMetadataView: UIView {
    let channelIconSize: CGFloat = Constants.smallChannelIconSize

    private let metaScrollView = UIScrollView()
    private let metaView = UIView()

    // Video detail
    private let detailView = UIView()
    let videoTitle = UILabel()
    let viewCount = UILabel()

    // Video detail buttons
    let detailButtonView = UIView()
    var downloadButtonView: UIView! {
        didSet {
            downloadButtonView.translatesAutoresizingMaskIntoConstraints = false
            detailButtonView.addSubview(downloadButtonView)
            detailButtonView.addConstraints([
                downloadButtonView.rightAnchor.constraint(equalTo: detailButtonView.rightAnchor),
                downloadButtonView.centerYAnchor.constraint(equalTo: detailButtonView.centerYAnchor)
            ])
        }
    }

    // Channel
    private let channelView = UIView()
    var channelThumbnail = UIImageView()
    let channelTitle = UILabel()
    let channelSubscriberCount = UILabel()

    // Description
    private let descriptionView = UIView()
    let videoDescriptionView = UITextView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = Constants.backgroundColor // TODO This had .darker attached to it

        setupMetaScrollView()

        setupVideoDetails()
        setupChannelDetails()
        setupVideoDescription()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupMetaScrollView() {
        let metaScrollViewContainer = UIView()
        addSubview(metaScrollViewContainer)
        metaScrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        metaScrollViewContainer.clipsToBounds = true
        addConstraints([
            metaScrollViewContainer.topAnchor.constraint(equalTo: topAnchor),
            metaScrollViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            metaScrollViewContainer.widthAnchor.constraint(equalTo: widthAnchor)
        ])

        metaScrollViewContainer.addSubview(metaScrollView)

        metaScrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        metaScrollView.addSubview(metaView)
        metaView.translatesAutoresizingMaskIntoConstraints = false
        metaScrollView.addConstraints([
            metaView.topAnchor.constraint(equalTo: metaScrollView.topAnchor),
            metaView.bottomAnchor.constraint(equalTo: metaScrollView.bottomAnchor)
        ])
        metaScrollViewContainer.addConstraints([
            metaView.leadingAnchor.constraint(equalTo: metaScrollViewContainer.leadingAnchor),
            metaView.trailingAnchor.constraint(equalTo: metaScrollViewContainer.trailingAnchor)
        ])
    }

    func setupVideoDetails() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        metaView.addSubview(detailView)
        metaView.addConstraints([
            detailView.topAnchor.constraint(equalTo: metaView.topAnchor),
            detailView.leftAnchor.constraint(equalTo: metaView.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: metaView.rightAnchor)
        ])

        videoTitle.font = videoTitle.font.withSize(13)
        videoTitle.textColor = UIColor.white
        videoTitle.lineBreakMode = .byTruncatingTail
        detailView.addSubview(videoTitle)
        videoTitle.translatesAutoresizingMaskIntoConstraints = false
        detailView.addConstraints([
            videoTitle.topAnchor.constraint(equalTo: detailView.topAnchor, constant: Constants.uiPadding),
            videoTitle.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: Constants.uiPadding)
        ])

        viewCount.font = viewCount.font.withSize(11)
        viewCount.textColor = UIColor.lightGray
        detailView.addSubview(viewCount)
        viewCount.translatesAutoresizingMaskIntoConstraints = false
        detailView.addConstraints([
            viewCount.topAnchor.constraint(equalTo: videoTitle.bottomAnchor, constant: Constants.uiPadding / 2),
            viewCount.leftAnchor.constraint(equalTo: videoTitle.leftAnchor),
            viewCount.rightAnchor.constraint(equalTo: videoTitle.rightAnchor),
            viewCount.bottomAnchor.constraint(equalTo: detailView.bottomAnchor, constant: -Constants.uiPadding),
        ])

        detailButtonView.translatesAutoresizingMaskIntoConstraints = false
        detailView.addSubview(detailButtonView)
        detailView.addConstraints([
            detailButtonView.topAnchor.constraint(equalTo: detailView.topAnchor, constant: Constants.uiPadding),
            detailButtonView.leftAnchor.constraint(equalTo: videoTitle.rightAnchor, constant: Constants.uiPadding),
            detailButtonView.rightAnchor.constraint(equalTo: detailView.rightAnchor, constant: -Constants.uiPadding),
            detailButtonView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor, constant: -Constants.uiPadding)
        ])
    }

    func setupChannelDetails() {
        channelView.translatesAutoresizingMaskIntoConstraints = false
        metaView.addSubview(channelView)
        metaView.addConstraints([
            channelView.topAnchor.constraint(equalTo: detailView.bottomAnchor),
            channelView.leftAnchor.constraint(equalTo: metaView.leftAnchor),
            channelView.rightAnchor.constraint(equalTo: metaView.rightAnchor),
        ])

        let topBorder = UIView()
        topBorder.backgroundColor = Constants.borderColor
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        channelView.addSubview(topBorder)
        channelView.addConstraints([
            topBorder.topAnchor.constraint(equalTo: channelView.topAnchor),
            topBorder.widthAnchor.constraint(equalTo: channelView.widthAnchor),
            topBorder.heightAnchor.constraint(equalToConstant: 1)
        ])

        let bottomBorder = UIView()
        bottomBorder.backgroundColor = Constants.borderColor
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        channelView.addSubview(bottomBorder)
        channelView.addConstraints([
            bottomBorder.bottomAnchor.constraint(equalTo: channelView.bottomAnchor),
            bottomBorder.widthAnchor.constraint(equalTo: channelView.widthAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1)
        ])

        channelThumbnail.backgroundColor = UIColor.lightGray
        channelThumbnail.layer.cornerRadius = channelIconSize / 2
        channelThumbnail.layer.masksToBounds = false
        channelThumbnail.clipsToBounds = true
        channelThumbnail.kf.indicatorType = .activity
        channelThumbnail.translatesAutoresizingMaskIntoConstraints = false
        channelView.addSubview(channelThumbnail)
        channelView.addConstraints([
            channelThumbnail.widthAnchor.constraint(equalToConstant: channelIconSize),
            channelThumbnail.heightAnchor.constraint(equalToConstant: channelIconSize),
            channelThumbnail.topAnchor.constraint(equalTo: channelView.topAnchor, constant: Constants.uiPadding),
            channelThumbnail.leftAnchor.constraint(equalTo: channelView.leftAnchor, constant: Constants.uiPadding),
            channelThumbnail.bottomAnchor.constraint(equalTo: channelView.bottomAnchor, constant: -Constants.uiPadding)
        ])

        let channelDetailLabelView = UIView()
        channelDetailLabelView.translatesAutoresizingMaskIntoConstraints = false
        channelView.addSubview(channelDetailLabelView)
        channelView.addConstraints([
            channelDetailLabelView.leftAnchor.constraint(equalTo: channelThumbnail.rightAnchor, constant: Constants.uiPadding),
            channelDetailLabelView.rightAnchor.constraint(equalTo: channelView.rightAnchor, constant: -Constants.uiPadding),
            channelDetailLabelView.centerYAnchor.constraint(equalTo: channelThumbnail.centerYAnchor)
        ])

        channelTitle.font = channelTitle.font.withSize(13)
        channelTitle.textColor = UIColor.white
        channelTitle.lineBreakMode = .byTruncatingTail
        channelTitle.translatesAutoresizingMaskIntoConstraints = false
        channelDetailLabelView.addSubview(channelTitle)
        channelDetailLabelView.addConstraints([
            channelTitle.leftAnchor.constraint(equalTo: channelDetailLabelView.leftAnchor),
            channelTitle.rightAnchor.constraint(equalTo: channelDetailLabelView.rightAnchor),
            channelTitle.topAnchor.constraint(equalTo: channelDetailLabelView.topAnchor)
        ])

        channelSubscriberCount.font = channelTitle.font.withSize(11)
        channelSubscriberCount.textColor = UIColor.lightGray
        channelSubscriberCount.lineBreakMode = .byTruncatingTail
        channelSubscriberCount.translatesAutoresizingMaskIntoConstraints = false
        channelDetailLabelView.addSubview(channelSubscriberCount)
        channelDetailLabelView.addConstraints([
            channelSubscriberCount.leftAnchor.constraint(equalTo: channelDetailLabelView.leftAnchor),
            channelSubscriberCount.rightAnchor.constraint(equalTo: channelDetailLabelView.rightAnchor),
            channelSubscriberCount.bottomAnchor.constraint(equalTo: channelDetailLabelView.bottomAnchor),
            channelSubscriberCount.topAnchor.constraint(equalTo: channelTitle.bottomAnchor, constant: Constants.uiPadding / 4)
        ])
    }

    func setupVideoDescription() {
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        metaView.addSubview(descriptionView)
        metaView.addConstraints([
            descriptionView.topAnchor.constraint(equalTo: channelView.bottomAnchor),
            descriptionView.leftAnchor.constraint(equalTo: metaView.leftAnchor),
            descriptionView.rightAnchor.constraint(equalTo: metaView.rightAnchor),
            descriptionView.bottomAnchor.constraint(equalTo: metaView.bottomAnchor)
        ])

        videoDescriptionView.font = videoDescriptionView.font?.withSize(12)
        videoDescriptionView.textColor = UIColor.lightGray
        videoDescriptionView.isEditable = false
        videoDescriptionView.dataDetectorTypes = .all
        videoDescriptionView.isScrollEnabled = false
        videoDescriptionView.backgroundColor = nil
        videoDescriptionView.delegate = self
        videoDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.addSubview(videoDescriptionView)
        descriptionView.addConstraints([
            videoDescriptionView.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: Constants.uiPadding),
            videoDescriptionView.leftAnchor.constraint(equalTo: descriptionView.leftAnchor, constant: Constants.uiPadding),
            videoDescriptionView.rightAnchor.constraint(equalTo: descriptionView.rightAnchor, constant: -Constants.uiPadding),
            videoDescriptionView.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -Constants.uiPadding)
        ])
    }
}

extension VideoMetadataView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if interaction == .invokeDefaultAction {

            let beginning = textView.beginningOfDocument
            guard let center = textView.position(from: beginning, offset: characterRange.location + characterRange.length / 2) else { return true }

            let rect = textView.caretRect(for: center)

            return !IncomingVideoReceiver.default.handle(url: URL, source: .rect(rect: rect, view: textView, permittedArrowDirections: .any))
        }
        return true
    }
}
