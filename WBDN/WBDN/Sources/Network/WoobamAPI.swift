//
//  WoobamAPI.swift
//  WBDN
//
//  Created by Mason Kim on 11/25/23.
//

import Moya
import Foundation

enum WoobamAPI {
    /// signUp:
    /// 응답 타입: BaseResponse<SignUpResponse>
    case signUp(dto: SignUpDto)

    /// signIn:
    /// 응답 타입: BaseResponse<SignInResponse>
    case signIn(dto: SignInDto)

    /// getPosts:
    /// 응답 타입: BaseResponse<PostListResDto>
    case getPosts

    /// createPost:
    /// 응답 타입: BaseResponse<CreatePostDto>
    case createPost(photo: Data, dto: CreatePostDto)

    /// saveLike:
    /// 응답 타입: BaseResponse<PostLikeResDto>
    case saveLike(postId: Int)

    /// getComments:
    /// 응답 타입: BaseResponse<GetCommentsDto>
    case getComments(postId: Int)

    /// postComment:
    /// 응답 타입: BaseResponse<SaveCommentDto>
    case postComment(postId: Int, dto: SaveCommentDto)

    /// getReplies:
    /// 응답 타입: BaseResponse<GetRepliesDto>
    case getReplies(commentId: Int)

    /// postReply:
    /// 응답 타입: BaseResponse<SaveReplyDto>
    case postReply(commentId: Int, dto: SaveReplyDto)

    /// findPostDetail:
    /// 응답 타입: BaseResponse<PostDetailResDto>
    case findPostDetail(postId: Int)

    /// deletePost, deleteReply, deleteComment:
    /// 응답 타입: BaseResponse<Void>
    case deletePost(postId: Int)

    /// deletePost, deleteReply, deleteComment:
    /// 응답 타입: BaseResponse<Void>
    case deleteReply(replyId: Int)
    
    /// deletePost, deleteReply, deleteComment:
    /// 응답 타입: BaseResponse<Void>
    case deleteComment(commentId: Int)
}

extension WoobamAPI: TargetType {
    var baseURL: URL { return URL(string: "http://10.10.141.126:8080")! }

    var path: String {
        switch self {
        case .signUp:
            return "/api/sign-up"
        case .signIn:
            return "/api/sign-in"
        case .createPost:
            return "/api/posts"
        case .getPosts:
            return "/api/posts"
        case .saveLike(let postId):
            return "/api/posts/\(postId)/likes"
        case .getComments(let postId):
            return "/api/posts/\(postId)/comments"
        case .postComment(let postId, _):
            return "/api/posts/\(postId)/comments"
        case .getReplies(let commentId):
            return "/api/comments/\(commentId)/replies"
        case .postReply(let commentId, _):
            return "/api/comments/\(commentId)/replies"
        case .findPostDetail(let postId):
            return "/api/posts/\(postId)"
        case .deletePost(let postId):
            return "/api/posts/\(postId)"
        case .deleteReply(let replyId):
            return "/api/replies/\(replyId)"
        case .deleteComment(let commentId):
            return "/api/comments/\(commentId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signUp, .signIn, .createPost, .postComment, .postReply:
            return .post
        case .saveLike, .getComments, .getReplies, .findPostDetail, .getPosts:
            return .get
        case .deletePost, .deleteReply, .deleteComment:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .signUp(dto):
            return .requestJSONEncodable(dto)

        case let .signIn(dto):
            return .requestJSONEncodable(dto)

        case .getPosts:
            return .requestPlain

        case let .createPost(photoData, dto):
            var multipartData = [MultipartFormData]()
            if let contentsData = try? JSONEncoder().encode(dto) {
                if let contentsJSONString = String(data: contentsData, encoding: .utf8) {
                    multipartData.append(
                        MultipartFormData(provider: .data(contentsJSONString.data(using: .utf8)!), name: "contents")
                    )
                }
            }
            multipartData.append(MultipartFormData(provider: .data(photoData), name: "photo"))
            return .uploadMultipart(multipartData)

        case .saveLike:
            return .requestPlain

        case .findPostDetail:
            return .requestPlain

        case .getComments:
            return .requestPlain

        case let .postComment(postId, dto):
            return .requestCompositeParameters(bodyParameters: ["postId": postId], bodyEncoding: JSONEncoding.default, urlParameters: ["dto": dto])

        case .getReplies:
            return .requestPlain

        case let .postReply(commentId, dto):
            return .requestCompositeParameters(bodyParameters: ["commentId": commentId], bodyEncoding: JSONEncoding.default, urlParameters: ["dto": dto])

        case .deletePost, .deleteReply, .deleteComment:
            return .requestPlain
        }

    }
    
    var headers: [String: String]? {
        switch self {
        case .createPost:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json"]
        }
    }

    var validationType: ValidationType {
        return .successCodes
    }
}
