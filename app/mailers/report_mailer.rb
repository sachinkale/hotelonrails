class ReportMailer < ActionMailer::Base
  default :from => "youremail@yourhotel.com"

  def daily_report(checkins)
    @checkins = checkins
    mail(:to => "reportmail@yourhotel.in",
     :subject => "Daily Report")
  end
end
