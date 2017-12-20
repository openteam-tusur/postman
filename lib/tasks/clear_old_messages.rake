require 'progress_bar'

desc 'Clear messages older than one year'
task clear_old_messages: :environment do
  old_messages = Message.where('created_at < ?', Time.zone.now - 1.year)
  bar = ProgressBar.new(old_messages.count)

  old_messages.each do |message|
    message.destroy

    bar.increment!
  end
end
