require 'rails_helper'

describe Comment, type: :model do
	
	context "when a comment is valid" do 
		before do
			@comment = FactoryGirl.build(:comment)
		end
		it "should post the comment" do
			expect(@comment).to be_valid
		end
	end
	
	context "when there is no rating given" do
		before do
			@comment = FactoryGirl.build(:comment, rating: nil)
		end
		it "should not validate the comment" do
			expect(@comment).not_to be_valid
		end
	end

	context "when there is no body given" do
		before do
			@comment = FactoryGirl.build(:comment, body: nil)
		end
		it "should not validate the comment" do
			expect(@comment).not_to be_valid
		end
	end

	# THIS TEST IS NOT NECCESSARY AS COMMENT FIELD DOES NOT DISPLAY WHEN USER NOT SIGNED IN
	context "when there is no user present" do
		before do
			@comment = FactoryGirl.build(:comment, user: nil)
		end
		it "should not validate the comment" do
			expect(@comment).not_to be_valid
		end
	end		
end