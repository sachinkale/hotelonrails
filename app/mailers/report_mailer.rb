class ReportMailer < ActionMailer::Base
  default :from => "brightspark@gmail.com"

  def daily_report(checkins)
    @checkins = checkins
    mail(:to => "sachin@hotelsahara.in",
     :subject => "Daily Report")
  end
end
