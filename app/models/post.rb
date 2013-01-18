class Post < ActiveRecord::Base
	#acts_as_solr :fields => [:post, :content, :title]
  attr_accessible :content, :title
	belongs_to :user
	
	validates :content, presence: true
	validates :title, presence: true, length: { maximum: 160 }
  validates :user_id, presence: true
  	
  	#def self.search(search)
  	#	 Post.find_by_solr(search)
	 # end

  	default_scope order: 'posts.created_at DESC'
end
