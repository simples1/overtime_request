namespace :notification do
  desc "Sens SMS notification to employees asking them to log overtime"
  task sms: :environment do

  	#schedule to run every sunday @5pm
  	#iterate over all employee
  	#skip AdminUser
  	#Send a msg that has instrctions and a link to log time

  	User.all.each do |user|
  		SmsTool.send_sms()
  	end
  end

end
