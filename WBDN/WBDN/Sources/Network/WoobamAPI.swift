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
    /// 응답 타입: BaseResponse<SignUpDto>
    case signUp(dto: SignUpDto)

    /// signIn:
    /// 응답 타입: BaseResponse<SignInDto>
    case signIn(dto: SignInDto)

    /// getPosts:
    /// 응답 타입: BaseResponse<PostListResDto>
    case getPosts

    /// createPost:
    /// 응답 타입: BaseResponse<CreatePostDto>
    case createPost(dto: CreatePostDto)

    /// findPostAll:
    /// 응답 타입: BaseResponse<PostListResDto>
    case findPostAll(member: Member)

    /// saveLike:
    /// 응답 타입: BaseResponse<PostLikeResDto>
    case saveLike(postId: Int, member: Member)

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
    case findPostDetail(postId: Int, member: Member)

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
        case .findPostAll:
            return "/api/posts"
        case .saveLike(let postId, _):
            return "/api/posts/\(postId)/likes"
        case .getComments(let postId):
            return "/api/posts/\(postId)/comments"
        case .postComment(let postId, _):
            return "/api/posts/\(postId)/comments"
        case .getReplies(let commentId):
            return "/api/comments/\(commentId)/replies"
        case .postReply(let commentId, _):
            return "/api/comments/\(commentId)/replies"
        case .findPostDetail(let postId, _):
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
        case .findPostAll, .saveLike, .getComments, .getReplies, .findPostDetail, .getPosts:
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
        case let .createPost(dto):
            var multipartData = [MultipartFormData]()
            multipartData.append(MultipartFormData(provider: .data(dto.contents.data(using: .utf8)!), name: "contents"))
            multipartData.append(MultipartFormData(provider: .data(dto.photo), name: "photo", fileName: "photo.jpg", mimeType: "image/jpeg"))
            // 기타 필요한 멀티파트 데이터 추가
            return .uploadMultipart(multipartData)
        case let .findPostAll(member):
            return .requestParameters(parameters: ["arg1": member], encoding: URLEncoding.queryString)
        case let .saveLike(_, member):
            return .requestParameters(parameters: ["arg1": member], encoding: URLEncoding.queryString)
        case let .findPostDetail(_, member):
            return .requestParameters(parameters: ["arg1": member], encoding: URLEncoding.queryString)
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
