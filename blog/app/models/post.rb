class Post < ActiveRecord::Base

#For Pagination
  cattr_reader :per_page
  @@per_page = 5

      belongs_to :user
      has_many :comments

    # Adding some validation for the Post field
    validates_presence_of(:name, :title, :content)
    validates_length_of(:title, :minimum => 5)
    
end
