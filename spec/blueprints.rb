require 'faker'
require 'machinist'
require "machinist/active_record"

Sham.permalink { Faker::Name.name.gsub(/[^\w]+/, '-') }

Sham.ip_address do
  quads = []
  4.times { quads << (2..254).collect.rand.to_s }
  quads.join('.')
end

Sham.hostname do
  Faker::Internet.domain_word + '.' + Faker::Internet.domain_name
end

Bucket.blueprint do
  permalink { Sham.permalink }
end

User.blueprint do
  permalink { Sham.permalink }
end

Adjustment.blueprint do
  user   { User.make }
  bucket { Bucket.make }
  value  { (-10..10).collect.rand }
end

Client.blueprint do
  hostname
  ip_address
end
