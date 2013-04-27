class Influence

#Time consideration: Saved in UTC, 00:01 Mad time = 21:01 UTC
#Run rake at 23:30 UTC Sunday => 01:30 MAD monday


#On sundays:
#1. Create new weekly (blank)
#2. Calculate influence for end of week activity, update end-of week record (created 1weekago)
#3. End of week influence to user profile.

	def self.basicFacebookData(uid,graph)
	 	user=User.find_by(user_uid: uid)
	  profile = graph.get_object("me")
	  user.email = profile["email"]
	  user.name = profile["name"]
    location = profile["location"]
    if location.nil?
      user.location_name = ""
      user.location_id = ""
    else
      user.location_name = location["name"]
	    user.location_id = location["id"]
    end

    if profile["birthday"].nil?
      user.DOB = ""
    else
      user.DOB = Date.strptime(profile["birthday"], '%m/%d/%Y')
    end
    
	  #get_friends
	  friends = Array.new
	  graph.get_connections("me","friends",:fields =>"id").each do |x|
	    friends << x["id"]
	  end

	  user.fb_friends = friends
	  user.friend_count = friends.count
	  user.save

	end

	def self.update_info_recal_influence(user_id)
    user = User.find_by(user_uid: user_id)
    graph = Koala::Facebook::API.new(user.fb_token)

##################PROPIETARY ALGORITHM*******************

    #Push notificiation for new influence!
  end


  def self.******(graph)
 ####################
  end

  def self.getWeeklyTags(graph)
    since = (Time.now - 7.days).to_i 
    feed = graph.fql_query("SELECT post_id, actor_id, target_id, message FROM stream WHERE filter_key = 'others' AND source_id = me() AND created_time >" + since.to_s)
    return feed.count
  end

  def self.getShares(user_id)
    user=User.find_by(user_uid: uid)
    time = DateTime.now.utc - 1.week
    shares = user.visits.where(:created_at.gte => time).where(:shared => true).count
    #Weekly.ascending(:created_at).last => newest!
    return shares
  end

  def self.getcuponshares(used_id)
    user=User.find_by(user_uid: uid)
    return user.weeklies.ascending(:created_at).last.shared_cupons
  end




end
