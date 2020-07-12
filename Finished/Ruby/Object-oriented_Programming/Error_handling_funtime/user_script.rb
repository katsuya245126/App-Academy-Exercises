require_relative 'super_useful'

puts "'five' == #{convert_to_int('five')}"

feed_me_a_fruit

begin
  sam = BestFriend.new('John', 3, 'cooming')
rescue StandardError => e
  puts e.message
else
  sam.talk_about_friendship
  sam.do_friendstuff
  sam.give_friendship_bracelet
end
