import Foundation
import ObjectMapper
//MARK: PostModel
public struct PostModel: Codable {
  private var id: Int
  private var userId: Int
  private var title: String
  private var body: String
  init(id: Int, userId: Int, title: String, body: String) {
     self.id = id
     self.userId = userId
     self.title = title
     self.body = body
  }
  func getId() -> Int {
    return self.id
  }
  func getUserId() -> Int {
    return self.userId
  }
  func getTitle() -> String {
    return self.title
  }
  func getBody() -> String {
    return self.body
  }
}
