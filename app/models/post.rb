class Post < ActiveRecord::Base
	attr_accessible :content, :title
	belongs_to :user
	
	validates :content, presence: true
	validates :title, presence: true, length: { maximum: 160 }
  	validates :user_id, presence: true
  	
  	def self.search(search)
  		if search
    		find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  		else
    		find(:all)
  		end
	end

  	default_scope order: 'posts.created_at DESC'
end
