module MicropostsHelper
  def display_likes(micropost)
    votes = micropost.votes_for.up.by_type("User")
    return list_likers(votes) if votes.count <= 8
    count_likers(micropost)
  end
  
  def count_likers(likes)
    return "#{likes} likes"
  end
  
  def like_button(micropost)
    if current_user.present? && current_user.voted_up_for?(micropost)
      return link_to '', unlike_micropost_path(micropost), remote: true,
                                    id: "like_#{micropost.id}",
                                    class: "like glyphicon glyphicon-heart"
    else
      return link_to '', like_micropost_path(micropost), remote: true,
                                    id: "like_#{micropost.id}",
                                    class: "like glyphicon glyphicon-heart-empty"
    end
  end
  
  def list_likers(votes)
    user_names = []
    
    unless votes.blank?
      votes.voters.each do |voter|
        user_names.push(link_to voter.user_name,
                                profile_path(voter.user_name),
                                class: 'user-name')
      end
      user_names.to_sentence.html_safe + like_plural(votes)
    end
  end

  private

  def like_plural(likers)
    return ' like this' if likers.count > 1
    ' likes this'
  end
end
