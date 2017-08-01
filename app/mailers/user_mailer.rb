class UserMailer < ApplicationMailer
	default from: "havingcows.herokuapp.com"

	def contact_form(email, name, message)
		@message = message
			mail(:from => email,
						:to => "jacques.leroux3@gmail.com",
						:subject => "A message from #{name}")
	end
end
