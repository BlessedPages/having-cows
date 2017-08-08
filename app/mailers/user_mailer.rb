class UserMailer < ApplicationMailer
	default from: "jacques.leroux3@gmail.com"

	def contact_form(email, name, message)
		@message = message
			mail(:from => email,
						:to => "jacques.leroux3@gmail.com",
						:subject => "A message from #{name}")
	end

	def welcome(user)
		@appname = "The Having Cows Parade"
		mail(to: user.email,
			subject: "Welcome to #{@appname}!")
	end
end
