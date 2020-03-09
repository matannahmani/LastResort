desc "requestings users to updated there base snapshots"
task take_base_snapshot: :environment do
  puts "Chainging all users to take snapshot of base"
  User.all.update(imgupdate: true)
  puts "Snapshot is on for all users!"
end

desc "resting raid counter!"
task rest_raid_counter: :environment do
  puts "Resting raid counter!"
  User.all.update(raidcount: 0)
  puts "12 Hours has passed!"
end
