set :output, 'log/whenever.log'
set :chronic_options, hours24: true

every 1.day, at: '22:00' do
  rake 'clear_old_messages'
end
