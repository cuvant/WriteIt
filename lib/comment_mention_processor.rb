class CommentMentionProcessor < MentionSystem::MentionProcessor
  def extract_mentioner_content(post)
    return post.content
  end

  def find_mentionees_by_handles(*handles)
    User.where(username: handles)
  end
end
